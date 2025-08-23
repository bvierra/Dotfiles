#!/usr/bin/env bash
# !! This file is managed by chezmoi !!
# !! Any changes created may be overwritten on next run !!
# Repo: https://github.com/bvierra/Dotfiles/
#
# shellcheck shell=bash


# Define the base directory for Obsidian notes
# shellcheck disable=SC2034,SC2154
obsidian_base="${WIN_OBSIDIAN}/ML Prompts"
if [[ -d ~/.config/fabric/patterns ]]; then
  # Loop through all files in the ~/.config/fabric/patterns directory
  for pattern_file in ~/.config/fabric/patterns/*; do
      # Get the base name of the file (i.e., remove the directory path)
      pattern_name=$(basename "$pattern_file")

      # Unalias any existing alias with the same name
      unalias "ml-${pattern_name}" 2>/dev/null

      # Define a function dynamically for each pattern
      eval "
        ml-${pattern_name}() {
          local title=\$1
          local date_stamp=\$(date +'%Y-%m-%d')
          local output_path=\"\$obsidian_base/\${date_stamp}-\${title}.md\"

          # Check if a title was provided
          if [ -n \"\$title\" ]; then
              # If a title is provided, use the output path
              fabric --pattern \"$pattern_name\" -o \"\$output_path\"
          else
              # If no title is provided, use --stream
              fabric --pattern \"$pattern_name\" --stream
          fi
      }
      "
  done
fi
