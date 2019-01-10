#!/bin/bash
set -eu

home_dir_path="$(dirname $(greadlink -f $0))/home"

for file_path in $home_dir_path/.??*
do
  echo $file_path
  ln -sfv $file_path ~/
done
