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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    #alias edir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

## more colorful commands
alias   tree='tree -C'
alias   diff='colordiff'

### command short-cut ###
## useful ls aliases
alias     ll='ls -lFht'
alias     la='ls -A'
alias    lsd='ls -alFt | grep /$'
alias      l='ls -CF'
## other aliases
alias        ..='cd ..'
alias        vi='vim'
# find out what is taking so much space on your drives!
alias diskspace='du -S | sort -n -r | less'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias     alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
#########################

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

### command history ###
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=10000

## append to the history file, don't overwrite it
shopt -s histappend
#shopt -s histappend PROMPT_COMMAND='history -a'

## combine multiline commands into one in history
shopt -s cmdhist

## ignore duplicates, ls without options and built-in commands
## don't put duplicate lines or lines starting with space in the history.
## See bash(1) for more options
HISTCONTROL=ignoreboth # ignoredups & ignorespace

## ignore some common cmd
export HISTIGNORE="&:ls:ll:[bf]g:exit"
#######################

### My PS1 ###
RESET="\[\017\]"
NORMAL="\[\033[0m\]"

FRED0="\[\033[00;31m\]"
FGRE0="\[\033[00;32m\]"
FYEL0="\[\033[00;33m\]"
FBLU0="\[\033[00;34m\]"
FPUR0="\[\033[00;35m\]"
FCYA0="\[\033[00;36m\]"
FWHI0="\[\033[00;37m\]"

FGRA1="\[\033[01;30m\]"
FRED1="\[\033[01;31m\]"
FGRE1="\[\033[01;32m\]"
FYEL1="\[\033[01;33m\]"
FBLU1="\[\033[01;34m\]"
FPUR1="\[\033[01;35m\]"
FCYA1="\[\033[01;36m\]"
FWHI1="\[\033[01;37m\]"

FRED4="\[\033[04;31m\]"
FGRE4="\[\033[04;32m\]"

### ┌[rabbit125]@rabbit125-UX303LA at 16:25:07 <CPU Load:0.21 Uptime:1d14h9m> :) ###
PS1="\n"
PS1+="${FGRA1}┌[${NORMAL}"
PS1+="${FRED1}\u${NORMAL}"
PS1+="${FGRA1}]${NORMAL}@"

PS1+="${FYEL1}\h${NORMAL} at "
PS1+="${FGRE1}\t${NORMAL}"

PS1+="${FPUR0} <${NORMAL}"
PS1+="${FCYA1}CPU Load:${NORMAL}"
PS1+="${FYEL0}$(temp=$(cat /proc/loadavg) && echo ${temp%% *}) ${NORMAL}"
PS1+="${FPUR1}Uptime:${NORMAL}"
PS1+="${FYEL0}$(temp=$(cat /proc/uptime) && upSec=${temp%%.*} ; let secs=$((${upSec}%60)) ; let mins=$((${upSec}/60%60)) ; let hours=$((${upSec}/3600%24)) ; let days=$((${upSec}/86400)) ; if [ ${days} -ne 0 ]; then echo -n ${days}d; fi ; echo -n ${hours}h${mins}m)${NORMAL}"
PS1+="${FPUR0}>${NORMAL}"

SMILEY="${FGRE0}:)${NORMAL}"
FROWNY="${FRED0}:(${NORMAL}"
SELECT="if [ \$? = 0 ]; then echo \"${SMILEY}\"; else echo \"${FROWNY}\"; fi"
PS1+=" \`${SELECT}\`"

### ├─[~/GitProjects/My-Coding-Environment] 3/20 Files 3.7M master(e2e46e1) ###
PS1+="\n"
PS1+="${FGRA1}├─${NORMAL}"
PS1+="${FBLU0}[${NORMAL}"
PS1+="${FBLU1}\w${NORMAL}"
PS1+="${FBLU0}]${NORMAL}"

F_CNT=$(ls -l | grep "^-" | wc -l | tr -d " ")
FD_CNT=$(ls -1 | wc -l)
F_SIZE=$(ls --si -s | head -1 | cut -d " " -f 2)

PS1+=" "
PS1+="${FGRE4}${F_CNT}${NORMAL}/"
PS1+="${FRED4}${FD_CNT}${NORMAL} "
PS1+="${FWHI0}Files${NORMAL} "
PS1+="${FCYA0}${F_SIZE}${NORMAL}"

## function formattedGitBranch(), now not using ##
#function formattedGitBranch {
#    local _branch="$(git branch 2>/dev/null | sed -e "/^\s/d" -e "s/^\*\s//")"
#    test -n "$_branch" && echo -e " @\e[0;32m ($_branch)"
#}
#PS1+='$(formattedGitBranch)'

## function git_prompt(), now using ##
# http://mediadoneright.com/content/ultimate-git-ps1-bash-prompt
# http://eseth.org/2010/git-in-zsh.html
# http://c0rp.blogspot.tw/2014/06/add-git-branch-name-and-last-commit-to.html
function git_prompt() {
    ### git branck-name
    local _branch="$(git branch 2>/dev/null | sed -e "/^\s/d" -e "s/^\*\s//")"
    ### git status of the repo and chose a color accordingly
    local git_status=`git status 2>&1`
    if [[ "$git_status" != *'Not a git repository'* ]]; then
        ### git commit status ###
        if [[ "$git_status" == *'nothing to commit, working directory clean'* ]]; then
            local ansi=32 # dark green  if working directory clean
        elif [[ "$git_status" == *'Changes not staged for commit'* ]]; then
            local ansi=31 # dark red    if need to add
        elif [[ "$git_status" == *'Untracked files:'* ]]; then
            local ansi=35 # dark perple if nothing added to commit, but untracked files present
        elif [[ "$git_status" == *'Changes to be committed:'* ]]; then
            local ansi=33 # dark yellow if need to commit
        else
            local ansi=36 # dark cyne if others
        fi
        #echo -e ' \033[02;'"$ansi"'m'"$_branch"'\033[00m[\033[02;37m'"$git_curr_sha1"'\033[00m] ('"$stashes"' stashed)'

        ### git current commit sha1
        local git_curr_sha1=`git rev-parse --short HEAD`

        ### git stash count
        #local stashes=`git stash list 2>/dev/null | wc -l`

        local git_status='\033[02;'"$ansi"'m'"$_branch"'\033[00m(\033[02;37m'"$git_curr_sha1"'\033[00m)'

        if [[ "$_branch" != *'no branch'* ]]; then
            ### git local/remote branch counter
            local new_local_commit_cnt=`diff <(git rev-list HEAD) <(git rev-list origin/$_branch) 2>&1 | grep '<' | wc -l`
            #echo $new_local_commit_cnt
            local new_remote_commit_cnt=`diff <(git rev-list HEAD) <(git rev-list origin/$_branch) 2>&1 | grep '>' | wc -l`
            #echo $new_remote_commit_cnt
            if [[ "$new_local_commit_cnt" -gt "0" ]]; then
                git_status=$git_status' \033[01;04;34m+'$new_local_commit_cnt'\033[00m'
            fi
            if [[ "$new_remote_commit_cnt" -gt "0" ]]; then
                git_status=$git_status' \033[01;04;34m-'$new_remote_commit_cnt'\033[00m'
            fi
        fi
        echo -e ' '$git_status
    fi
}
PS1+='$(git_prompt)'

###└──$  ###
PS1+="\n"
PS1+="${FGRA1}└──${NORMAL}"
PS1+="${FWHI1}$ ${NORMAL}"

export PS1
##############

#if ["$TERM" = "linux" ]; then
    #alias fbterm='LANG=zh_TW.UTF-8 fbterm'
    #fbterm
#fi

### stty displays or changes the characteristics of the terminal ###
## use shortcut ctrl+s in vim
stty -ixon
## let any character restart output, not only start character
stty ixany
####################################################################

### quick CMDs ###
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
##################
