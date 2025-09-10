#! /usr/bin/env bash

# edit this file as you see fit for your setup

SESSION_NAME="session_name" # change session name
NOTES_DIR="notes_dir" # change this to notes directory
PROJECT_NVIM_COMMAND="nvim ." # nvim command to run on the project window

# Check if session already exists
tmux has-session -t $SESSION_NAME 2>/dev/null

if [ $? != 0 ]; then
  # Create new session with window 1 (nvim)
  tmux new-session -d -s $SESSION_NAME:0 -n nvim "$PROJECT_NVIM_COMMAND"

  # Window 2: term (split with npm start)
  tmux new-window -t $SESSION_NAME:1 -n term
  tmux split-window -h -t $SESSION_NAME:1 "npm start"

  # Window 3: git
  tmux new-window -t $SESSION_NAME:2 -n git

  # Window 4: notes (cd + nvim .)
  tmux new-window -t $SESSION_NAME:3 -n notes "cd $NOTES_DIR && nvim ."
fi

# Always open in first window
tmux select-window -t $SESSION_NAME:0
# Attach to session
tmux attach -t $SESSION_NAME


