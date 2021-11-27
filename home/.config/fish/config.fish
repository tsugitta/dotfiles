set PATH /opt/homebrew/bin $PATH

set -x PATH ~/.anyenv/bin $PATH
eval (anyenv init - | source)

set PATH $PATH ~/dev/bin

if status is-interactive
  # Commands to run in interactive sessions can go here
end

alias dpu='docker-compose up'
alias dpd='docker-compose down'
alias dpe='docker-compose exec'
alias dpr='docker-compose run'
alias t='tmux'
alias a='tmux attach'
alias ti='tig'
alias l='exa -alh'

function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
end

set GHQ_SELECTOR peco

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/tsugitta/dev/google-cloud-sdk/path.fish.inc' ]; . '/Users/tsugitta/dev/google-cloud-sdk/path.fish.inc'; end

abbr -a gd "git diff -M"
abbr -a ga "git add"
abbr -a gb "git branch"
abbr -a gs "git stash"
abbr -a gsp "git stash pop"
abbr -a gr "git rebase"
abbr -a gsi "git switch"
abbr -a gsc "git switch -c"
abbr -a gm "git merge"
abbr -a gp "git push"
abbr -a gf "git fetch"
abbr -a grh "git reset --hard"
abbr -a grs "git reset --soft"
abbr -a gsc "git switch -c"
abbr -a gcp "git cherry-pick"
abbr -a gca "git commit --amend"

abbr -a pi "pod install"
abbr -a op "open"

eval (direnv hook fish)
