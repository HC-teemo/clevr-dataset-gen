import json
import sys

def compare_json(obj1, obj2, skip_keys=None, path=""):
    """
    递归比较两个 JSON 对象，输出不同之处。
    :param obj1: 第一个 JSON 对象
    :param obj2: 第二个 JSON 对象
    :param skip_keys: 跳过的键列表
    :param path: 当前比较的路径
    :return: 不同之处的列表
    """
    differences = []
    skip_keys = skip_keys or []

    if isinstance(obj1, dict) and isinstance(obj2, dict):
        # 获取两个字典的所有键
        keys1 = set(obj1.keys())
        keys2 = set(obj2.keys())

        for k in skip_keys:
            keys1.discard(k)
            keys2.discard(k)
        
        # 找到缺失的键
        for key in keys1 - keys2:
            differences.append(f"{path}/{key}: 存在于第一个对象，但不存在于第二个对象")
        for key in keys2 - keys1:
            differences.append(f"{path}/{key}: 存在于第二个对象，但不存在于第一个对象")
        
        # 比较共同的键
        for key in keys1 & keys2:
            if key in skip_keys:
                continue
            differences.extend(compare_json(obj1[key], obj2[key], skip_keys, f"{path}/{key}"))
    elif isinstance(obj1, list) and isinstance(obj2, list):
        # 比较列表内容
        if len(obj1) != len(obj2):
            differences.append(f"{path}: 列表长度不同")
        else:
            for i, (item1, item2) in enumerate(zip(obj1, obj2)):
                differences.extend(compare_json(item1, item2, skip_keys, f"{path}[{i}]"))
    else:
        # 比较值是否相同
        if obj1 != obj2:
            differences.append(f"{path}: 值不同 ({obj1} != {obj2})")
    
    return differences

def main(file1, file2, skip_keys):
    try:
        # 读取 JSON 文件
        with open(file1, 'r', encoding='utf-8') as f1:
            json1 = json.load(f1)
        with open(file2, 'r', encoding='utf-8') as f2:
            json2 = json.load(f2)
        
        # 比较 JSON 对象
        differences = compare_json(json1, json2, skip_keys)
        
        if differences:
            print("两个 JSON 对象不同，具体差异如下：")
            for diff in differences:
                print(diff)
        else:
            print("两个 JSON 对象相同！")
    except FileNotFoundError as e:
        print(f"文件未找到: {e}")
    except json.JSONDecodeError as e:
        print(f"JSON 文件解析错误: {e}")
    except Exception as e:
        print(f"发生错误: {e}")

if __name__ == "__main__":
    # 检查参数数量
    if len(sys.argv) < 3:
        print("使用方法: python check_templates.py file1.json file2.json")
        sys.exit(1)
    
    # 获取文件路径
    file1 = sys.argv[1]
    file2 = sys.argv[2]
    
    # 获取跳过的键列表
    skip_keys = ['query','query2']
    
    # 执行比较
    main(file1, file2, skip_keys)