# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=10000

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

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'

# vi = vim
alias vi='vim'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
### My PS1 ###

### ┌[rabbit125]@rabbit125-UX303LA at 05-05 19:35:24  <CPU Load:0.33 Uptime:20h5m> ###
PS1='\n'
PS1+='\[\033[01;30m\]┌[\[\033[00m\]'
PS1+='\[\033[01;31m\]\u\[\033[00m\]'
PS1+='\[\033[01;30m\]]\[\033[00m\]@'

PS1+='\[\033[01;33m\]\h\[\033[00m\] at '
PS1+='\[\033[01;32m\]\D{%m-%d} \t\[\033[00m\] '

PS1+='\[\033[00;35m\] <\[\033[00m\]'

PS1+='\[\033[01;36m\]CPU Load:\[\033[00m\]'
PS1+='\[\033[00;33m\]$(temp=$(cat /proc/loadavg) && echo ${temp%% *}) \[\033[00m\]'
PS1+='\[\033[01;35m\]Uptime:\[\033[0m\]'
PS1+='\[\033[00;33m\]$(temp=$(cat /proc/uptime) && upSec=${temp%%.*} ; let secs=$((${upSec}%60)) ; let mins=$((${upSec}/60%60)) ; let hours=$((${upSec}/3600%24)) ; let days=$((${upSec}/86400)) ; if [ ${days} -ne 0 ]; then echo -n ${days}d; fi ; echo -n ${hours}h${mins}m)\[\033[00m\]'

PS1+='\[\033[00;35m\]> \[\033[00m\]'

### ├─[~/GitProjects/My-Coding-Environment] 2/3 Files 13k @ master ###

PS1+='\n'
PS1+='\[\033[01;30m\]├─\[\033[00m\]'
PS1+='\[\033[00;34m\][\[\033[00m\]'
PS1+='\[\033[01;34m\]\w\[\033[00m\]'
PS1+='\[\033[00;34m\]]\[\033[00m\] '

PS1+='\[\033[04;32m\]$(ls -l | grep "^-" | wc -l | tr -d " ")\[\033[00m\]/'
PS1+='\[\033[04;31m\]$(ls -1 | wc -l)\[\033[00m\] '

PS1+='\[\033[00;37m\]Files\[\033[00m\] '
PS1+='\[\033[00;36m\]$(ls --si -s | head -1 | awk '\''{print $2}'\'')\[\033[00m\]'

function formattedGitBranch {
    local _branch="$(git branch 2>/dev/null | sed -e "/^\s/d" -e "s/^\*\s//")"
    test -n "$_branch" && echo -e " @\e[0;32m ($_branch)"
}
#PS1+='$(formattedGitBranch)'

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
        if [[ "$git_status" == *'Your branch is up-to-date'* ]]; then
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

### └──$  ###

PS1+='\n'
PS1+='\[\033[01;30m\]└──\[\033[00m\]'
PS1+='\[\033[01;37m\]$ \[\033[00m\]'

export PS1

#if ["$TERM" = "linux" ]; then
    #alias fbterm='LANG=zh_TW.UTF-8 fbterm'
    #fbterm
#fi

### use shortcut ctrl+s in linux ###
stty -ixon

### New Features: diff ###
alias diff='colordiff'

### co-bash history ###
#shopt -s histappend PROMPT_COMMAND='history -a'
