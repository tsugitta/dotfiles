#!/bin/bash

script_dir_path=$(dirname $(greadlink -f $0))

for file_path in $script_dir_path/.??*
do
  file_name=${file_path##*/}
  [[ $file_name == .git ]] && continue
  [[ $file_name == .gitignore ]] && continue
  [[ $file_name == .gitmodules ]] && continue
  [[ $file_name == .DS_Store ]] && continue

  ln -sfv $file_path ~/
done
