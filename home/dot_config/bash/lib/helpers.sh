#!/usr/bin/env bash
# !! This file is managed by chezmoi !!
# !! Any changes created may be overwritten on next run !!
# Repo: https://github.com/bvierra/Dotfiles/
#
# shellcheck shell=bash

#######################################
# Appends a path to the PATH variable
# Arguments:
#   Path to append (accepts multiple)
#######################################
pathappend() {
  for ARG in "$@"
  do
    if [[ -d "${ARG}" ]] && [[ ":${PATH}:" != *":${ARG}:"* ]]; then
        PATH="${PATH:+"${PATH}:"}${ARG}"
    fi
  done
}

#######################################
# Prepends a path to the PATH variable
# Arguments:
#   Path to prepend (accepts multiple)
#######################################
pathprepend() {
  for ((i=$#; i>0; i--));
  do
    ARG=${!i}
    if [[ -d "${ARG}" ]] && [[ ":${PATH}:" != *":${ARG}:"* ]]; then
        PATH="${ARG}${PATH:+":${PATH}"}"
    fi
  done
}
