# shellcheck shell=bash
alias cat="bat"

alias bathelp='bat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}

export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

batdiff() {
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
}

battail() {
  tail -f "$@" | bat --paging=never -l log
}
