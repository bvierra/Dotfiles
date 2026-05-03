#!/usr/bin/env bash
if command -v aws_completer &> /dev/null
then
  cmd=$(which aws_completer)
  complete -C "$cmd" aws
fi
