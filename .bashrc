# base-files version 4.0-4
# ~/.bashrc: executed by bash(1) for interactive shells.

# The latest version as installed by the Cygwin Setup program can
# always be found at /etc/defaults/etc/skel/.bashrc

# Modifying /etc/skel/.bashrc directly will prevent
# setup from updating it.

# The copy in your home directory (~/.bashrc) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benificial to all, please feel free to send
# a patch to the cygwin mailing list.

# User dependent .bashrc file

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Shell Options
#
# See man bash for more options...
#
# Don't wait for job termination notification
# set -o notify
#
# Don't use ^D to exit
# set -o ignoreeof
#
# Use case-insensitive filename globbing
# shopt -s nocaseglob
#
# Make bash append rather than overwrite the history on disk
# shopt -s histappend
#
# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# Completion options
#
# These completion tuning parameters change the default behavior of bash_completion:
#
# Define to access remotely checked-out files over passwordless ssh for CVS
# COMP_CVS_REMOTE=1
#
# Define to avoid stripping description in --option=description of './configure  --help'
# COMP_CONFIGURE_HINTS=1
#
# Define to avoid flattening internal contents of tar files
# COMP_TAR_INTERNAL_PATHS=1
#
# Uncomment to turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
# [[ -f /etc/bash_completion ]] && . /etc/bash_completion

# History Options
#
# Don't put duplicate lines in the history.
# export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
#
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well
#
# Whenever displaying the prompt, write the previous line to disk
# export PROMPT_COMMAND="history -a"

# Aliases
#
# Some people use a different file for aliases
# if [ -f "${HOME}/.bash_aliases" ]; then
#   source "${HOME}/.bash_aliases"
# fi
#
# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.
#
# Interactive operation...
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
#
# Default to human readable figures
alias df='df -h'
alias du='du -h'
#
# Misc :)
# alias less='less -r'                          # raw control characters
# alias whence='type -a'                        # where, of a sort
# alias grep='grep --color'                     # show differences in colour
# alias egrep='egrep --color=auto'              # show differences in colour
# alias fgrep='fgrep --color=auto'              # show differences in colour
#
# Some shortcuts for different directory listings
if [[ $(uname) != "Darwin" ]]
then
	alias ls='ls -hF --color=tty'                 # classify files in colour
	alias dir='ls --color=auto --format=vertical'
	alias vdir='ls --color=auto --format=long'
	alias ll='ls -l'                              # long list
	alias la='ls -A'                              # all but . and ..
	alias l='ls -CF'                              #
else
	alias ls='ls -hfG'
	export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
fi

alias mkpwd='cat /dev/random| tr -dc "\40-\176" | fold -w 16| head -n 1'

if [ -f ~/localsettings/.bashrc ]
then
        source ~/localsettings/.bashrc
fi

# Get the built-in completion for other functions
if [ -d /etc/bash_completion.d ]
then
	for completion in /etc/bash_completion.d/*
	do
		if [ -f $completion ] 
		then
			source $completion > /dev/null 2>&1
		fi
	done
fi

# Umask
#
# /etc/profile sets 022, removing write perms to group + others.
# Set a more restrictive umask: i.e. no exec perms for others:
# umask 027
# Paranoid: neither group nor others have any perms:
# umask 077

# Functions
#
# Some people use a different file for functions
# if [ -f "${HOME}/.bash_functions" ]; then
#   source "${HOME}/.bash_functions"
# fi
#
# Some example functions:
#
# a) function settitle
# settitle ()
# {
#   echo -ne "\e]2;$@\a\e]1;$@\a";
# }
#
# b) function cd_func
# This function defines a 'cd' replacement function capable of keeping,
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain
# cd_func ()
# {
#   local x2 the_new_dir adir index
#   local -i cnt
#
#   if [[ $1 ==  "--" ]]; then
#     dirs -v
#     return 0
#   fi
#
#   the_new_dir=$1
#   [[ -z $1 ]] && the_new_dir=$HOME
#
#   if [[ ${the_new_dir:0:1} == '-' ]]; then
#     #
#     # Extract dir N from dirs
#     index=${the_new_dir:1}
#     [[ -z $index ]] && index=1
#     adir=$(dirs +$index)
#     [[ -z $adir ]] && return 1
#     the_new_dir=$adir
#   fi
#
#   #
#   # '~' has to be substituted by ${HOME}
#   [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"
#
#   #
#   # Now change to the new dir and add to the top of the stack
#   pushd "${the_new_dir}" > /dev/null
#   [[ $? -ne 0 ]] && return 1
#   the_new_dir=$(pwd)
#
#   #
#   # Trim down everything beyond 11th entry
#   popd -n +11 2>/dev/null 1>/dev/null
#
#   #
#   # Remove any other occurence of this dir, skipping the top of the stack
#   for ((cnt=1; cnt <= 10; cnt++)); do
#     x2=$(dirs +${cnt} 2>/dev/null)
#     [[ $? -ne 0 ]] && return 0
#     [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
#     if [[ "${x2}" == "${the_new_dir}" ]]; then
#       popd -n +$cnt 2>/dev/null 1>/dev/null
#       cnt=cnt-1
#     fi
#   done
#
#   return 0
# }
#

# alias cd=cd_func
#-------------------------------------------------------------
# Some settings
#-------------------------------------------------------------

#set -o nounset     # These  two options are useful for debugging.
#set -o xtrace
alias debug="set -o nounset; set -o xtrace"

set -o notify
set +o nounset # allow unset variables


# Enable options:
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob       # Necessary for programmable completion.

complete -A hostname   rsh rcp telnet rlogin ftp ping disk
complete -A export     printenv
complete -A variable   export local readonly unset
complete -A enabled    builtin
complete -A alias      alias unalias
complete -A function   function
complete -A user       su mail finger

complete -A helptopic  help     # Currently same as builtins.
complete -A shopt      shopt
complete -A stopped -P '%' bg
complete -A job -P '%'     fg jobs disown

complete -A directory  mkdir rmdir
complete -A directory   -o default cd



export EDITOR=vim
#-------------------------------------------------------------
# Greeting, motd etc. ...
#-------------------------------------------------------------

# Color definitions (taken from Color Bash Prompt HowTo).
# Some colors might look different of some terminals.
# For example, I see 'Bold Red' as 'orange' on my screen,
# hence the 'Green' 'BRed' 'Red' sequence I often use in my prompt.

ESC='\033'

# Normal Colors
Black="$ESC[0;30m"        # Black
Red="$ESC[0;31m"          # Red
Green="$ESC[0;32m"        # Green
Yellow="$ESC[0;33m"       # Yellow
Blue="$ESC[0;34m"         # Blue
Purple="$ESC[0;35m"       # Purple
Cyan="$ESC[0;36m"         # Cyan
White="$ESC[0;37m"        # White

# Bold
BBlack="$ESC[1;30m"       # Black
BRed="$ESC[1;31m"         # Red
BGreen="$ESC[1;32m"       # Green
BYellow="$ESC[1;33m"      # Yellow
BBlue="$ESC[1;34m"        # Blue
BPurple="$ESC[1;35m"      # Purple
BCyan="$ESC[1;36m"        # Cyan
BWhite="$ESC[1;37m"       # White

# Background
On_Black="$ESC[40m"       # Black
On_Red="$ESC[41m"         # Red
On_Green="$ESC[42m"       # Green
On_Yellow="$ESC[43m"      # Yellow
On_Blue="$ESC[44m"        # Blue
On_Purple="$ESC[45m"      # Purple
On_Cyan="$ESC[46m"        # Cyan
On_White="$ESC[47m"       # White

NC="$ESC[m"               # Color Reset


ALERT=${BWhite}${On_Red} # Bold White on red background




#-------------------------------------------------------------
# Shell Prompt - for many examples, see:
#       http://www.debian-administration.org/articles/205
#       http://www.askapache.com/linux/bash-power-prompt.html
#       http://tldp.org/HOWTO/Bash-Prompt-HOWTO
#       https://github.com/nojhan/liquidprompt
#-------------------------------------------------------------
# Current Format: [TIME USER@HOST PWD] >
# TIME:
#    Green     == machine load is low
#    Orange    == machine load is medium
#    Red       == machine load is high
#    ALERT     == machine load is very high
# USER:
#    Cyan      == normal user
#    Orange    == SU to user
#    Red       == root
# HOST:
#    Cyan      == local session
#    Green     == secured remote connection (via ssh)
#    Red       == unsecured remote connection
# PWD:
#    Green     == more than 10% free disk space
#    Orange    == less than 10% free disk space
#    ALERT     == less than 5% free disk space
#    Red       == current user does not have write privileges
#    Cyan      == current filesystem is size zero (like /proc)
# >:
#    White     == no background or suspended jobs in this shell
#    Cyan      == at least one background job in this shell
#    Orange    == at least one suspended job in this shell
#
#    Command is added to the history file each time you hit enter,
#    so it's available to all shells (using 'history -a').


# Test connection type:
if [ -n "${SSH_CONNECTION}" ]; then
    CNX=${Green}        # Connected on remote machine, via ssh (good).
        SHOW_HOSTNAME="1"
else
    CNX=${BCyan}        # Connected on local machine.
        SHOW_HOSTNAME="0"
fi

lognameval=$(logname 2>/dev/null)
if [ $? -ne 0 ]; then
    lognameval=$LOGNAME
fi

# Test user type:
if [[ ${USER} == "root" ]]; then
    SU=${Red}           # User is root.
elif [[ ${USER} != ${lognameval} ]]; then
    SU=${BRed}          # User is not login user.
else
    SU=${Green}         # User is normal (well ... most of us are).
fi


if [ -e /proc/cpuinfo ]
    then NCPU=$(grep -c 'processor' /proc/cpuinfo)    # Number of CPUs
    else NCPU=1
fi

SLOAD=$(( 100*${NCPU} ))        # Small load
MLOAD=$(( 200*${NCPU} ))        # Medium load
XLOAD=$(( 400*${NCPU} ))        # Xlarge load

# Returns system load as percentage, i.e., '40' rather than '0.40)'.
function load()
{
    if [ -e /proc/cpuinfo ]
        then local SYSLOAD=$(cut -d " " -f1 /proc/loadavg | tr -d '.')
        else local SYSLOAD=0
    fi
    # System load of the current host.
    echo $((10#$SYSLOAD))       # Convert to decimal.
}

# Returns a color indicating system load.
function load_color()
{
    local SYSLOAD=$(load)
    if [ ${SYSLOAD} -gt ${XLOAD} ]; then
        echo -en ${ALERT}
    elif [ ${SYSLOAD} -gt ${MLOAD} ]; then
        echo -en ${Red}
    elif [ ${SYSLOAD} -gt ${SLOAD} ]; then
        echo -en ${BRed}
    else
        echo -en ${Green}
    fi
}

# Returns a color according to free disk space in $PWD.
function disk_color()
{
    if [ ! -w "${PWD}" ] ; then
        echo -en ${Red}
        # No 'write' privilege in the current directory.
    elif [ -s "${PWD}" ] ; then
        local used=$(command df -P "$PWD" |
                   awk 'END {print $5}' | tr -d '%' )
        if [ ${used} -gt 95 ]; then
            echo -en ${ALERT}           # Disk almost full (>95%).
        elif [ ${used} -gt 90 ]; then
            echo -en ${BRed}            # Free disk space almost gone.
        else
            echo -en ${Green}           # Free disk space is ok.
        fi
    else
        echo -en ${Cyan}
        # Current directory is size '0' (like /proc, /sys etc).
    fi
}

# Returns a color according to running/suspended jobs.
function job_color()
{
    if [ $(jobs -s | wc -l) -gt "0" ]; then
        echo -en ${BRed}
    elif [ $(jobs -r | wc -l) -gt "0" ] ; then
        echo -en ${BCyan}
    fi
}

# Adds some text in the terminal frame (if applicable).


# Now we construct the prompt.
PROMPT_COMMAND="history -a"
case ${TERM} in
  *term | rxvt | linux | xterm-256color)
        # Time of day (with load info):
        PS1="\[\$(load_color)\][\@\[${NC}\] "
        # User@Host (with connection type info):
                PS1=${PS1}"\[${SU}\]\u\[${NC}\]"
                if [ ${SHOW_HOSTNAME} -eq "1" ]
                then
                        PS1=${PS1}"@\[${CNX}\]\h\[${NC}\] "
                else
                        PS1=${PS1}" "
                fi
        # PWD (with 'disk space' info):
        PS1=${PS1}"\[\$(disk_color)\]\W]\[${NC}\]"
        # Prompt (with 'job' info):
        PS1=${PS1}"\[\$(job_color)\]\$\[${NC}\] "
        # Set title of current xterm:
        PS1=${PS1}"\[\e]0;[\u@\h] \w\a\]"
        ;;
    *)
        PS1="(\A \u@\h \W) $ " # --> PS1="(\A \u@\h \w) > "
                               # --> Shows full pathname of current dir.
        ;;
esac


# Customizations from LLNL

alias less='less -R' # color
alias d='dirs -v'
alias fd='popd'

function sd {
	re='^[0-9]+$'
	if [[ $# -eq 0 ]]
	then
		pushd
	elif [[ $1 =~ $re ]]
	then
		pushd "+$1" > /dev/null
		local curdir=`pwd`
		popd > /dev/null
		pushd "-$(($1-1))" > /dev/null
		pushd $curdir
	else
		pushd "$1"
	fi
}


if [ ! -f ~/.setup_complete ] 
then

	# Install pathogen (Vim package manager)
	mkdir -p ~/.vim/autoload ~/.vim/bundle && \
		curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

	pushd  ~/.vim/bundle > /dev/null
	git clone https://github.com/jeffkreeftmeijer/vim-numbertoggle.git

	popd > /dev/null

	if [ ! -f /etc/bash_completion.d/git ]
	then
		wget -O ~/.git-completion.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash 
	fi

	touch ~/.setup_complete
fi


if [ -f $/.git-completion.sh ]
then
	set +u # This file uses some uninitialized variables
	source ~/.git-completion.sh
fi

# Better `man` for builtin commands
#
# Automatically jumps to the appropriate section
# of the Bash man page for builtin commands
function man {
    local search=''
    local name='bash'
    # Check type of the command
    case $(type -t "$1") in
        # Bash builtins
        'builtin')
            case "$1" in
                # Bash builtins with stand-alone man pages
                echo|false|kill|printf|pwd|test|true)
                    name="$1"
                    ;;
                # Special cases
                '.'|'[')
                    search=-p"^ {7,8}\\$1 .*\]"
                    ;;
                declare)
                    search=-p"^ {7}$1 \[.*"
                    ;;
                logout|times)
                    search=-p"^ {7}$1 "
                    ;;
                # Bash builtins without stand-alone man pages
                *)
                    search=-p"^ {7}$1 .*\[.*"
                    ;;
            esac
            ;;
        # Non bash builtins
        *)
            name="$1"
            ;;
    esac
    # Now run actual command `man` and search for string `search`
    LESS="$search" command man "$name"
}


# Tab completion for man pages
function _man_pages()
{
    local cur opts prev
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"      #Get the current word
    prev="${COMP_WORDS[COMP_CWORD - 1]}" #Get the previous word
    opts=""
    if [ "$prev" = "man" ];
    then
        #We didn't use a section number
        #This lovely regex converts from the file path to the name of the page
        opts=$(find "/usr/share/man" -regextype posix-extended -regex ".*/man[1-9n]/(${cur}.*)\.[1-9n].*$" | sed -E 's/^.*\/(.*)\.[1-9n].*$/\1/')
    else 
        #We entered a section number
        opts=$(find "/usr/share/man" -regextype posix-extended -regex ".*/man${prev}/(${cur}.*)\.${prev}.*$" | sed -E "s/^.*\/(.*)\.${prev}.*$/\1/")
    fi

    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    return 0
}

complete -F _man_pages man


