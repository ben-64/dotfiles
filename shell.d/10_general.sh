#!/bin/sh

# If there is a venv, do load it
if [ -f ~/local/env/bin/activate ]; then
  source ~/local/env/bin/activate
fi  

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
