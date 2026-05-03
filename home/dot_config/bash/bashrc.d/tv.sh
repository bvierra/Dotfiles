#!/usr/bin/env bash
if ! command -v tv &> /dev/null; then
  if command -v mise; then
    mise use -g "github:alexpasmantier/television"@latest
  fi
else
  eval "$(tv init bash)"
fi
