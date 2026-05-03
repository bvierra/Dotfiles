#!/usr/bin/env bash
if ! command -v tv &> /dev/null; then
  if command -v mise; then
    mise use -g "aqua:joshmedeski/sesh"@latest
  fi
else
  source <(sesh completion bash)  
fi
