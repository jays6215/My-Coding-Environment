#!/bin/bash
cd $(dirname $0)
#for dotfile in .?*
for dotpathes in `find . -name ".*"`
do
    if [ $dotpathes != '.' ] && [ $dotpathes != '..' ] && [[ $dotpathes != *"git" ]]
    then
        dotfile=${dotpathes#./}
        #echo "$PWD/$dotfile" $HOME
        ln -Fis "$PWD/$dotfile" $HOME
    fi
done
mkdir $HOME/.backup
