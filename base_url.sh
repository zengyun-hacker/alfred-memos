#!/bin/bash

# 获取用户输入的 URL
url="$1"

# 验证 URL 格式
if [[ ! "$url" =~ ^https?:// ]]; then
  url="https://$url"
fi

# 确保 URL 以斜杠结尾
if [[ ! "$url" =~ /$ ]]; then
  url="${url}/"
fi

# 定义数据目录和文件
data_dir="$HOME/Library/Application Support/Alfred/Workflow Data/me.codingtime.alfred.memos"
url_file="$data_dir/base_url.txt"

# 创建数据目录
mkdir -p "$data_dir"

# 检查是否已有保存的 URL
if [ -f "$url_file" ]; then
  existing_url=$(cat "$url_file")
  
  # 显示已有 URL 通知
  notification_title="Memos URL Already Exists"
  notification_message="$existing_url"
  
  # 返回 Alfred 结果
  cat << EOB
{"items":[
  {
    "title":"$notification_title",
    "subtitle":"$notification_message",
    "arg":"$notification_title|$notification_message",
    "icon":{"path":"icon.png"},
	"variables": {"notification_title": "$notification_title", "notification_message": "$notification_message"}

  }
]}
EOB
else
  # 保存新 URL
  echo "$url" > "$url_file"
  
  # 显示保存成功通知
  notification_title="Memos URL Saved Successfully"
  notification_message="$url"
  
  # 返回 Alfred 结果
  cat << EOB
{"items":[
  {
    "title":"$notification_title",
    "subtitle":"$notification_message",
    "arg":"$notification_title|$notification_message",
    "icon":{"path":"icon.png"},
	"variables": {"notification_title": "$notification_title", "notification_message": "$notification_message"}
  }
]}
EOB
fi