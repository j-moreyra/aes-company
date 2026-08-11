#!/usr/bin/env bash
# Refresh the routine-context copies from their sources under context/.
#
# Run it after editing any source file:
#   ./routine-context/sync.sh
#
# The copies in this folder are generated. Edit the sources, never the copies.
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
dest="$repo_root/routine-context"

# The files the Morning AES brief Routine reads out of the cloned repository.
# Keep this list matched to references/routines/morning-brief.md (STEP 1 and STEP 3).
sources=(
  "context/watchlist.md"
  "context/active-projects.md"
)

commit="$(git -C "$repo_root" rev-parse --short HEAD)"
taken="$(date +%Y-%m-%d)"

for src in "${sources[@]}"; do
  if [ ! -f "$repo_root/$src" ]; then
    echo "sync.sh: missing source $src" >&2
    exit 1
  fi
  out="$dest/$(basename "$src")"
  {
    printf '<!--\n'
    printf 'GENERATED COPY - DO NOT EDIT\n'
    printf 'Source:  %s\n' "$src"
    printf 'Commit:  %s\n' "$commit"
    printf 'Taken:   %s\n' "$taken"
    printf 'Refresh: ./routine-context/sync.sh\n'
    printf 'Edit the source file. Anything typed here is lost on the next sync.\n'
    printf '%s\n\n' '-->'
    cat "$repo_root/$src"
  } > "$out"
  echo "wrote routine-context/$(basename "$src")  (from $src @ $commit)"
done
