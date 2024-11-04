#!/usr/bin/env bash

krew=~/.local/share/krew/bin/kubectl-krew
bash_completion_dir=~/.local/share/bash-completion/completions

# ctx
if [[ $($krew list  | grep -c ctx) -eq 0 ]]; then
  $krew install ctx
fi
if [[ ! -f $bash_completion_dir/kubectx ]]; then
  curl https://raw.githubusercontent.com/ahmetb/kubectx/refs/heads/master/completion/kubectx.bash -o ${bash_completion_dir}/kubectx
  # shellcheck disable=SC1091
  . ${bash_completion_dir}/kubectx
fi


if [[ $($krew list | grep -c ns) -eq 0 ]]; then
  $krew install ns
fi
if [[ ! -f $bash_completion_dir/kubens ]]; then
  curl https://raw.githubusercontent.com/ahmetb/kubectx/refs/heads/master/completion/kubens.bash -o ${bash_completion_dir}/kubens
  # shellcheck disable=SC1091
  . ${bash_completion_dir}/kubens
fi

if [[ $($krew get-all | grep -c get-all) -eq 0 ]]; then
  $krew install get-all
fi

