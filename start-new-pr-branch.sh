#!/usr/bin/env bash
set -euo pipefail

# Create a clean branch from main/master for a brand-new PR.
# Usage: ./start-new-pr-branch.sh <new-branch-name> [base-branch]

NEW_BRANCH="${1:-}"
BASE_BRANCH="${2:-}"

if [[ -z "$NEW_BRANCH" ]]; then
  echo "Usage: ./start-new-pr-branch.sh <new-branch-name> [base-branch]"
  exit 1
fi

if [[ -z "$BASE_BRANCH" ]]; then
  if git show-ref --verify --quiet refs/heads/main; then
    BASE_BRANCH="main"
  elif git show-ref --verify --quiet refs/heads/master; then
    BASE_BRANCH="master"
  else
    echo "❌ Could not find local main/master. Pass base explicitly:"
    echo "   ./start-new-pr-branch.sh $NEW_BRANCH <base-branch>"
    exit 1
  fi
fi

if git show-ref --verify --quiet "refs/heads/$NEW_BRANCH"; then
  echo "❌ Branch '$NEW_BRANCH' already exists locally. Choose a different name."
  exit 1
fi

if git remote get-url origin >/dev/null 2>&1; then
  echo "Fetching latest refs from origin..."
  git fetch origin
fi

echo "Checking out base branch '$BASE_BRANCH'..."
git checkout "$BASE_BRANCH"

echo "Pulling latest '$BASE_BRANCH'..."
if git remote get-url origin >/dev/null 2>&1; then
  git pull --ff-only origin "$BASE_BRANCH"
else
  echo "⚠️ No origin remote found. Skipping pull."
fi

echo "Creating new branch '$NEW_BRANCH'..."
git checkout -b "$NEW_BRANCH"

echo "✅ New clean branch created from '$BASE_BRANCH': $NEW_BRANCH"
echo "Next steps:"
echo "  1) Make your changes"
echo "  2) git add . && git commit -m 'Your message'"
echo "  3) git push -u origin $NEW_BRANCH"
echo "  4) Open a new PR on GitHub"
