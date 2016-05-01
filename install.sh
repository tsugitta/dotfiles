#!/bin/bash

for f in .??*
do
  [[ "$f" == ".git" ]] && continue
  [[ "$f" == ".DS_Store" ]] && continue

  ln -sfv "$HOME"/dotfiles/"$f" "$HOME"/"$f"
done
