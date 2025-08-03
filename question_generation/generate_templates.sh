#!/bin/bash

# 定义目录路径
TEMPLATE_DIR="meta_templates"
CLEVR_TEMP_DIR="CLEVR_1.0_templates_bak"
OUTPUT_DIR="CLEVR_1.0_templates"

# 检查目录是否存在
if [ ! -d "$TEMPLATE_DIR" ]; then
  echo "目录 $TEMPLATE_DIR 不存在！"
  exit 1
fi

# 遍历目录下的所有 .jsonnet 文件
for file in "$TEMPLATE_DIR"/*.jsonnet; do
  # 检查是否有 .jsonnet 文件
  if [ ! -e "$file" ]; then
    echo "没有找到 .jsonnet 文件！"
    exit 1
  fi

  # 获取文件名（不含扩展名）
  filename=$(basename "$file" .jsonnet)

  # 输出转换信息
  echo "正在处理文件: $file -> $filename.json"

  # 使用 jsonnet 命令生成对应的 .json 文件
  jsonnet "$file" -o "$OUTPUT_DIR/$filename.json"

  # 检查转换是否成功
  if [ $? -eq 0 ]; then
    echo "成功生成: $OUTPUT_DIR/$filename.json"
  else
    echo "转换失败: $file"
  fi

  echo "开始检查"
  python check_templates.py "$OUTPUT_DIR/$filename.json" "$CLEVR_TEMP_DIR/$filename.json"
done