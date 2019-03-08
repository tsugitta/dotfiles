#!/bin/bash
set -eu

vscode_dir_path="$(dirname $(greadlink -f $0))/vscode"

# settings

for file_path in $vscode_dir_path/*.json
do
  echo $file_path
  ln -sfv $file_path ~/Library/Application\ Support/Code/User
done

# extension

cat $vscode_dir_path/extensions.txt | while read line
do
  code --install-extension $line
done
