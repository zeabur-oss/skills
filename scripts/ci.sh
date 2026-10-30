#!/usr/bin/env bash
# One CI job, as .github/workflows/ci.yml runs it (through the shared workflow of zeabur-oss/.github)
# and as anyone runs it locally.
#
#   scripts/ci.sh <job>      # run one job; it enters the Nix dev shell itself
#   scripts/ci.sh --list     # the job names
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$root"

jobs=(skills lint prose)

if [[ "${1:-}" == --list ]]; then
  printf '%s\n' "${jobs[@]}"
  exit 0
fi
job="${1:?usage: scripts/ci.sh <job> | --list}"
printf '%s\n' "${jobs[@]}" | grep -qx -- "$job" ||
  { echo "error: no job named $job (scripts/ci.sh --list)" >&2; exit 1; }

# The marker tells a re-run inside the dev shell apart from a call outside it.
if [[ -z "${ZEABUR_CI_SHELL:-}" ]]; then
  export ZEABUR_CI_SHELL=1
  exec nix develop "$root" --command "$0" "$@"
fi

# Each skills/<name>/SKILL.md has a name equal to <name> and a description.
check_skills() {
  local status=0 file dir name description
  for file in skills/*/SKILL.md; do
    dir=$(basename "$(dirname "$file")")
    name=$(yq --front-matter=extract '.name // ""' "$file")
    description=$(yq --front-matter=extract '.description // ""' "$file")
    [[ "$name" == "$dir" ]] || { echo "$file: name is '$name', not '$dir'" >&2; status=1; }
    [[ -n "$description" ]] || { echo "$file: no description" >&2; status=1; }
  done
  for dir in skills/*/; do
    [[ -f "$dir/SKILL.md" ]] || { echo "$dir: no SKILL.md" >&2; status=1; }
  done
  return "$status"
}

case "$job" in
  skills)
    check_skills
    ;;
  lint)
    shellcheck scripts/*.sh
    actionlint
    nixfmt --check flake.nix nix/*.nix
    ;;
  prose)
    # .vale.ini is the shipped sample with this repository's StylesPath.
    diff <(grep -v '^StylesPath' skills/zeabur-writing/vale/vale.ini | sed '1,2d') \
      <(grep -v '^StylesPath' .vale.ini | sed '1,2d')
    ./scripts/test-writing.sh
    # no-ai-flavour lists the words it bans; it is kept as its author wrote it.
    git ls-files -z '*.md' '*.mdx' ':!:tests/**' ':!:skills/no-ai-flavour/**' | xargs -0 vale
    ;;
esac
