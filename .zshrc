# import
for f in .zshrc.*
do
  . "$HOME"/"$f"
done

# oh-my-zsh settings
export ZSH=~/.oh-my-zsh
plugins=(git)
source $ZSH/oh-my-zsh.sh

# powerline settings
POWERLINE_CUSTOM_CURRENT_PATH="%4~"
POWERLINE_HIDE_HOST_NAME="true"
POWERLINE_DETECT_SSH="true"
export PATH=$PATH:~/Library/Python/2.7/bin
powerline-daemon -q
. ~/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh

# init settings
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
export PATH=~/.nodebrew/current/bin:$PATH
export PATH=/usr/local/Cellar/vim/7.4.1063/bin:$PATH
eval "$(rbenv init -)"
source ~/.nvm/nvm.sh

# Android Studio
export JAVA8_HOME=$(/usr/libexec/java_home -v 1.8)
export PATH=$PATH:~/Library/Android/sdk/platform-tools/

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
alias vi='vim'
alias ti='tig'
alias ip='ifconfig | grep inet | grep broadcast | cut -d " " -f 2'
alias u='space2underscore -c'
alias ocaml="rlwrap ocaml"

alias -g G='| grep'
alias -g L='| less'
alias -g X='| xargs'

alias -s txt='cat'
alias -s rb='ruby'

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


function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
function is_osx() { [[ $OSTYPE == darwin* ]]; }
function is_screen_running() { [ ! -z "$STY" ]; }
function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

function tmux_automatically_attach_session()
{
    if is_screen_or_tmux_running; then
        ! is_exists 'tmux' && return 1
    else
        if shell_has_started_interactively && ! is_ssh_running; then
            if ! is_exists 'tmux'; then
                echo 'Error: tmux command not found' 2>&1
                return 1
            fi

            if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
                # detached session exists
                tmux list-sessions
                echo -n "Tmux: attach? (y/N/num) "
                read
                if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
                    tmux attach-session
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
                    tmux attach -t "$REPLY"
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                fi
            fi

            if is_osx && is_exists 'reattach-to-user-namespace'; then
                # on OS X force tmux's default command
                # to spawn a shell in the user's namespace
                tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
                tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
            else
                tmux new-session && echo "tmux created new session"
            fi
        fi
    fi
}
tmux_automatically_attach_session
