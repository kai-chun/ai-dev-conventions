#!/usr/bin/env bash
# 以 symlink 把本 repo 的 Claude Code 設定部署到 ~/.claude。
# 冪等：連結已指向正確位置時跳過；目標存在但不是 symlink 時中止，不覆蓋。
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="${HOME}/.claude"

link() {
    local src="$1" dst="$2"
    if [[ -L "$dst" ]]; then
        if [[ "$(readlink "$dst")" == "$src" ]]; then
            echo "ok      $dst"
            return
        fi
        echo "relink  $dst (was $(readlink "$dst"))"
        ln -sfn "$src" "$dst"
        return
    fi
    if [[ -e "$dst" ]]; then
        echo "ABORT: $dst exists and is not a symlink; resolve manually." >&2
        exit 1
    fi
    ln -s "$src" "$dst"
    echo "link    $dst -> $src"
}

# Global CLAUDE.md
link "${REPO_DIR}/CLAUDE.md" "${CLAUDE_DIR}/CLAUDE.md"

# Skills
mkdir -p "${CLAUDE_DIR}/skills"
for skill in "${REPO_DIR}/skills"/*/; do
    name="$(basename "$skill")"
    link "${skill%/}" "${CLAUDE_DIR}/skills/${name}"
done

echo "done"
