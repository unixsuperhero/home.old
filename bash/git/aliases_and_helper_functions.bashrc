# git aliases

alias gaa="git add --all"
alias gai="git add -i"
alias gb='git branch'
alias gc='git commit'
alias gco='git co'
alias gd='git diff'
alias gdc='git diff --cached'
alias gp='git push'
alias gpr='git pull --rebase'
alias grv='git remote -v'
alias gst='git status -s'
alias glod='git log --oneline --decorate --graph'
alias glodd='git log --oneline --decorate --graph -10'
alias glog='git log --oneline --decorate --graph --name-status'
alias glogg='git log --oneline --decorate --graph --name-status -10'
alias glr='git log --oneline --decorate --left-right'

alias gchist='(cd; git add */history; git commit -m "updating history files")'
alias gchistory='(cd; git add */history; git commit -m "updating history files")'

function gac() {
  git add --all

  if test ${#@} -gt 0; then
    git commit -m "$@"
  else
    git commit
  fi
}
