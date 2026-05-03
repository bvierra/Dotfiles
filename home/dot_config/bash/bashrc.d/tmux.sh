#!/usr/bin/env bash
tm() {
  SESSION_NAME=$1
  if [ -z "$SESSION_NAME" ]; then
    echo "Usage: tm <session-name> [window-name]"
    return 1
  fi

  # Check if the session already exists
  if ! tmux has-session -t="$SESSION_NAME" 2>/dev/null; then
    # Create a new detached session with the given name
    tmux new-session -d -s "$SESSION_NAME"
    echo "Created new tmux session: $SESSION_NAME"
  fi

  # Optional: Handle window naming if a second argument is provided
  if [ ! -z "$2" ]; then
    WINDOW_NAME=$2
    # Check if window exists, if not create and name it
    if ! tmux list-windows -t="$SESSION_NAME" | grep -q "$WINDOW_NAME"; then
      tmux new-window -t="$SESSION_NAME" -n="$WINDOW_NAME"
      echo "Created new window: $WINDOW_NAME"
    fi
    # Select the specified window
    tmux select-window -t="$SESSION_NAME:$WINDOW_NAME"
  fi

  # Attach to the session
  tmux attach-session -t="$SESSION_NAME"
}
export -f tm