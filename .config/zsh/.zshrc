# Zach's macOS .zshrc
# Bunch of this is stolen from https://github.com/alichtman/dotfiles/blob/master/.zshrc

# START Prompt {{{

eval "$(starship init zsh)"

# END Prompt }}}

# START Env Vars {{{

export BETTER_EXCEPTIONS=1 # Python Better Exceptions
export BAT_THEME="1337"
export TERM=xterm-256color # fix for zsh-autosuggestions colors not being correct in tmux

# END Env Vars }}}

# START Plugins {{{

# oh-my-zsh plugins
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  you-should-use
  zsh-autosuggestions
  zsh-completions
  git-it-on
)

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
source $(brew --prefix)/etc/profile.d/z.sh

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

# Autojump - just in case
#[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# END zsh Stuff }}}

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

fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U compinit && compinit

# END Completion }}}

# Start FZF Stuff {{{

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# END FZF Stuff }}}

# safe-rm Stuff {{{

# if you're wondering wtf this is, it's form ~/.aliases

# Prompt to confirm rm DIR/*
unsetopt RM_STAR_SILENT
setopt RM_STAR_WAIT

# END safe-rm Stuff }}}

# History {{{

setopt hist_ignore_space    # remove command lines from the history list when the first character on the line is a space

export HIST_STAMPS="mm/dd/yyyy"
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
export HISTFILE="$XDG_CACHE_HOME/.zsh_history"

# END History }}}

# Sourcing Other Files {{{

for file in $XDG_CONFIG_HOME/zsh/.{aliases,zfunctions,zprofile,secrets}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# END Sourcing Other Files }}}

days-until