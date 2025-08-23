#!/usr/bin/env bash
alias kns="kubectl-ns"
alias kctx="kubectl-ctx"

# Merge all ~/.kube/*.kubeconfig.yaml into ~/.kube/config
merge-kubeconfigs() {
  # shellcheck disable=SC2312
  KUBECONFIG="$(printf '%s:' "${HOME}"/.kube/*.kubeconfig.yaml | sed 's/:$//')" kubectl config view --flatten | tee "${HOME}/.kube/config"
}
