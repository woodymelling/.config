#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Youtube Audio Download
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🎵
# @raycast.argument1 { "type": "text", "placeholder": "URL" }

# Documentation:
# @raycast.description Download an audio file
# @raycast.author Woody

yt-dlp --embed-thumbnail --no-mtime -f m4a -x -P '~/Music/Youtube Downloads' $1 1> /dev/null

