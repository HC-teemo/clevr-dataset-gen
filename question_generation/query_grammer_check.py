import json
import argparse
import logging
import re
from tqdm import tqdm
from neo4j import GraphDatabase
from neo4j.exceptions import Neo4jError

# 参数解析
parser = argparse.ArgumentParser(description='验证Cypher查询结果与预期答案是否一致')

# Neo4j连接参数
parser.add_argument('--neo4j-uri', default="bolt:localhost:7474", type=str, help='Neo4j连接URI (如: bolt://localhost:7687)')
parser.add_argument('--neo4j-user', default="neo4j", type=str, help='Neo4j用户名')
parser.add_argument('--neo4j-password', default="123", type=str, help='Neo4j密码')

# 文件路径参数
parser.add_argument('--questions-json', default="../output/CLEVR_questions.json", type=str, help='问题JSON文件路径')
parser.add_argument('--log-file', default="../output/questions_check.log", type=str, help='错误日志文件路径')



def execute_query(driver, query, question):
    """执行Cypher查询并返回结果"""
    try:
        with driver.session() as session:
            result = session.run(query)
            data = [record.value(0) for record in result]
            return data
    except Neo4jError as e:
        logging.error(f"问题{question.get('image_index')}: {question.get('question_index')}查询执行错误: {str(e)}")
        return None

def validate_questions(args):
    """读取JSON文件并验证所有问题的Cypher查询"""
    # 配置日志
    logging.basicConfig(
        filename=args.log_file,
        level=logging.ERROR,
        format='%(asctime)s - %(levelname)s - %(message)s'
    )

    # 初始化计数器
    pass_count = 0
    error_count = 0
    checked_count = 0

    # 连接Neo4j
    driver = GraphDatabase.driver(args.neo4j_uri, auth=(args.neo4j_user, args.neo4j_password))

    try:
        # 读取JSON文件
        with open(args.questions_json, 'r', encoding='utf-8') as f:
            data = json.load(f)

        # 遍历所有问题
        for idx, question in enumerate(tqdm(data.get('questions', []))):
            cypher_query = question.get('query')
            expected_answer = question.get('answer')
            image_id = question.get('image_index')
            question_id = question.get('question_index', f'question_{idx}')

            cypher_query = re.sub(r'<([^>]+)>', r'(\1)', cypher_query)
            cypher_query = re.sub(r'~\[([^\[\]]+)\]~~', r'-[\1]->', cypher_query)
            cypher_query = re.sub(r'~~\[([^\[\]]+)\]~', r'<-[\1]-', cypher_query)


            cypher_query = f"MATCH (i:Image) WHERE i.image_index={image_id} WITH i\n" + cypher_query
            # 执行查询
            # print(f"正在验证问题{image_id}: {question_id}...")
            actual_result = execute_query(driver, cypher_query, question)

            # 对比结果
            if actual_result is None or len(actual_result) == 0 or str(actual_result[0]) != str(expected_answer):
                error_msg = f"问题 {image_id}: {question_id} 结果不匹配\n"
                error_msg += f"问题来自模板 {question.get('template_filename')}\n"
                error_msg += f"问题是: {question.get('question')}\n"
                error_msg += f"查询: {cypher_query}\n"
                error_msg += f"预期答案: {expected_answer}\n"
                error_msg += f"实际结果: {actual_result}\n"
                logging.error(error_msg)
                error_count += 1
            else:
                # print(f"问题 {image_id}: {question_id} 正确")
                pass_count += 1

            # 更新进度条后缀信息
            checked_count += 1
            # tqdm.set_postfix_str(tqdm, f"Pass: {pass_count} | NoPass: {error_count} | Checked: {checked_count}", refresh=True)

        # 打印最终统计结果
        print(f"\n===== 图片检查完成 =====")
        print(f"总检查数: {checked_count}")
        print(f"通过数: {pass_count}")
        print(f"未通过数: {error_count}")
        print(f"通过率: {pass_count / checked_count:.2%}\n")
        return error_count

    finally:
        # 确保连接关闭
        driver.close()

if __name__ == "__main__":
    # 解析参数并运行验证
    args = parser.parse_args()
    validate_questions(args)
