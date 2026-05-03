#!/usr/bin/env bash
alias awsd="source _awsd"
source /usr/local/bin/_awsd_autocomplete
if [ -f ~/.awsd ]; then
  if grep -q '=' ~/.awsd; then
    while IFS='=' read -r k v; do
      case "$k" in
        profile) [ -n "$v" ] && export AWS_PROFILE="$v" ;;
        region)  [ -n "$v" ] && export AWS_REGION="$v" AWS_DEFAULT_REGION="$v" ;;
      esac
    done < ~/.awsd
  else
    export AWS_PROFILE=$(cat ~/.awsd)
  fi
fi

