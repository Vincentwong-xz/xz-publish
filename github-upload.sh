#!/bin/bash
# ============================================
# GitHub 文件上传脚本
# 使用方法：bash ~/github-upload.sh
# ============================================

# ---------- 仓库配置 ----------
REPOS=(
  "xz-workspace|Vincentwong-xz/xz-workspace|私人工作空间 🔒（存放所有个人文件）"
  "xz-publish|Vincentwong-xz/xz-publish|公开发布 🌐（分享给所有人的内容）"
  "xz-create|Vincentwong-xz/xz-create|Copilot Agents & Skills 合集 🌐"
)

# ---------- 获取 Token ----------
if [ -z "$GITHUB_TOKEN" ]; then
  read -rsp "🔑 请输入 GitHub Token（输入时不显示）: " TOKEN
  echo ""
else
  TOKEN="$GITHUB_TOKEN"
fi

# ---------- 上传单个文件 ----------
upload_file() {
  local repo="$1"
  local local_path="$2"
  local remote_path="$3"
  local message="${4:-update: $remote_path}"

  if [ ! -f "$local_path" ]; then
    echo "  ❌ 文件不存在：$local_path"
    return 1
  fi

  local content
  content=$(base64 -w 0 "$local_path")

  # 检查远程是否已有该文件（更新时需要 SHA）
  local sha
  sha=$(curl -s \
    -H "Authorization: token $TOKEN" \
    -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/repos/$repo/contents/$remote_path" \
    | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('sha',''))" 2>/dev/null)

  local body
  if [ -n "$sha" ]; then
    body="{\"message\":\"$message\",\"content\":\"$content\",\"sha\":\"$sha\"}"
  else
    body="{\"message\":\"$message\",\"content\":\"$content\"}"
  fi

  result=$(curl -s -X PUT \
    -H "Authorization: token $TOKEN" \
    -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/repos/$repo/contents/$remote_path" \
    -d "$body")

  echo "$result" | python3 -c "
import sys, json
d = json.load(sys.stdin)
if 'content' in d:
    print('  ✅ ' + d['content']['name'] + ' → ' + d['content']['html_url'])
else:
    print('  ❌ ' + d.get('message', str(d)))
"
}

# ---------- 同步 Copilot agents + skills ----------
sync_copilot() {
  local repo="$1"
  echo ""
  echo "🔄 同步 agents..."
  for f in ~/.copilot/agents/*.agent.md; do
    [ -f "$f" ] || continue
    upload_file "$repo" "$f" "agents/$(basename $f)" "sync: agents/$(basename $f)"
  done

  echo "🔄 同步 skills..."
  for dir in ~/.copilot/skills/*/; do
    [ -d "$dir" ] || continue
    skill=$(basename "$dir")
    [ -f "$dir/SKILL.md" ] && \
      upload_file "$repo" "$dir/SKILL.md" "skills/$skill/SKILL.md" "sync: skills/$skill/SKILL.md"
  done

  echo ""
  echo "✅ 同步完成！https://github.com/$repo"
}

# ---------- 选择仓库 ----------
echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║           GitHub 上传助手                        ║"
echo "╠══════════════════════════════════════════════════╣"
for i in "${!REPOS[@]}"; do
  IFS='|' read -r name repo desc <<< "${REPOS[$i]}"
  printf "║  %d) %-44s║\n" "$((i+1))" "$desc"
done
echo "╚══════════════════════════════════════════════════╝"
echo ""
read -rp "选择目标仓库 (1-${#REPOS[@]}): " repo_choice
repo_choice=$((repo_choice - 1))

if [ "$repo_choice" -lt 0 ] || [ "$repo_choice" -ge "${#REPOS[@]}" ]; then
  echo "❌ 无效选择"; exit 1
fi

IFS='|' read -r SELECTED_NAME SELECTED_REPO SELECTED_DESC <<< "${REPOS[$repo_choice]}"
echo ""
echo "📁 目标仓库：$SELECTED_DESC"
echo ""

# ---------- 选择操作 ----------
echo "选择操作："
echo "  1) 上传单个文件"
echo "  2) 一键同步全部 agents + skills"
echo ""
read -rp "操作 (1/2): " action

case $action in
  1)
    read -rp "本地路径（如 ~/.copilot/agents/xxx.agent.md）: " lp
    read -rp "仓库内路径（如 agents/xxx.agent.md）: " rp
    read -rp "提交说明（回车跳过）: " msg
    lp="${lp/#\~/$HOME}"
    upload_file "$SELECTED_REPO" "$lp" "$rp" "${msg:-update: $rp}"
    ;;
  2)
    sync_copilot "$SELECTED_REPO"
    ;;
  *)
    echo "❌ 无效选择"
    ;;
esac
