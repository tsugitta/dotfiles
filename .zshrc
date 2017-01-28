if [ ~/dotfiles/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

# import
if [ -e ~/.zshrc.private ]; then
  . ~/.zshrc.private
fi

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# init settings
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export PATH=~/.local/bin:$PATH
eval "$(rbenv init -)"
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
export PATH="./node_modules/.bin:$PATH"

# alias
alias -- -="cd -"
alias ...="../../"
alias ....="../../../"
alias c="cd"
alias cd="cdls"
alias be="bundle exec"
alias bi="bundle"
alias t="tmux"
alias a="tmux attach"
alias wh='which'
alias ti='tig'
alias ip='ifconfig | grep inet | grep broadcast | cut -d " " -f 2'
alias u='space2underscore -c'
alias fk='eval $(thefuck $(fc -ln -1))'
alias rm='rmtrash'
alias hb='hub browse'

alias -g G='| grep'
alias -g L='| less'
alias -g X='| xargs'

alias -s txt='cat'
alias -s rb='ruby'
alias -s py='python'

alias pi='pod install'

## git
alias gbda='git branch --no-color --merged | command grep -vE "^(\*|\s*(master|develop|dev|staging)\s*$)" | command xargs -n 1 git branch -d'

## rails
alias dlog='less log/development.log'
alias plog='less log/production.log'
alias tlog='less log/test.log'

alias -g RED='RAILS_ENV=development'
alias -g REP='RAILS_ENV=production'
alias -g RET='RAILS_ENV=test'

alias rc='bundle exec rails console'
alias rd='bundle exec rails destroy'
alias rdb='bundle exec rails dbconsole'
alias rg='bundle exec rails generate'
alias rgm='bundle exec rails generate migration'
alias rp='bundle exec rails plugin'
alias ru='bundle exec rails runner'
alias rs='bundle exec rails server'
alias rsb='bundle exec rails server -b 0.0.0.0'
alias rsd='bundle exec rails server --debugger'
alias rsp='bundle exec rails server --port'

alias rdm='bundle exec rake db:migrate'
alias rdms='bundle exec rake db:migrate:status'
alias rdr='bundle exec rake db:rollback'
alias rdc='bundle exec rake db:create'
alias rds='bundle exec rake db:seed'
alias rdd='bundle exec rake db:drop'
alias rdrs='bundle exec rake db:reset'
alias rdtc='bundle exec rake db:test:clone'
alias rdtp='bundle exec rake db:test:prepare'
alias rdmtc='bundle exec rake db:migrate db:test:clone'
alias rlc='bundle exec rake log:clear'
alias rn='bundle exec rake notes'
alias rr='bundle exec rake routes'
alias rrg='bundle exec rake routes | grep'
alias rt='bundle exec rake test'
alias rmd='bundle exec rake middleware'
alias rsts='bundle exec rake stats'

# misc
unsetopt correct

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
