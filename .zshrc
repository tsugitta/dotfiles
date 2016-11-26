# import
if [ -e ~/.zshrc.private ]; then
  . ~/.zshrc.private
fi

# oh-my-zsh settings
export ZSH=~/.oh-my-zsh
plugins=(git)
source $ZSH/oh-my-zsh.sh

# powerline settings (install with python installed by pyenv)
POWERLINE_CUSTOM_CURRENT_PATH="%4~"
POWERLINE_HIDE_HOST_NAME="true"
POWERLINE_DETECT_SSH="true"
export PATH=~/.local/bin:$PATH
powerline-daemon -q
. ~/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

# init settings
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export PATH=~/.nodebrew/current/bin:$PATH
eval "$(rbenv init -)"
source $(brew --prefix nvm)/nvm.sh
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"

# alias
alias c="cd"
alias cd="cdls"
alias ls="gls --color=auto -F"
alias be="bundle exec"
alias bi="bundle"
alias t="tmux"
alias a="tmux attach"
alias ctags="`brew --prefix`/bin/ctags"
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

## rails
alias devlog='tail -f log/development.log'
alias prodlog='tail -f log/production.log'
alias testlog='tail -f log/test.log'

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
    open -a atom .
  else
    open -a atom "$@"
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

function gplrb {
  if [ -z "$1" ]; then
    echo 'error: Speify the target branch'
  else
    git pull origin $@:$@
    git stash
    git rebase $@
    git stash pop
  fi
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
