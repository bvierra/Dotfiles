#!/usr/bin/env bash
# Sets kubectl krew home dir to ~/.local/share/krew
export KREW_ROOT="${HOME}/.local/share/krew"
pathprepend "${KREW_ROOT}/bin"
