#!/usr/bin/env bash
# 把 codebase-to-course 安装成 Codex / Claude Code 可调用的技能命令。
#   Codex        -> 输入 $codebase-to-course
#   Claude Code  -> 输入 /codebase-to-course
#
# 用法：
#   bash install.sh            # 拷贝安装
#   bash install.sh --link     # 软链安装（改仓库文件立即生效，推荐开发时用）
set -euo pipefail

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_NAME="codebase-to-course"
MODE="copy"
[ "${1:-}" = "--link" ] && MODE="link"

if [ ! -f "$SKILL_DIR/SKILL.md" ]; then
  echo "错误：在 $SKILL_DIR 里找不到 SKILL.md，请在仓库根目录运行本脚本。" >&2
  exit 1
fi

install_into() {
  local root="$1" label="$2"
  local dest="$root/$SKILL_NAME"
  mkdir -p "$root"
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "跳过 ${label}：${dest} 已存在（如需重装请先删除它）"
    return 0
  fi
  if [ "$MODE" = "link" ]; then
    ln -s "$SKILL_DIR" "$dest"
    echo "已软链 ${label}  → ${dest}"
  else
    cp -R "$SKILL_DIR" "$dest"
    echo "已拷贝 ${label}  → ${dest}"
  fi
}

echo "安装 ${SKILL_NAME}（${MODE} 模式）"
install_into "$HOME/.agents/skills" "Codex"
install_into "$HOME/.codex/skills"  "Codex(兼容路径)"
install_into "$HOME/.claude/skills" "Claude Code"
install_into "$HOME/.cursor/skills" "Cursor"

cat <<'TIP'

装好了，怎么调用：
  Codex        $codebase-to-course 把这个项目变成一门课
  Claude Code  /codebase-to-course 把这个项目变成一门课
  Cursor       @codebase-to-course（或在对话里直接说「把这个项目变成课」）

Codex 会自动检测新增技能；如果没出现，重启 Codex。
未指定项目时，直接说「把这个项目变成课」，技能会拿当前工作目录当输入。
TIP
