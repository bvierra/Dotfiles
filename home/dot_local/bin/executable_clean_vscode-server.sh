#!/usr/bin/env bash

# Taken from https://gist.github.com/XDflight/5f3509eb84fc282b88059c909036f5bc

rm -rf ~/.cache 2> /dev/null

if [ ! -d ~/.vscode-server ]; then
  echo "\"~/.vscode-server\" does not exist."
  exit 0
fi

shopt -s extglob

rm -rf ~/.vscode-server/data/CachedExtensionVSIXs

SERVER_VERSION=$(grep -oE '[0-9a-f]{40}' ~/.vscode-server/cli/servers/lru.json | head -n1)
echo "[\"Stable-$SERVER_VERSION\"]" > ~/.vscode-server/cli/servers/lru.json
rm -rf ~/.vscode-server/cli/servers/Stable-!($SERVER_VERSION)
rm -f ~/.vscode-server/code-!($SERVER_VERSION)

rm -rf ~/.vscode-server/extensions/*.vsctmp

declare -A exts
for lsout in $(cd ~/.vscode-server/extensions && ls -rvd */); do
  ext_fullname=${lsout::-1}
  ext_version=$(grep -oP '\-\d+\.\d+\.\d+' <<< "$ext_fullname")
  ext_name=${ext_fullname/$ext_version}
  ext_version=${ext_version:1}
  if [[ -n "${exts[$ext_name]+isset}" ]]; then
    rm -rf ~/.vscode-server/extensions/$lsout
  else
    exts[$ext_name]=$ext_version
  fi
done

shopt -u extglob
