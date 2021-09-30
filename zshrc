# Initialize colors.
autoload -U colors && colors

# Initialize git/hg/svn info
#############################
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg svn
zstyle ':vcs_info:git*+set-message:*' hooks git-st git-stash
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '!'
zstyle ':vcs_info:*' unstagedstr '⚡'
zstyle ':vcs_info:git*:*' get-revision true
zstyle ':vcs_info:git*' formats "%{${fg[default]}%} : %{${fg[yellow]}%}[%b%u] %c"
. ~/.zsh/functions/vcs_functions.sh
precmd() {
	vcs_info
}
##############################

# Allow for functions in the prompt.
setopt prompt_subst

## Autoload zsh functions.
fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)

## Completion
#fpath=(~/.zsh/completion $fpath)
#autoload -Uz compinit && compinit -i

# Do not kill running jobs when exiting zsh
setopt NO_HUP
setopt NO_CHECK_JOBS  # Avoid warning

# Report CPU usage for commands running longer than 5 seconds
export REPORTTIME=30

# Sexy Completion
autoload -U compinit && compinit
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' menu select=2	# Histoire d'avoir la completion avec les fléches
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh_cache
zmodload zsh/complist
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"
unsetopt list_ambiguous

# History management
export HISTSIZE=2000
export SAVEHIST=2000
export HISTFILE="$HOME/.history"
setopt hist_ignore_dups	# On ignore les duplications
setopt hist_ignore_space	# Tout ce qui commence par un %20 n'est pas sauvegardé

# Extended regular expression
setopt extendedglob

# vi for command line
autoload edit-command-line
zle -N edit-command-line
bindkey '\ee' edit-command-line

# Demande de confirmation pour un rm *
unsetopt rm_star_silent

# Command correction
#setopt correctall

# Environment variables
export PS1=$(echo -ne "%{$fg[red]%}%n%{$reset_color%}@%{$fg[magenta]%}%m%{$reset_color%} : %{$fg[cyan]%}%*\${vcs_info_msg_0_}\n%{$fg[green]%}%(?..[%?])%{$fg[blue]%}%~%f%%%{$reset_color%} ")
export EDITOR="vim"
export PATH=$PATH:~/bin
export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -\""
export WORDCHARS="_-"

# Load different source files
CONF="$HOME/.shell_aliases $HOME/.shell_functions $HOME/.shell_private /usr/share/autojump/autojump.sh"
for conf in $(echo $CONF); do
	if [ -e "$conf" ]; then
		source $conf
	fi
done

# Load host specific files
[ -e $HOME/.shell_$HOST ] && source $HOME/.shell_$HOST
if [ -d ~/.shell_$HOST.d ]; then
   for sh in ~/.shell_$HOST.d/*; do
      if [ -f $sh ]; then
         source $sh
      fi
   done
fi

umask 0022
