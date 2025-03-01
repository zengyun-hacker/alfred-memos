#!/bin/bash

# 获取用户输入的 access_token
access_token="$1"

# 检查 token 是否为空
if [ -z "$access_token" ]; then
  notification_title="Error"
  notification_message="Access token cannot be empty"
  
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

# 创建数据目录
mkdir -p "$data_dir"

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
if [ -f "$token_file" ]; then
  existing_token=$(cat "$token_file")
  
  # 询问是否覆盖现有 token
  notification_title="Access Token Already Exists"
  notification_message="Previous token: ${existing_token:0:5}...${existing_token: -5} (Overwritten)"
  
  # 保存新 token (覆盖)
  echo "$access_token" > "$token_file"
else
  # 保存新 token
  echo "$access_token" > "$token_file"
  
  # 设置保存成功通知
  notification_title="Access Token Saved Successfully"
  notification_message="Token: ${access_token:0:5}...${access_token: -5} (store in local)"
fi

# 输出带变量的 JSON
cat << EOB
{"alfredworkflow": {"arg": "$notification_message", "variables": {"notification_title": "$notification_title", "notification_message": "$notification_message"}}}
EOB