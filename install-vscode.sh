#!/bin/bash
set -eu

vscode_dir_path="$(dirname $(greadlink -f $0))/vscode"

# settings
paths=(
  $vscode_dir_path/keybindings.json
  $vscode_dir_path/settings.json
  $vscode_dir_path/snippets/
)

for file_path in ${paths[@]}
do
  echo $file_path
  ln -sfv $file_path ~/Library/Application\ Support/Code/User
done

# extension

cat $vscode_dir_path/extensions.txt | while read line
do
  code --install-extension $line
done
