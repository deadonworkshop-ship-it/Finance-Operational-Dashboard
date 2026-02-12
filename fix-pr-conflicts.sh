#!/usr/bin/env bash
set -euo pipefail

# Helper to bring current branch up to date with main/master and surface conflicts clearly.
# Usage: ./fix-pr-conflicts.sh [target-branch]

TARGET_BRANCH="${1:-}"
CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"

if [[ -z "$TARGET_BRANCH" ]]; then
  if git show-ref --verify --quiet refs/heads/main; then
    TARGET_BRANCH="main"
  elif git show-ref --verify --quiet refs/heads/master; then
    TARGET_BRANCH="master"
  else
    echo "❌ Could not find local 'main' or 'master'."
    echo "Run: git branch"
    echo "Then retry with explicit target branch, e.g.: ./fix-pr-conflicts.sh develop"
    exit 1
  fi
fi

if [[ "$CURRENT_BRANCH" == "$TARGET_BRANCH" ]]; then
  echo "❌ You are currently on '$TARGET_BRANCH'."
  echo "Checkout your feature branch first, then rerun this script."
  exit 1
fi

echo "Current branch : $CURRENT_BRANCH"
echo "Merge target   : $TARGET_BRANCH"

echo
if git remote get-url origin >/dev/null 2>&1; then
  echo "Fetching latest refs from origin..."
  git fetch origin
else
  echo "⚠️ No 'origin' remote found. Skipping fetch."
fi

echo "Merging '$TARGET_BRANCH' into '$CURRENT_BRANCH'..."
if git merge "$TARGET_BRANCH"; then
  echo
  echo "✅ Merge completed with no conflicts."
  echo "Next step: git push"
  exit 0
fi

echo
cat <<'MSG'
⚠️ Merge conflicts detected.
Resolve each conflicted file by removing markers:
  <<<<<<< HEAD
  =======
  >>>>>>> <branch>

Then run:
  git add .
  git commit -m "Resolve merge conflicts"
  git push
MSG

exit 1
