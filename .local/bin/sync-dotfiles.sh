#!/usr/bin/env bash

# Check UTILS_DIR
if [ -z "$UTILS_DIR" ]; then
    printf "UTILS_DIR is not set. " \
           "Please set it to the directory containing your utility scripts." \
           "\nE.g. 'export UTILS_DIR=~/.local/utils'"
    exit 1
fi

. ${UTILS_DIR}/colors.sh
. ${UTILS_DIR}/logging.sh

# Check $DOTFILES_DIR
if [ -z "$DOTFILES_DIR" ]; then
    error "DOTFILES_DIR is not set. " \
          "Please set it to the directory containing your dotfiles." \
          "E.g. 'export DOTFILES_DIR=~/.dotfiles'"
    exit 1
fi

# Sync dotfiles repo and ensure that dotfiles are tangled correctly afterward

# Navigate to the directory of this script (generally ~/.dotfiles/.bin)
cd $DOTFILES_DIR

#
# Stash any existing changes
#
info "Stashing existing changes..."
stash_result=$(git stash push -m "sync-dotfiles: Before syncing dotfiles")
needs_pop=1
if [ "$stash_result" = "No local changes to save" ]; then
    needs_pop=0
fi

#
# Pull updates from dotfiles repo
#
info "Pulling updates from dotfiles repo..."
echo
git pull origin master
echo

if [[ $needs_pop -eq 1 ]]; then
    info "Popping stashed changes..."
    echo
    git stash pop
fi

#
# Check for unmerged files
#
unmerged_files=$(git diff --name-only --diff-filter=U)
if [[ ! -z $unmerged_files ]]; then
   error "The following files have merge conflicts after popping the stash:"
   echo
   printf %"s\n" $unmerged_files  # Ensure newlines are printed
else
   # Run stow to ensure all new dotfiles are linked
   stow .
fi
