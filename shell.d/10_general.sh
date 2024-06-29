#!/bin/zsh

# If there is a venv, do load it
if [ -f ~/local/env/bin/activate ]; then
  source ~/local/env/bin/activate
fi  


# Some ENV
export BAT_THEME=tokyonight_night
export BAT_THEME=gruvbox-dark
# thefuck alias
if exist thefuck; then
    eval $(thefuck --alias)
    eval $(thefuck --alias fk)
fi


## FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"


show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# --- setup fzf theme ---
# https://vitormv.github.io/fzf-themes/
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#d0d0d0,fg+:#d0d0d0,bg:#121212,bg+:#365a81
  --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#87ff00
  --color=prompt:#d7005f,spinner:#af5fff,pointer:#af5fff,header:#87afaf
  --color=border:#262626,label:#aeaeae,query:#d9d9d9
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="> "
  --marker=">" --pointer="◆" --separator="─" --scrollbar="│"'

## FZF Git
if [ -f $TOOLS/fzf-git.sh/fzf-git.sh ]; then
    unset beep
    set nobeep
    source $TOOLS/fzf-git.sh/fzf-git.sh
    gwt() {
        cd "$(_fzf_git_worktrees --no-multi)"
    }
    gb() {
        _fzf_git_branches
    }
    gc() {
        _fzf_git_hashes
    }
    gf() {
        _fzf_git_files
    }
fi

## forgit
if [ -f $TOOLS/forgit/forgit.plugin.zsh ]; then
    export COLUMNS
    export FZF_PREVIEW_COLUMNS
    export FORGIT_PAGER='delta --side-by-side -w ${FZF_PREVIEW_COLUMNS:-$COLUMNS}'
    export FORGIT_INSTALL_DIR=$OOLS/forgit
    source $TOOLS/forgit/forgit.plugin.zsh
fi
