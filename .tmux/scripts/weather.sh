#! /bin/bash
# Uses wttr.in to get weather in current location. Might only works on macOS.

curl "wttr.in/?format=3&u" 2>/dev/null | xargs

# If your tmux status line doesn't support emojis
# curl "wttr.in/?format=%l:+%C+%t&u" 2>/dev/null | xargs
