#!/usr/bin/env bash

eval "$(mise activate bash)"

### mise-completions-sync
# ## Install:
# mise use -g github:alltuner/mise-completions-sync
# ## Config:
# mkdir -p ~/.config/mise && cat >> ~/.config/mise/config.toml << 'EOF'
# [hooks]
# postinstall = "mise-completions-sync"
# EOF
#  ## Add completions
comp_dir="${XDG_DATA_HOME:-$HOME/.local/share}/mise-completions/bash"
if [[ -d "${comp_dir}" ]]; then
  for f in ${comp_dir}/*; do
    [[ -f "$f" ]] && source "$f"
  done
fi
unset comp_dir
