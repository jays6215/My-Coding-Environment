#!/bin/bash
cd $(dirname $0)
for dotfile in .?*
do
    echo "$PWD/$dotfile" $HOME
    if [ $dotfile != '..' ] && [ $dotfile != '.git' ]
    then
        ln -Fis "$PWD/$dotfile" $HOME
    fi
done
