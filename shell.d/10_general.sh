#!/bin/zsh

# Some ENV
export BAT_THEME=tokyonight_night
export BAT_THEME=gruvbox-dark
export EZA_CONFIG_DIR=~/.config/eza/

# thefuck alias
if exist thefuck; then
    eval $(thefuck --alias)
    eval $(thefuck --alias fk)
fi

if [ -f ~/.shell.d/_conf_${SYSTEM_TYPE}.sh ]; then
  source ~/.shell.d/_conf_${SYSTEM_TYPE}.sh
fi

###########################
##     ALIASES
###########################

## Use nvim if present
if exist nvim; then
  alias vi=nvim
fi

## Security
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

## Win time
alias hl='highlight'
alias py='python3'
alias mkdir='mkdir -p'
alias svi="sudo vi"
alias dns="dig +short"
alias i="ipython3"
alias ux="chmod u+x"
alias rel="source ~/.zshrc"
alias m="man"
alias tf="tail -f"
alias g="git"
alias gdb='gdb -q'
alias ush='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
alias greip="grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'"
alias ag="ag --path-to-ignore ~/.ignore_ag"
if_exist batcat "alias bat=batcat"
if_exist bat "alias c='bat --plain'" "alias c=cat"
if_exist hexyl "alias x=hexyl" "alias x=xxd"
alias gcm="git commit -m"
alias y="yazi"
alias v=vi
alias gp="git pull"
alias gP="git push"

## Change folder
alias ..='cd ../..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

alias less='less -R'
alias diffw="git diff --word-diff --no-index"
alias difft="diff --brief -r"
alias tmux='tmux -2'

## enable ls colors
if [[ "$DISABLE_LS_COLORS" != "true" ]]; then
  if [[ "$SYSTEM_TYPE" == "NET_BSD" ]]; then
    # On NetBSD, test if "gls" (GNU ls) is installed (this one supports colors);
    # otherwise, leave ls as is, because NetBSD's ls doesn't support -G
    gls --color -d . &>/dev/null 2>&1 && COLORFLAG="--color=tty"
  elif [[ "$SYSTEM_TYPE" == "OPEN_BSD" ]]; then
    # On OpenBSD, test if "colorls" is installed (this one supports colors);
    # otherwise, leave ls as is, because OpenBSD's ls doesn't support -G
    colorls -G -d . &>/dev/null 2>&1 && COLORFLAG="-G"
  elif [[ "$SYSTEM_TYPE" == "macos" ]]; then
    # on OS X use "-G"
    COLORFLAG="-G"
  FOLDER_FIRST=""
  elif ls --color -d . &>/dev/null 2>&1; then
    COLORFLAG="--color"
  FOLDER_FIRST="--group-directories-first"
    if [[ "$SYSTEM_TYPE" == "linux" || "$SYSTEM_TYPE" == "CYGWIN" ]]; then
      COLORFLAG="--color=auto"
    fi
  fi
fi

alias grep="grep $COLORFLAG"
alias egrep="egrep $COLORFLAG"
alias fgrep="fgrep $COLORFLAG"

## ls
alias ls="ls $COLORFLAG"

if exist eza; then
  alias ls='eza -F --color=always'
  alias l='eza -F --color=always --long --no-filesize --icons=always --no-time --no-user --no-permissions'
  alias ll='eza --color=always --long --git --icons=always'
  alias lt='ll --sort=modified'
  alias lz='ll --sort=size'
  alias lr='eza --color=always --tree'
else
  alias ls='ls --color'
  alias l='ls'
  alias ll='ls -l'
  alias lt='ll -Fhtr'
  alias lz='ll -1FShr'
  alias lr='tree'
  export LS_COLORS="di=38;2;122;162;247:fi=38;2;192;202;245:ln=38;2;125;207;255:ex=38;2;158;206;106:ow=38;2;122;162;247:tw=38;2;122;162;247"
fi

## System utilities
### get top process eating memory
alias psmem="ps -o time,ppid,pid,nice,pcpu,pmem,user,comm -A | sort -n -k 6"
alias psmem5="psmem | tail -5"
alias psmem10="psmem | tail -10"

### get top process eating cpu
alias grep='grep --color=auto'
alias pscpu="ps -o time,ppid,pid,nice,pcpu,pmem,user,comm -A | sort -n -k 5"
alias pscpu5="pscpu | tail -5"
alias pscpu10="pscpu | tail -10"


###################################
#      FUNCTIONS
###################################
# File backup function
bck() { cp "$1" "$1.back_`date +%Y%m%d_%H%M%S`" ; }

highlight() {
	grep --color -E "$1|$"
}

alert() {
	echo -e '\a'
}

own() {
	sudo chown $USER:$USER $*
}

cpath() {
	if [ $# -eq 0 ]; then
		t="."
	else
		t=$1
	fi
	# Give absolut path of $1 and send it to copy buffer, usefull to copy/paste
	p=$(realpath $t)
  [ $SYSTEM_TYPE = "macos" ] && COPY_CMD=pbcopy || COPY_CMD=xsel
	echo -n $p | $COPY_CMD
	echo $p
}

# exchange $1 and $2 name
exchange() {
	if [ ! -f $1.tmp ]; then
		mv $1 $1.tmp
		mv $2 $1
		mv $1.tmp $2
	else
		echo "File $1.tmp exists, cannot proceed"
	fi
}

own() {
	# chown current_user:current_user
	user=$(id -un)
	group=$(id -gn)
	sudo chown $user:$group $*
}

gkill() {
	if [ x"$1" = x"-s" ]; then
		ps ax | grep $2 | grep -v grep | awk -F' ' '{print $1;}' | xargs sudo kill $3
	else
		ps ax | grep $1 | grep -v grep | awk -F' ' '{print $1;}' | xargs kill $2
	fi
}

graphsize() {
	if [ $# -eq 0 ]; then
		dir="."
		size="10"
	elif [ $# -eq 1 ]; then
		dir=$1
		size="10"
	else
		dir=$1
		size=$2
	fi
	sudo du -bs $dir/* | sort -n | awk -F'\t' '{print $2":"$1}' | spark -H -s $size
}

diffzip() {
	diff <(unzip -l $1|tr -s ' '|cut -d' ' -f5|sort) <(unzip -l $2|tr -s ' '|cut -d' ' -f5|sort)
}

# Generic decompression
un() {
	local ukn=0
    case "$1" in
        *.tar.gz|*.tar.bz2|*.tar.z)
            dir_name=${1%*.tar.*} ;;
        *)
            dir_name=${1%*.*} ;;
    esac
    mkdir $dir_name
    mv $1 $dir_name
    cd $dir_name
    case "$1" in
        *.tgz|*.tar.gz) tar xzf "$1" ;;
        *.tar.bz2|*.tz2|*.tbz2) tar xjf "$1" ;;
        *.tar.xz|*.txz) tar xJf "$1" ;;
        *.tar) tar xf "$1" ;;
        *.gz) gunzip "$1" ;;
        *.bz2) bunzip2 "$1" ;;
        *.z|*.Z) uncompress "$1" ;;
        *.zip|*.ZIP) unzip "$1" ;;
        *.jar|*.JAR) unzip "$1" ;;
		*.odt|*.ODT) unzip "$1" ;;
        *.apk|*.APK) unzip "$1" ;;
		*.rar|*.RAR) unrar x "$1";;
        *) echo "unknow format : $1"; mv $1 ..; ukn=1;;
    esac
    cd ..
	[ $ukn -eq 1 ] && rmdir $dir_name
}

unl() {
    case "$1" in
        *.tgz|*.tar.gz) tar tzf "$1" ;;
        *.tar.bz2|*.tz2|*.tbz2) tar tjf "$1" ;;
        *.tar.xz) tar tJf "$1" ;;
        *.tar) tar tf "$1" ;;
        *.zip|*.ZIP) unzip -l "$1" ;;
        *.jar|*.JAR) unzip -l "$1" ;;
		*.odt|*.ODT) unzip -l "$1" ;;
		*.apk|*.APK) unzip -l "$1" ;;
		*.rar|*.RAR) unrar l "$1";;
        *) echo "unknow format : $1" ;;
    esac
}

internet() {
    local ans

    ping -c 1 8.8.8.8 2>&1 >/dev/null&& echo "Ping OK" || echo "Ping KO"

    ans="$(dig +short www.google.fr | wc -l)"
    [ $ans -ge "1" ] && echo "DNS OK" || echo "DNS KO"

	google="$(dig @8.8.8.8 +short www.google.fr)"
	ans="$(echo $google | wc -l)"
    [ $ans -ge "1" ] && echo "Outside DNS OK" || echo "Outside DNS KO"

    sudo hping3 -S -p 80 $google -c 1 > /dev/null 2>&1 && echo "HTTP OK" || echo "HTTP KO"
}

# Wipe wipe directory inside ($1)
wipe_directory() {
	[ $# -ne 1 ] && echo "No directory" && return 1
	[ -d "$1/wipe" ] && wipe -rfq $1/wipe/* || echo "$1/wipe is not a directory"
}


vn() {
	file=$(echo $1 | cut -f1 -d":")
	line=$(echo $1 | cut -f2 -d":")
	vi $file +$line
}

nocomment() {
  grep -Ev '(^$|^\s*\#)'	$1
}

x509() {
	file=$1
	nb_param=$#
	shift
	[ $nb_param -eq 1 ] && PARAM="-text" || PARAM="$*"

	# check certificate type
	openssl x509 -in $file -inform PEM -noout 2>/dev/null
	[ $? -eq 0 ] && type="PEM" || type="DER"

	openssl x509 -in $file -inform $type -noout $PARAM
}

# Execute command inside docker container
dke() {
    [ $# -lt 1 ] && echo "Usage: $0 container [CMDS...]" && return 1
    container=$1
    if [ $# -ge 2 ]; then
        shift
        docker exec -it $container $*
    else
        docker exec -it $container /bin/bash
    fi
}

# Choose cheatsheets I want to see
cheatsheets() {
  (cd $CHEATSHEETS; 
    cheatsheet=$($(__fzfcmd) --preview 'bat -n --color always '$CHEATSHEETS'/{}' --preview-window '80%,border-double' --bind 'focus:transform-preview-label:echo {+},up:preview-up,down:preview-down' --reverse --prompt='cheatsheet> ' -- "$@" < <(fd --type f --hidden --exclude .git . $CHEATSHEETS | sed -e "s#$CHEATSHEETS/\(.*\)#\1#g"));
  [ ! -z $cheatsheet ] && vi $cheatsheet)
}

# Use pass with fzf
pass_fzf() {

  pass=$($(__fzfcmd) --no-mouse --preview 'echo "Hit TAB to display {}"' --bind 'tab:preview:pass {}' --reverse --prompt='pass> ' -- "$@" < <(fd --type f . $HOME/.password-store | sed -e "s#$HOME/.password-store/\(.*\)\.gpg#\1#g"));
  [ ! -z $pass ] && pass -c $pass
}

# List recursively sorted by time
lstime() {
	if [ $# -eq 1 ]; then
		nb=$1
	else
		nb=10
	fi
  find . -type f -exec gstat --format '%Y :%y %n' "{}" \; | sort -nr | cut -d: -f2- | head -n $nb
}

# Stay in the current folder when exiting yazi
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
