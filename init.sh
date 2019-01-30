#!/bin/bash

function ask() {
  read -p "$1 (y/N): "
  case $(echo $REPLY | tr '[A-Z]' '[a-z]') in
    y|yes) echo 1 ;;
    *)     echo 0 ;;
  esac
}

install() {
  if [ -e $2 ] || [ -L $2 ]; then
    if [ $OVERWRITE ] || [ 1 == $(ask "$2 already exists. Overwrite?") ]; then
      rm -f $2
    else
      echo "$2 was left alone"
      return
    fi
  fi
  echo "Linking $1 -> $2"
  ln -s $1 $2
}

install_all() {
  while [ $# -gt 1 ]; do
    install $1 $2
    shift; shift
  done
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -o|--overwirte)
      OVERWRITE=1
      shift
      ;;
    *)
      echo $"Usage: $0 [-o]"
      exit 1
  esac
done


# if [[ $OVERWRITE ]]; then
#   echo "OVERWRITEING"
# else
#   echo "NAAAA"
# fi

# ask "Do you want to continue?"
# install .vimrc ~/.testrcc

# install $(pwd)/vimcpy ~/test_installer/vimcpy


install_all $(pwd)/vimcpy ~/test_installer/vimcpy
