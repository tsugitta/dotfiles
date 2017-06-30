if [ ~/dotfiles/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

if [ -e ~/.zshrc.private ]; then
  . ~/.zshrc.private
fi

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Path exportation & load plugins
#
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export PATH=~/.local/bin:$PATH
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
export PATH="./node_modules/.bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

eval "$(rbenv init -)"
# ruby() {
#   unset -f ruby rbenv
#   eval "$(command rbenv init -)"
#   ruby "$@"
# }
# rbenv() {
#   unset -f ruby rbenv
#   eval "$(command rbenv init -)"
#   rbenv "$@"
# }
#

eval "$(pyenv init -)"
# pip() {
#   unset -f pip python pyenv
#   eval "$(command pyenv init -)"
#   pip "$@"
# }
# python() {
#   unset -f pip python pyenv
#   eval "$(command pyenv init -)"
#   python "$@"
# }
# pyenv() {
#   unset -f pip python pyenv
#   eval "$(command pyenv init -)"
#   pyenv "$@"
# }

# [[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
go() {
  unset -f go gvm
  [[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
  go "$@"
}
gvm() {
  unset -f go gvm
  [[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
  gvm "$@"
}

# alias
alias -- -="cd -"
alias ...="../../"
alias ....="../../../"
alias c="cd"
alias cd="cdls"
alias ls="ls --color=auto"
alias l="ls -1A --color=auto"
alias be="bundle exec"
alias bi="bundle"
alias pi='pod install'
alias t="tmux"
alias a="tmux attach"
alias wh='which'
alias ti='tig'
alias ip='ifconfig | grep inet | grep broadcast | cut -d " " -f 2'
alias u='space2underscore -c'
alias fk='eval $(thefuck $(fc -ln -1))'
alias rm='rmtrash'
alias hb='hub browse'

# remove already merged branches
alias gbda='git branch --no-color --merged | command grep -vE "^(\*|\s*(master|develop|dev|staging)\s*$)" | command xargs -n 1 git branch -d'

alias -g G='| grep'
alias -g L='| less'
alias -g X='| xargs'
alias -g C='| pbcopy'

alias -s txt='cat'
alias -s rb='ruby'
alias -s py='python'

## rails
alias dlog='less log/development.log'
alias plog='less log/production.log'
alias tlog='less log/test.log'

alias -g RED='RAILS_ENV=development'
alias -g REP='RAILS_ENV=production'
alias -g RET='RAILS_ENV=test'

alias rc='bin/rails console'
alias rd='bin/rails destroy'
alias rg='bin/rails generate'
alias rgm='bin/rails generate migration'
alias ru='bin/rails runner'
alias rs='bin/rails server -b 0.0.0.0'
alias rsp='bin/rails server -b 0.0.0.0 --port'
alias rr='bin/rails runner'

alias rdm='bin/rake db:migrate'
alias rdr='bin/rake db:rollback'
alias rdc='bin/rake db:create'
alias rds='bin/rake db:seed'
alias rdd='bin/rake db:drop'
alias rdrs='bin/rake db:reset'

# misc
unsetopt correct # disable auto correct
setopt nonomatch

# function
function op() {
  if [ -z "$1" ]; then
    open .
  else
    open "$@"
  fi
}

function os() {
  if [ -z "$1" ]; then
    open -a sublime\ text .
  else
    open -a sublime\ text "$@"
  fi
}

function oa() {
  if [ -z "$1" ]; then
    open -a /Applications/Atom.app .
  else
    open -a /Applications/Atom.app "$@"
  fi
}

function ov() {
  if [ -z "$1" ]; then
    open -a /Applications/Visual\ Studio\ Code.app .
  else
    open -a /Applications/Visual\ Studio\ Code.app "$@"
  fi
}

function vi() {
  if [ -z "$1" ]; then
    mvim .
  else
    mvim "$@"
  fi
}

function cdls() {
  \cd "$@" && ls
}

# peco
autoload -Uz is-at-least
if is-at-least 4.3.11
then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':chpwd:*' recent-dirs-max 5000
  zstyle ':chpwd:*' recent-dirs-default yes
  zstyle ':completion:*' recent-dirs-insert both
fi

peco-select-history() {
  if ! type tac > /dev/null 2>&1; then
    echo "  x [Warning] tac is not installed"
    exit 1
  fi

  BUFFER=$(\history -n 1 | \
    tac | \
    peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}

zle -N peco-select-history
bindkey '^r' peco-select-history

function peco-get-destination-from-cdr() {
  cdr -l | \
  sed -e 's/^[[:digit:]]*[[:blank:]]*//' | \
  peco --query "$LBUFFER"
}

function peco-cdr() {
  local destination="$(peco-get-destination-from-cdr)"
  if [ -n "$destination" ]; then
    BUFFER="cd $destination"
    zle accept-line
  else
    zle reset-prompt
  fi
}
zle -N peco-cdr
bindkey '^x' peco-cdr
