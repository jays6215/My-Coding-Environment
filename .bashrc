# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#if ["$TERM" = "linux" ]; then
    #alias fbterm='LANG=zh_TW.UTF-8 fbterm'
    #fbterm
#fi

#------------#
### My PS1 ###
#------------#
. $HOME/.bashrc.ps1

#------------------------------------------------------------------#
### stty displays or changes the characteristics of the terminal ###
#------------------------------------------------------------------#
if [ -t 0 ]; then
    ## use shortcut ctrl+s in vim
    stty -ixon
    ## let any character restart output, not only start character
    stty ixany
    ## check to see if the window size has changed (prevents line-editing from going weird if you resize your terminal window)
    shopt -s checkwinsize
    ## send both CR/LF
    stty onlcr
    ## fix issue: backspace does not work properly
    stty erase '^?'
fi

#-------------------#
### command alias ###
#-------------------#
#alias      wc='/usr/local/bin/wc'
alias       ls='/bin/ls --color=auto'
alias pcregrep='pcregrep --color=auto'

## auto-color related
alias   tree='tree -C'
alias    dir='dir --color=auto'
alias   grep='grep --color=auto'
alias  fgrep='fgrep --color=auto'
alias  egrep='egrep --color=auto'

## grep color related
export GREP_COLOR=32

## ls color related
export CLICOLOR=YES
export LSCOLORS=ExGxFxdxCxDxDxhbadExEx

## terminal color set
export TERM=xterm-256color

## useful ls aliases
alias     ll='ls -lFht'
alias     la='ls -A'
alias    lsd='ls -alFth | grep ^d'
alias    lsl='ls -alFth | grep ^l'
alias    lsf='ls -alFth | grep ^-'
alias      l='ls -CF'
alias   diff='colordiff'

## This is GOLD for finding out what is taking so much space on your drives!
alias      d='du -cSh * | sort -hr | head -n 25'

## other aliases
alias   ..='cd ..'
alias gvim='gvim -p'
alias  vim='vim -p'
alias   vi='vim'

## cancel warning
#unalias rm
unalias rm 2>/dev/null
#unalias cp
unalias cp 2>/dev/null

## X11 DISPLAY & XAUTHORITY attachment
export XAUTHORITY=$HOME/.Xauthority
saveDisplay() {
    # Write latest bash display to a file, This is used to 
    # update running bash sessions for a "screen -r"
    echo "export DISPLAY=$DISPLAY" > ~/.XDISPLAY
    echo "export XAUTHORITY=$XAUTHORITY" >> ~/.XDISPLAY
}
export -f saveDisplay

updateNewSessionDisplay() {
    # This will only update the environment for new windows
    newDispaly="$(cat ~/.XDISPLAY | cut -d"=" -f2 | head -n 1)"
    newXauthority="$(cat ~/.XDISPLAY | cut -d"=" -f2 | tail -n 1)"
    echo "old DISPLAY = $DISPLAY"
    echo "new DISPLAY = $newDispaly"
    screen -X setenv DISPLAY $newDispaly
    screen -X setenv XAUTHORITY "$newXauthority"
}
export -f updateNewSessionDisplay

updateOldSessionDisplay() {
    # run this to update env variable in old sessions
    source ~/.XDISPLAY
}
export -f updateOldSessionDisplay

# https://unix.stackexchange.com/questions/108873/removing-a-directory-from-path/291611#291611
# usage example 1 (in script file)
#     LD_LIBRARY_PATH=$(removeEnvPath $LD_LIBRARY_PATH "/u/syu/my_disk/large_playground/pc_dev_3_fpga_dev/linux_a_64/lib")
# usage example 2 (in command line)
#     $ setenv LD_LIBRARY_PATH $(removeEnvPath $LD_LIBRARY_PATH /u/syu/my_disk/large_playground/pc_dev_3_fpga_dev/linux_a_64/lib)
function removeEnvPath {
    curEnv=$1
    delTar=$2
    # Delete path by parts so we can never accidentally remove sub paths
    curEnv=${curEnv//":$2:"/":"} # delete any instances in the middle
    curEnv=${curEnv/#"$2:"/} # delete any instance at the beginning
    curEnv=${curEnv/%":$2"/} # delete any instance in the at the end
    echo $curEnv
}
export -f removeEnvPath

alias screen='saveDisplay && screen'

#-------------------------#
### key-binding related ###
#-------------------------#
## quick move on command-line & quick command search
if [[ $- == *i* ]]
then
    bind '"\e[A": history-search-backward' # up cmd search
    bind '"\e[B": history-search-forward'  # down cmd search
    bind '"[1;5D": backward-word'        # ctrl+left
    bind '"[1;5C": forward-word'         # ctrl+right
    #bind '"[6~": end-of-line'             # PageDown
    #bind '"[5~": beginning-of-line'       # PageUp
fi

#--------------------#
### additional bin ###
#--------------------#

#-----------------#
### CMD History ###
#-----------------#
HISTSIZE=2000
HISTFILESIZE=3000

## Combine multiline commands into one in history
shopt -s cmdhist

## Ignore duplicates, ls without options and builtin commands
# HISTCONTROL flag
#    1. ignoreboth
#    2. ignoredups
#    3. ignorespace
#    4. erasedups

## Avoid duplicates
#export HISTCONTROL=ignoreboth:erasedups

## https://bbs.archlinux.org/viewtopic.php?id=150992
## when I exit this Bash session, append its history to the bash_history file
#shopt -s histappend

## every time I run a command append it to the bash_history file
#export PROMPT_COMMAND='history -a'

## After each command, append to the history file and reread it
## https://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
#export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

## “ignoredups” and “erasedups” setting conflict with common history across sessions
## https://unix.stackexchange.com/questions/18212/bash-history-ignoredups-and-erasedups-setting-conflict-with-common-history/18443#18443
HISTCONTROL=ignoredups:erasedups:ignorespace
shopt -s histappend

PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"
#PROMPT_COMMAND="$PROMPT_COMMAND; history -n; history -w; history -c; history -r"

#HISTCONTROL=ignoredups:erasedups:ignorespace
#shopt -s histappend
#export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

## Ignore some common cmd
export HISTIGNORE="&:ls:ll:[bf]g:exit:pwd:"

#---------------#
### Time Zone ###
#---------------#
export TZ="Asia/Taipei"
#export LC_ALL="en_US.UTF-8"

#----------------#
### quick CMDs ###
#----------------#
up () { cd $(eval printf '../'%.0s {1..$1});}
extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1     ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
}
