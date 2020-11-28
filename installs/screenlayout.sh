#!/bin/bash

if [ $1 ]; then
  if [ -f ~/.screenlayout/display.sh ]; then
    echo "~/.screenlayout/display.sh already exists"
  elif [ ! -f ~/.dotfiles/screenlayout/$1 ]; then
    ln -s ~/.dotfiles/screenlayout/$1.sh ~/.screenlayout/display.sh
    echo "Linking $1.sh"
  else
    echo "~/.dotfiles/screenlayout/$1.sh does not exist"
  fi
fi
