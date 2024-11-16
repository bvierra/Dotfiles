#!/usr/bin/env bash
# Repo: https://github.com/bvierra/Dotfiles/blob/master/home/dot_config/bash/bashrc.d/kubectl.sh
# shellcheck shell=bash

if [[ -x "$(command -v kubectl)" ]]; then
  alias k=kubectl
  # shellcheck disable=SC1090
  source <(kubectl completion bash)
  complete -F __start_kubectl k
fi
