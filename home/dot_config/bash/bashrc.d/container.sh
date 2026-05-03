#!/usr/bin/env bash
container-cmd() {
  command="${1:-/bin/bash}"
  if [ $# -ge 2 ]; then
    container_id="$2"
  else
    container_id=$(docker ps --format '{{.Names}} | {{.ID}} | {{.Status}}' | fzf | awk '{print $3}')
  fi

  docker exec -it "$container_id" "$command"
}
export -f container-cmd

container-enter() {
  if [ $# -ge 1 ]; then
    container_id="$1"
  else
    container_id=$(docker ps --format '{{.Names}} | {{.ID}} | {{.Status}}' | fzf | awk '{print $3}')
  fi

  if ! docker exec -it "$container_id" /bin/bash; then
		if ! docker exec -it "$container_id" /bin/sh; then
			if ! docker exec -it "$container_id" /bin/dash; then
				echo "Could not find a shell to use, sorry!"
			fi
		fi	
	fi
}
export -f container-enter
