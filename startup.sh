#!/bin/bash
cp bash_aliases ~/.bash_aliases
cp gitconfig ~/.gitconfig
cp gitignore_global ~/.gitignore_global
cp inputrc ~/.inputrc
cp vimrc ~/.vimrc
mkdir -p ~/.claude
cp .claude/settings.json ~/.claude/
cp .claude/statusline-command.sh ~/.claude/
cp .claude/CLAUDE.md ~/.claude/
mount-efs
