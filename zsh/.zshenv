# . "$HOME/.cargo/env"
# PATH begin
# TODO why do some have path at beginning and some at end?
export PATH=/opt/homebrew/bin:$PATH
export PATH="/Applications/calibre.app/Contents/MacOS:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
# export PATH="/opt/homebrew/opt/ruby/bin:$PATH" #this changes default ruby from macOS to brew
# export PATH="$PATH:$GEM_HOME/bin"
# export PATH="$HOME/.gem/ruby/3.1.0/bin:$PATH"
# export PATH="$HOME/.local/share/gem/ruby/3.1.0/bin:$PATH"
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/opt/homebrew/bin/hashcat
export PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH" #adds homebrew make to path
export PATH="/opt/homebrew/opt/sphinx-doc/bin:$PATH"
# PATH end

# export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
# export LDFLAGS="-L/opt/homebrew/opt/libpcap/lib"

# export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
# export CPPFLAGS="-I/opt/homebrew/opt/libpcap/include"

export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libpcap/lib/pkgconfig"

# one-offs
export HOMEBREW_CASK_OPTS="--no-quarantine"
export EDITOR="code"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
# put GEM_HOME in zshrc to b lazy loaded
# export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export GOPATH=$HOME/go
export LANG=en_US.UTF-8


# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
# Compilation flags
# export ARCHFLAGS="-arch x86_64"
# export VISUAL='nano'