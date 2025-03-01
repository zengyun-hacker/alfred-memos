#!/bin/bash

# 获取用户输入的内容
content="$1"

# 检查内容是否为空
if [ -z "$content" ]; then
  notification_title="Error"
  notification_message="Content cannot be empty"
  
  # 输出错误信息
  cat << EOB
{"alfredworkflow": {"arg": "$notification_message", "variables": {"notification_title": "$notification_title", "notification_message": "$notification_message"}}}
EOB
  exit 1
fi

# 定义数据目录和文件
data_dir="$HOME/Library/Application Support/Alfred/Workflow Data/me.codingtime.alfred.memos"
token_file="$data_dir/access_token.txt"
url_file="$data_dir/base_url.txt"

# 检查是否已有保存的 base URL
if [ ! -f "$url_file" ]; then
  notification_title="Error"
  notification_message="Please set base URL first with 'memos your-url'"
  
  # 输出错误信息
  cat << EOB
{"alfredworkflow": {"arg": "$notification_message", "variables": {"notification_title": "$notification_title", "notification_message": "$notification_message"}}}
EOB
  exit 1
fi

# 检查是否已有保存的 token
if [ ! -f "$token_file" ]; then
  notification_title="Error"
  notification_message="Please set access token first with 'memos your-token'"
  
  # 输出错误信息
  cat << EOB
{"alfredworkflow": {"arg": "$notification_message", "variables": {"notification_title": "$notification_title", "notification_message": "$notification_message"}}}
EOB
  exit 1
fi

# 读取 base URL 和 access token
base_url=$(cat "$url_file")
access_token=$(cat "$token_file")

# 构建请求 URL
api_url="${base_url}api/v1/memos"

# 构建请求 JSON 数据
json_data=$(cat << EOF
{
  "state": "STATE_UNSPECIFIED",
  "content": "$content",
  "visibility": "PRIVATE"
}
EOF
)

# 发送 POST 请求
response=$(curl -s -w "\n%{http_code}" \
  -X POST "$api_url" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $access_token" \
  -d "$json_data")

# 提取响应体和状态码
http_code=$(echo "$response" | tail -n1)
response_body=$(echo "$response" | sed '$d')

# 检查请求是否成功
if [ "$http_code" -eq 200 ] || [ "$http_code" -eq 201 ]; then
  # 提取 memo ID (如果需要)
  memo_id=$(echo "$response_body" | grep -o '"id":[0-9]*' | cut -d':' -f2)
  
  notification_title="Memo Created Successfully"
  notification_message="Your memo has been posted"
  
  # 如果想要更详细的成功信息，可以使用以下行代替
  # notification_message="Memo #$memo_id created: ${content:0:30}..."
else
  # 处理错误
  error_message=$(echo "$response_body" | grep -o '"message":"[^"]*' | cut -d'"' -f4)
  
  if [ -z "$error_message" ]; then
    error_message="HTTP error $http_code"
  fi
  
  notification_title="Error Creating Memo"
  notification_message="$error_message"
fi

# 输出带变量的 JSON
cat << EOB
{"alfredworkflow": {"arg": "$notification_message", "variables": {"notification_title": "$notification_title", "notification_message": "$notification_message"}}}
EOB