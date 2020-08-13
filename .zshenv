# Zach Gorman's .zshenv

export OS="$(uname -s)"

# Defaults
[ "$OS" = "Linux" ] && export TERMINAL='st'
[ "$OS" = "Linux" ] && export PASTEL_COLOR_MODE=24bit
export EDITOR='nvim'
export VISUAL='nvim'

# XDG (for future OS interoperability)
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# Directories and ~ Cleanup
# config
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
export WAKATIME_HOME="$XDG_CONFIG_HOME"/wakatime
export ANSIWEATHERRC="$XDG_CONFIG_HOME"/ansiweather/config
export AWS_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME"/httpie
export MPLCONFIGDIR="$XDG_CONFIG_HOME"/matplotlib
export TMUX_PLUGIN_MANAGER_PATH="$XDG_CONFIG_HOME"/tmux/plugins/
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/config
export GRIPHOME="$XDG_CONFIG_HOME"/grip

# data
export AWS_CLI_HISTORY_FILE="$XDG_DATA_HOME"/aws/history
export AZURE_CONFIG_DIR="$XDG_DATA_HOME"/azure
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export PLTUSERHOME="$XDG_DATA_HOME"/racket
export GEM_HOME="$XDG_DATA_HOME"/gem
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export ZPLUG_HOME="$XDG_DATA_HOME"/zplug
export GOPATH="$XDG_DATA_HOME"/go

# cache
export _Z_DATA="$XDG_CACHE_HOME"/.z
export LESSHISTFILE="$XDG_CACHE_HOME"/lesshst
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME"/npm
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages

# runtime
#export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR"/npm

if [ "$OS" = "Darwin" ]; then
  export ZSH="$HOME"/.oh-my-zsh
elif [ "$OS" = "Linux" ]; then
  export ZSH="$HOME"/.config/.oh-my-zsh
fi

# lf icons {{{

export LF_ICONS="di=📁:\
fi=📃:\
tw=🤝:\
ow=📂:\
ln=⛓:\
or=❌:\
ex=🎯:\
*.txt=✍:\
*.mom=✍:\
*.me=✍:\
*.ms=✍:\
*.png=🖼:\
*.ico=🖼:\
*.jpg=📸:\
*.jpeg=📸:\
*.gif=🖼:\
*.svg=🗺:\
*.xcf=🖌:\
*.html=🌎:\
*.xml=📰:\
*.gpg=🔒:\
*.css=🎨:\
*.pdf=📚:\
*.djvu=📚:\
*.epub=📚:\
*.csv=📓:\
*.xlsx=📓:\
*.tex=📜:\
*.md=📘:\
*.r=📊:\
*.R=📊:\
*.rmd=📊:\
*.Rmd=📊:\
*.mp3=🎵:\
*.opus=🎵:\
*.ogg=🎵:\
*.m4a=🎵:\
*.flac=🎼:\
*.mkv=🎥:\
*.mp4=🎥:\
*.webm=🎥:\
*.mpeg=🎥:\
*.avi=🎥:\
*.zip=📦:\
*.rar=📦:\
*.7z=📦:\
*.tar.gz=📦:\
*.z64=🎮:\
*.v64=🎮:\
*.n64=🎮:\
*.1=ℹ:\
*.nfo=ℹ:\
*.info=ℹ:\
*.log=📙:\
*.iso=📀:\
*.img=📀:\
*.bib=🎓:\
*.ged=👪:\
*.part=💔:\
*.torrent=🔽:\
"

# lf icons }}}

# GCC

if [ "$OS" = "Darwin" ]; then
  export CC=/usr/local/gcc-9.2/bin/gcc-9.2
  export LD=/usr/local/gcc-9.2/bin/gcc-9.2
fi

# PATH

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/sbin"
export PATH="$PATH:/usr/local"
export PATH="$PATH:/usr/sbin"
export PATH="$PATH:/usr/local/sbin"
export PATH="$CARGO_HOME/bin:$PATH"
[ "$OS" = "Linux" ] && export PATH="$PATH:$GOPATH/bin"
if [ "$OS" = "Darwin" ]; then
  export PATH="$PATH:$HOME/Library/Python/3.7/bin"
  export PATH="$PATH:/usr/local/anaconda3/bin"
  export PATH="$PATH:/usr/local/gcc-9.2/bin"
  export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Deduplicate entries in PATH
typeset -U PATH
export PATH
