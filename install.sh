#!/bin/bash
set -eu

home_dir_path="$(dirname $(greadlink -f $0))/home"

for file_path in $home_dir_path/.??*
do
  if [[ $file_path == *.config ]]
  then
    continue
  fi

  echo $file_path
  ln -sfv $file_path ~/
done

for file_path in $home_dir_path/.config/*
do
  echo $file_path
  ln -sfv $file_path ~/.config/
done
