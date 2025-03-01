query="hello"

echo '{"content":\"$query\"}'
curl 'http://allchild.synology.me:5230/api/v1/memo?openId=xxx' -H 'Content-Type: application/json' --data-raw '{"content":\""${query}"\"}'