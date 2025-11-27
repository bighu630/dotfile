#!/bin/bash
# This script pushes changes in the main repository and all its submodules.
# It will pull changes for each submodule before pushing to avoid non-fast-forward errors.

# Exit immediately if a command exits with a non-zero status.
set -e

echo "🚀 Starting dotfile push process..."

# 1. Pull latest changes for the main repository to avoid conflicts.
echo "⬇️  Pulling latest changes for the main repository..."
git pull

# 2. Iterate over each submodule to pull, commit, and push its changes.
echo "🔄 Processing each submodule..."
git submodule foreach --recursive '
    echo "---"
    echo "Processing submodule: ${name} at ${path}"

    # Check if the submodule is on a branch.
    branch_name=$(git rev-parse --abbrev-ref HEAD)
    if [ "$branch_name" = "HEAD" ]; then
        echo "  ⚠️ Submodule is in a detached HEAD state. Skipping."
    else
        echo "  On branch '\''$branch_name'\''. Pulling latest changes..."
        # Pull with rebase to avoid merge commits for local changes.
        git pull --rebase

        echo "  Staging all changes..."
        git add .

        # Commit only if there are staged changes.
        if ! git diff-index --quiet --cached HEAD; then
            echo "  Changes found. Committing..."
            git commit -m "chore: Automated update"
        else
            echo "  No new changes to commit."
        fi

        echo "  Pushing submodule changes..."
        git push
    fi
    echo "---"
    echo ""
'

# 3. Stage the updated submodule references in the main repository.
echo "⬆️  Staging updated submodule references in the main repository..."
git add .

# 4. Commit and push the main repository if there are any changes.
# Use git status --porcelain to check for changes to be committed.
if [ -n "$(git status --porcelain)" ]; then
    echo "  Main repository has updates. Committing and pushing..."
    git commit -m "chore: Update submodules"
    git push
else
    echo "  Main repository is already up-to-date."
fi

echo "✅ Push process finished successfully."
notify-send "Dotfiles Pushed" "All repositories have been pushed successfully." -i "dcc_nav_update" -u low