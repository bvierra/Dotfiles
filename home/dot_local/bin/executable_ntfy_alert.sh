#!/usr/bin/env bash

source "${HOME}/.config/ntfy/exports.sh"

POSITIONAL_ARGS=()
HELP=""
D=0

debug() {
  if [[ "$D" -eq 1 ]]; then
    echo "DEBUG: $1"
  fi
}

while [[ $# -gt 0 ]]; do
  case $1 in
    -m|--message)
      debug "MSG = $2"
      MSG="$2"
      shift; shift;
      ;;
    -i|--icon)
      ICON="$2"
      shift; shift;
      ;;
    --tag)
      debug "tag: $2"
      ADD_TAG="$2"
      shift; shift;
      ;;
    --title)
      debug "title: $2"
      TITLE="$2"
      shift; shift;
      ;;
    --topic)
      debug "topic: $2"
      TOPIC="$2"
      shift; shift;
      ;;
    -u|--url)
      debug "url: $2"
      URL="$2"
      shift; shift;
      ;;
    -h|--help)
      debug "HELP"
      HELP="true"
      shift;
      ;;
    -at)
      debug "at: $2"
      TYPE="$2"
      shift; shift;
      ;;
    *)
      debug "*: $1"
      POSITIONAL_ARGS+=("$1")
      shift
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}"

help() {
  cat <<EOF
$0 --topic general --title "Alert Title" --tag "alert" --message "This is an alert"
    --message The body of the message (REQUIRED)
    --tag     Comma seperated list of tags (default: notification)
    --title   The title of the alert (default: Alert from <hostname>)
    --topic   The topic to send the alert to (default: general)
    --url     The URL of the ntfy server (default: https://ntfy.lab.vierra.host)
    --at      The alert type. Valid options are: pass, fail, none (default: none)
EOF
}

if [[ "$HELP" == "true" ]]; then
  help
  exit 0
fi

if [[ -n "${TOPIC+x}" ]] && [[ "${TOPIC}" == "k8s" ]]; then
  ICON="${icon_k8s}"
fi

if [[ -n "${TYPE+x}" ]]; then
  case $TYPE in
    pass)
      TYPE_TAG="${tag_good}"
      ;;
    fail)
      TYPE_TAG="${tag_bad}"
      ;;
    none)
      TYPE_TAG="${tag_none}"
      ;;
    *)
      echo "ERROR: Incorrect alert type (--at): ${TYPE}"
      help
      exit 1
      ;;
  esac
else
  TYPE_TAG="${tag_none}"
fi

if [[ -n "${ADD_TAG+x}" ]]; then
  TAG="${TYPE_TAG},${ADD_TAG}"
else
  TAG="${TYPE_TAG}"
fi


HOSTNAME=$(hostname -f)
TITLE="${TITLE:-Alert from ${HOSTNAME}}"
TOPIC="${TOPIC:-general}"
URL="${URL:-https://ntfy.lab.vierra.host}"
if [[ -z "${MSG}" ]]; then
  echo "-z ${MSG}"
  echo "ERROR: Missing message";
  help
  exit 1
fi

if [[ -n "${TOPIC+n}" ]]; then
  curl -H "tags:${TAG}" -H "Icon: ${ICON}" -H "X-Title: ${TITLE}" -d "${MSG}" --request POST "${URL}/${TOPIC}"
else
  curl -H "tags:${TAG}" -H "X-Title: ${TITLE}" -d "${MSG}" --request POST "${URL}/${TOPIC}"
fi
