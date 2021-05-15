# Introduction

- `pathogen` is used for managing vim plugins

## pathogen

In order to disable some plugins at startup, add this line before *infecting* with `pathogen`:

```vimrc
let g:pathogen_blacklist = [ 'ultisnips' ]
execute pathogen#infect()
```

# Bundles

- fzf: Pour avoir un historique puissant
- lightline: La barre du bas
- nerdtree: F2 pour naviguer dans le FS
- rainbow: Pour coloriser les parenthèses
- vim-gitbranch: pour afficher la branche du clone (utilisé dans lightline)
- ultisnips: Pour gérer les snipplets
- vim-snippets: Snippets utilisées par ultisnips
- CCTree: Fonctionne avec des programmes en C pour afficher les fonctions appelantes ou appelées d'une fonction
- mark: Pour coloriser un ou plusieurs mots dans tout le buffer

## ultisnips

- On console only need some additionnal packages

```bash
$ apt install vim-gui-common vim-runtime
```
