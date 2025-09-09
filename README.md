# Introduction

My dotfiles...

# Installation

```bash
$ git clone https://github.com/ben-64/dotfiles.git
$ cd dotfiles
$ git submodule update --init --recursive
```

# Dependencies

- fzf

```bash
$ git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
$ ~/.fzf/install
```

## Optionnal

### OSX

- ag: `brew install ag`
- zoxide: `brew install zoxide`
- bat: `brew install bat`
- delta: `brew install delta`
- eza: `brew install eza`
- hexyl: `brew install hexyl`
- power10k: `brew install romkatv/powerlevel10k/powerlevel10k`

- GPG agent
```
$ cat ~/.shell_$(hostname -s).d/gpgagent.sh
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
```

# Nice tools

## https://github.com/Aloxaf/fzf-tab

Allow to have `fzf` completion with commands
