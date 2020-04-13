# Zach Gorman's .zprofile

#export OS="$(uname -s)"

# Editor stuff
#export EDITOR='nvim'
#export VISUAL='nvim'

# XDG (for future interoperability)
#export XDG_DATA_HOME="$HOME/.local/share"
#export XDG_CONFIG_HOME="$HOME/.config"
#export XDG_CACHE_HOME="$HOME/.cache"

# Directories and ~ Cleanup
#export ZDOTDIR=$XDG_CONFIG_HOME/zsh
#export WAKATIME_HOME=$XDG_CONFIG_HOME/wakatime
#export _Z_DATA=$XDG_CACHE_HOME/.z
#export LESSHISTFILE=$XDG_CACHE_HOME/lesshst
#export ZSH=$HOME/.oh-my-zsh

# GCC

#export CC=/usr/local/gcc-9.2/bin/gcc-9.2
#export LD=/usr/local/gcc-9.2/bin/gcc-9.2

# PATH

#export PATH="$HOME/.cargo/bin:$PATH"
#export PATH="$PATH:$HOME/.local/bin"
#export PATH="$PATH:/usr/local/bin"
#export PATH="$PATH:/sbin"
#export PATH="$PATH:/usr/local"
#export PATH="$PATH:/usr/sbin"
#export PATH="$PATH:/usr/local/sbin"
#export PATH="$PATH:$HOME/Library/Python/3.7/bin"
#export PATH="$PATH:/usr/local/anaconda3/bin"
#export PATH="$PATH:/usr/local/gcc-9.2/bin"

# set PATH so it includes user's private bin if it exists
#if [ -d "$HOME/bin" ]; then
#  PATH="$HOME/bin:$PATH"
#fi

#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
#export PATH="$PATH:$HOME/.rvm/bin"

# Deduplicate entries in PATH
#typeset -U PATH
#export PATH

