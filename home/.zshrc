eval "$(anyenv init -)"
eval "$(direnv hook zsh)"

alias gf='git fetch'
alias gr='git rebase'
alias gs='git stash'
alias gsp='git stash pop'
alias grc='git rebase --continue'
alias gm='git merge'
alias gb='git branch'
alias gsi='git switch'
alias gsc='git switch -c'
alias gca='git commit --amend'
alias gp='git push'
alias gpf='git push -f'

alias dpu='docker compose up'
alias dpd='docker compose down'
alias dpe='docker compose exec'
alias dpr='docker compose run'

alias l='ls -al --color=always'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

fgh() {
  local REPO_NAME="$(ghq list >/dev/null | fzf-tmux --reverse +m)"
  [[ -n "${REPO_NAME}" ]] && cd "$(ghq root)/${REPO_NAME}"
}

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
