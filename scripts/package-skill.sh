#!/bin/bash
# Modified by stellariums for this adaptation.
set -euo pipefail

umask 077

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE="$(cd "$SCRIPT_DIR/.." && pwd)"
OUTPUT="${1:-$(dirname "$SOURCE")/wechat-chat-decrypt-skill.zip}"
OUTPUT="$(python3 -c 'import sys; from pathlib import Path; print(Path(sys.argv[1]).resolve())' "$OUTPUT")"

case "$OUTPUT" in
  "$SOURCE"|"$SOURCE"/*)
    printf '%s\n' 'Output zip must be outside the skill directory.' >&2
    exit 1
    ;;
esac

if [[ "$(git -C "$SOURCE" rev-parse --show-prefix)" != "" ]]; then
  printf '%s\n' 'Run packaging from a standalone Git checkout of the Skill.' >&2
  exit 1
fi

mkdir -p "$(dirname "$OUTPUT")"
git -C "$SOURCE" archive --format=zip --output="$OUTPUT" --prefix=wechat-chat-decrypt/ HEAD
printf 'Created %s\n' "$OUTPUT"
