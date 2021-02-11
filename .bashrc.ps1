#------------#
### My PS1 ###
#------------#
## PS1 prompt color tag
NORMAL='\[\033[0m\]'
FGRA1='\[\033[01;30m\]'
FRED1='\[\033[01;31m\]'
FGRE1='\[\033[01;32m\]'
FYEL1='\[\033[01;33m\]'
FBLU1='\[\033[01;34m\]'
FPUR1='\[\033[01;35m\]'
FCYA1='\[\033[01;36m\]'
FWHI1='\[\033[01;37m\]'

FRED0='\[\033[00;31m\]'
FGRE0='\[\033[00;32m\]'
FYEL0='\[\033[00;33m\]'
FBLU0='\[\033[00;34m\]'
FPUR0='\[\033[00;35m\]'
FCYA0='\[\033[00;36m\]'
FWHI0='\[\033[00;37m\]'

FRED4='\[\033[04;31m\]'
FGRE4='\[\033[04;32m\]'

BPUR1='\[\033[30;45m\]'
BCYA1='\[\033[30;46m\]'

## easy coloring by using escape sequences
# https://coderwall.com/p/d2vlqq/show-last-command-s-status-in-bash-prompt
function Color() {
    # https://wiki.archlinux.org/index.php/Bash/Prompt_customization
    if [ $# -le 3 ]; then
        if [[ -n "$2" ]]; then
            echo "$(tput setaf $1; tput setab $2; $3)"
        else
            echo "$(tput setaf $1; $3)"
        fi
    elif [ $# -eq 4 ]; then
        if [[ -n "$2" ]]; then
            echo "$(tput setaf $1; tput setab $2; $3; $4)"
        else
            echo "$(tput setaf $1; $3; $4)"
        fi
    fi
}
function ResetColor() {
    echo "$(tput sgr0)"
}

## time stamp of 'beginning of cmd' 
function getTcmdStart {

    ### get previous/current cmd ###
    # https://stackoverflow.com/questions/6109225/echoing-the-last-command-run-in-bash
    #previous_command=$this_command
    #this_command=$BASH_COMMAND
    #echo "+1+$previous_command++ x ++$this_command++ / $tcmdStime ** tcmdStr $tcmdStr"

    ## update tcmdStime by $SECONDS if previous tcmdStime is empty ##
    tcmdStime=${tcmdStime:-$SECONDS}
    tcmdStr=${tcmdStr:-$BASH_COMMAND}

    #echo "+2+$previous_command++ x ++$this_command++ / $tcmdStime ** tcmdStr $tcmdStr"
}
function calTcmdRtime {
    tcmdRtime=$(($SECONDS - $tcmdStime))
    #echo "**$previous_command** x **$this_command** // rtime = $tcmdRtime, tcmdStime = $tcmdStime"
    unset tcmdStime

    isTcmd=1
    if [ "$tcmdStr" == "history -n" ]; then
        isTcmd=0
    fi
    #echo "Reset-tcmdStime **$tcmdStr**"
    unset tcmdStr
}
trap 'getTcmdStart' DEBUG

## time stamp caught at 'ending of cmd'
if [ "$PROMPT_COMMAND" == "" ]; then
    PROMPT_COMMAND="calTcmdRtime"
    shortHostName=$(echo $HOSTNAME | tr "." "\n" | head -n 1)
    PROMPT_COMMAND='echo -ne "\033]0;Xterm @ ${shortHostName}\007";'$PROMPT_COMMAND
else
    PROMPT_COMMAND="$PROMPT_COMMAND; calTcmdRtime"
fi

function getCmdTime() {
    local cmdRet=$?
    local koTag="✘"
    local noTag="-"
    local okTag="✔"
    #echo "--$isTcmd--$cmdRet--"
    if [ $isTcmd -eq 0 ]; then
        echo " $(Color 3 "" "tput bold")$noTag$(ResetColor) "
    else
        if [ "$cmdRet" == "0" ]; then
            if [ $tcmdRtime -eq 0 ]; then
                echo " $(Color 4 "" "tput bold")$okTag$(ResetColor) "
            else
                if [ $tcmdRtime -ge 3600 ]; then
                    remain_time=$tcmdRtime
                    tcmdRtime_hou=$(($remain_time/3600))
                    remain_time=$(($remain_time-$tcmdRtime_hou*3600))
                    tcmdRtime_min=$(($remain_time/60))
                    echo " $(Color 2 "" "tput bold")$okTag$(ResetColor) ${tcmdRtime_hou}h ${tcmdRtime_min}m "
                elif [ $tcmdRtime -ge 60 ]; then
                    tcmdRtime_min=$(($tcmdRtime/60))
                    tcmdRtime_sec=$(($tcmdRtime-$tcmdRtime_min*60))
                    echo " $(Color 2 "" "tput bold")$okTag$(ResetColor) ${tcmdRtime_min}m ${tcmdRtime_sec}s "
                else
                    echo " $(Color 2 "" "tput bold")$okTag$(ResetColor) ${tcmdRtime}s "
                fi
            fi
        else
            echo " $(Color 1 "" "tput bold")$koTag$(ResetColor) "
        fi
    fi
}

### ┌[rabbit125]@rabbit125-VirtualBox at 03:53:20 <CPU Load:1.13 Uptime:8h11m> 1/15 Files 58k###
PS1="\n"
PS1+=${FGRA1}'┌['${NORMAL}
PS1+=${FRED1}'\u'${NORMAL}
PS1+=${FGRA1}']'${NORMAL}' '

PS1+=${FYEL1}'\h'${NORMAL}' '
PS1+=${FGRE1}'\D{%m/%d %a %H:%M:%S}'${NORMAL}

#PS1+=${FPUR0}' <'${NORMAL}
#PS1+=${FCYA1}'CPU Load:'${NORMAL}
#PS1+="${FYEL0}$(temp=$(cat /proc/loadavg) && echo ${temp%% *}) ${NORMAL}"
#PS1+="${FPUR1}Uptime:${NORMAL}"
#PS1+="${FYEL0}$(temp=$(cat /proc/uptime) && upSec=${temp%%.*} ; let secs=$((${upSec}%60)) ; let mins=$((${upSec}/60%60)) ; let hours=$((${upSec}/3600%24)) ; let days=$((${upSec}/86400)) ; if [ ${days} -ne 0 ]; then echo -n ${days}d; fi ; echo -n ${hours}h${mins}m)${NORMAL}"
#PS1+=${FPUR0}'> '${NORMAL}

PS1+='$(getCmdTime)'

F_CNT='$(ls -l | grep "^-" | wc -l | tr -d " ")'
FD_CNT='$(ls -1f | wc -l)'
D_CNT='$(ls */ -df -1 2>/dev/null | wc -l)'

PS1+=${FGRE4}${F_CNT}${NORMAL}'/'
PS1+=${FRED4}${D_CNT}${NORMAL}' '
PS1+=${FWHI0}'Items'${NORMAL}' '

function toolMessage() {
    if echo "$TER_ENV" | grep -q "ZeBu"; then
        # ${SGE_CELL} -> 'zebutrain'
        # ${SGE_CELL}
        echo "$(Color 5 0 "tput smul")"${TER_ENV}-Env"$(ResetColor) $(Color 6 0)${ZEBU_ROOT}$(ResetColor)"

    elif echo "$TER_ENV" | grep -q "Pc"; then
        echo "$(Color 5 0 "tput smul")"${TER_ENV}-Env"$(ResetColor) $(Color 3 0)${P4CLIENT}$(ResetColor) $(Color 6 0)${PC_ROOT}$(ResetColor)"
    fi
}
PS1+='$(toolMessage)'

### ├─[~] ###
PS1+='\n'
PS1+=${FGRA1}'├─'${NORMAL}
PS1+=${FBLU0}'['${NORMAL}
PS1+=${FBLU1}'\w'${NORMAL}
PS1+=${FBLU0}']'${NORMAL}

#function formattedGitBranch {
#    _branch="$(git branch 2>/dev/null | sed -e "/^\s/d" -e "s/^\*\s//")"
#    test -n "$_branch" && echo -e " @\[\033[0;32m $_branch"
#}
#PS1+='`formattedGitBranch`'

### └──$  ###
PS1+='\n'
PS1+=${FGRA1}'└──'${NORMAL}
PS1+=${FWHI1}'$ '${NORMAL}

export PS1
