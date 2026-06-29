#!/usr/bin/env bash
#
# link-agents-skills.sh
# Symlink every skill in ~/.agents/skills/ into ~/.claude/skills/ so that
# Claude Code (terminal) discovers them. Safe to re-run (idempotent).
#
# Usage:
#   bash link-agents-skills.sh           # link them
#   bash link-agents-skills.sh --dry-run # show what would happen, change nothing
#   bash link-agents-skills.sh --copy    # copy instead of symlink (decouples from source)
#   bash link-agents-skills.sh --unlink  # remove only the symlinks this script created
#
set -euo pipefail

SRC="$HOME/.agents/skills"
DST="$HOME/.claude/skills"

MODE="link"
for arg in "$@"; do
  case "$arg" in
    --dry-run) MODE="dry" ;;
    --copy)    MODE="copy" ;;
    --unlink)  MODE="unlink" ;;
    -h|--help) grep '^#' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "Unknown option: $arg" >&2; exit 2 ;;
  esac
done

[ -d "$SRC" ] || { echo "Source not found: $SRC" >&2; exit 1; }
mkdir -p "$DST"

linked=0 skipped=0 conflicts=0 removed=0

for dir in "$SRC"/*/; do
  [ -d "$dir" ] || continue
  name="$(basename "$dir")"
  [ -f "$dir/SKILL.md" ] || { echo "skip (no SKILL.md): $name"; skipped=$((skipped+1)); continue; }
  target="$DST/$name"

  if [ "$MODE" = "unlink" ]; then
    if [ -L "$target" ] && [ "$(readlink "$target")" = "${dir%/}" ]; then
      rm "$target"; echo "unlinked: $name"; removed=$((removed+1))
    fi
    continue
  fi

  # A real (non-symlink) dir/file already there -> never clobber.
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "CONFLICT (real path exists, left untouched): $name"
    conflicts=$((conflicts+1)); continue
  fi

  # Existing symlink that already points where we want -> nothing to do.
  if [ -L "$target" ] && [ "$(readlink "$target")" = "${dir%/}" ]; then
    echo "ok (already linked): $name"; skipped=$((skipped+1)); continue
  fi

  case "$MODE" in
    dry)  echo "would link: $name -> ${dir%/}" ;;
    link) ln -sfn "${dir%/}" "$target"; echo "linked: $name"; linked=$((linked+1)) ;;
    copy) rm -rf "$target"; cp -R "${dir%/}" "$target"; echo "copied: $name"; linked=$((linked+1)) ;;
  esac
done

echo "----"
echo "mode=$MODE  linked/copied=$linked  skipped=$skipped  conflicts=$conflicts  removed=$removed"
echo "destination: $DST"
[ "$conflicts" -gt 0 ] && echo "Note: conflicts were left untouched so nothing of yours is overwritten."
echo "Done. Restart Claude Code (terminal) to pick up newly linked skills."
