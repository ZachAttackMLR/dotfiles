#! /bin/bash
# Uses wttr.in to get weather in current location.

curl "wttr.in/?format=%l:+%c+%t&u" 2>/dev/null | cut -d":" -f 2 | xargs

# If your tmux status line doesn't support emojis
# curl "wttr.in/?format=%l:+%C+%t&u" 2>/dev/null | xargs
