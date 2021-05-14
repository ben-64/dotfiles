# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[00;31m\]\u\[\033[00m\]@\[\033[00;33m\]\h: \[\033[00;36m\]\t\n\[\033[00;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[00;31m\]\u\[\033[00m\]@\[\033[00;33m\]\h \[\033[00m\]: \[\033[00;36m\]\t\n\[\033[00;34m\]\w\[\033[00m\]\$ '

# Bactrack Prompt
#PS1='\[\033[00;32m\]root@bt\[\033[00m\]:\[\033[00;34m\]\w\[\033[00m\]# '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.shell_aliases ]; then
    . ~/.shell_aliases
fi

if [ -f ~/.shell_functions ]; then
	. ~/.shell_functions
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

umask 077

export PATH=$PATH:~/bin
#export RUBYLIB=~/Documents/pentest/tool/ymvunjq/util/lib/ruby:/home/ben64/.gem/ruby/1.9.1/gems/rmagick-2.13.1/lib/:~/Documents/pentest/tool/cracking/metasm/
export RUBYLIB=~/Documents/pentest/tool/ymvunjq/util/lib/ruby:/var/lib/gems/1.9.1/gems/rmagick-2.13.1/lib/
export PYTHONPATH=~/Documents/pentest/tool/ymvunjq/util/lib/python/:.
export MANPAGER="/usr/bin/most -s +c"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
