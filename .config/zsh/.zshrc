# Zach's macOS .zshrc
# Bunch of this is stolen from https://github.com/alichtman/dotfiles/blob/master/.zshrc

# START Prompt {{{

eval "$(starship init zsh)"

# END Prompt }}}

# START Env Vars {{{

export BETTER_EXCEPTIONS=1 # Python Better Exceptions
export BAT_THEME="1337"
export TERM=xterm-256color # fix for zsh-autosuggestions colors not being correct in tmux
export FZF_DEFAULT_COMMAND='fd -H -E ".git" -E ".DS_Store" --type file --follow --color=always'
export FZF_DEFAULT_OPTS="--cycle --ansi"
export FZF_BASE="/usr/local/bin/fzf"

# END Env Vars }}}

# START Plugins {{{

# oh-my-zsh plugins
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
if [ "$OS" = "Darwin" ]; then
  plugins=(
    git
    you-should-use
    zsh-autosuggestions
    zsh-completions
    git-it-on
  )
elif [ "$OS" = "Linux" ]; then
  plugins=(git)
fi

# zplug
source ~/.zplug/init.zsh

zplug "changyuheng/zsh-interactive-cd"
zplug "changyuheng/fz", defer:1
zplug "rupa/z", use:z.sh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# zplug check returns true if all packages are installed
# Therefore, when it returns false, run zplug install
if ! zplug check; then
    zplug install
fi

# z - https://github.com/rupa/z
[ "$OS" = "Darwin" ] && source $(brew --prefix)/etc/profile.d/z.sh
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

# fz - https://github.com/changyuheng/fz#macos
FZ_CMD=j
FZ_SUBDIR_CMD=jj

# END Plugins }}}

# START zsh Stuff {{{

set termguicolors
unsetopt nomatch # Fix $ git reset --soft HEAD^ error.

# Append a trailing `/' to all directory names resulting from globbing
setopt mark_dirs

source $ZSH/oh-my-zsh.sh

# START vi mode {{{
#
# Stolen from https://github.com/LukeSmithxyz/voidrice/blob/master/.config/zsh/.zshrc
# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# END vi mode }}}

# disable "r" command (which runs previous executed command)
# so that it doesnt interfere with the binary for "r" language.
disable r

# END zsh Stuff }}}

# START lf cd {{{

# stolen from https://github.com/LukeSmithxyz/voidrice/blob/master/.config/zsh/.zshrc
# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# END lf cd }}}

# START Completion {{{

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=46'

# Use hyphen-insensitive completion. Case sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Include dotfiles in completions
setopt globdots

export YSU_MESSAGE_POSITION="after" # Positioning message for you-should-use plugin

# homebrew completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip

# This is my favorite black magic...
# just type '...' to get '../..'
# Mikel Magnusson <mikachu@gmail.com> wrote this.
function _rationalise-dot() {
  local MATCH MBEGIN MEND
  if [[ $LBUFFER =~ '(^|/| |    |'$'\n''|\||;|&)\.\.$' ]]; then
    LBUFFER+=/
    zle self-insert
  fi
  zle self-insert
}
zle -N _rationalise-dot
bindkey . _rationalise-dot
# without this, typing a . aborts incremental history search
bindkey -M isearch . self-insert
# dito for searching in menu selection
bindkey -M menuselect . self-insert

autoload -U compinit && compinit

# toggl-cli completion
_toggl() {
  eval $(env COMMANDLINE="${words[1,$CURRENT]}" _TOGGL_COMPLETE=complete-zsh  toggl)
}
if [[ "$(basename -- ${(%):-%x})" != "_toggl" ]]; then
  compdef _toggl toggl
fi

# END Completion }}}

# Start FZF Stuff {{{

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# END FZF Stuff }}}

# safe-rm Stuff {{{

# Prompt to confirm rm DIR/*
unsetopt RM_STAR_SILENT
setopt RM_STAR_WAIT

# END safe-rm Stuff }}}

# History {{{

# remove command lines from the history list when the first character on the line is a space
setopt hist_ignore_space

export HIST_STAMPS="mm/dd/yyyy"
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
export HISTFILE="$XDG_CACHE_HOME/.zsh_history"

# END History }}}

# Sourcing Other Files {{{

source "$HOME/.secrets"

for file in $XDG_CONFIG_HOME/zsh/.{aliases,zfunctions}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# END Sourcing Other Files }}}

# Startup {{{

# stolen from alichtman/dotfiles
function execute_cmd_if_exists() {
    if hash "$1" 2>/dev/null; then
        "$1"
    fi
}

execute_cmd_if_exists days-until
# execute_cmd_if_exists tls

if [ "$OS" = "Linux" ]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
  source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh
fi

# END Startup }}}
