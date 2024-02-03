# https://wiki.zshell.dev/docs/guides/benchmark#-profile-zshrc-startup
PROFILE_STARTUP=false

if [[ "$PROFILE_STARTUP" == true ]]; then
  zmodload zsh/zprof
  PS4=$'%D{%M%S%.} %N:%i> '
  exec 3>&2 2>$HOME/startlog.$$
  setopt xtrace prompt_subst
fi


# TODO scope 
# TODO https://github.com/mafredri/zsh-async

# Zmodloads https://zsh.sourceforge.io/Doc/Release/Shell-Builtin-Commands.html#index-zmodload

zmodload zsh/curses # required for ziconsole https://wiki.zshell.dev/ecosystem/plugins/zi-console
# module_path+=( "/Users/aidangibson/.zi/zmodules/zpmod/Src" )
# zmodload zi/zpmod

# Install Zi if not already installed
if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod go-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi


source "$HOME/.zi/bin/zi.zsh" # wiki.zshell.dev

# ~/.zshenv for env vars is loaded by zsh so no need to source

# Setopts https://zsh.sourceforge.io/Doc/Release/Options.html
  setopt append_history         # Allow multiple sessions to append to one Zsh command history.
  setopt extended_history       # Show timestamp in history.
  setopt hist_expire_dups_first # Expire A duplicate event first when trimming history.
  setopt hist_ignore_all_dups   # Remove older duplicate entries from history.
  setopt hist_ignore_dups       # Do not record an event that was just recorded again.
  setopt inc_append_history     # Write to the history file immediately, not when the shell exits.
  setopt share_history          # Share history between different instances of the shell.
  setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
  setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
  setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
  setopt HIST_NO_STORE             # Don't store history commands

  setopt auto_cd              # Use cd by typing directory name if it's not a command.
  setopt auto_pushd           # Make cd push the old directory onto the directory stack.
  setopt interactive_comments # Comments even in interactive shells.
  setopt pushd_ignore_dups    # Don't push multiple copies directory onto the directory stack.
  setopt pushd_minus          # Swap the meaning of cd +1 and cd -1 to the opposite.
  # setopt SOURCE_TRACE # shows all loaded config files in order of load; great for troubleshooting
  # https://www.reddit.com/r/zsh/comments/h9mdvc/why_do_i_get_this_error_zsh_no_matches_found/


# Bindkeys
# TODO set cmd+shift+F to rga-fzf https://wiki.zshell.dev/docs/guides/syntax/bindkey#-bindkey

# ZStyles https://wiki.zshell.dev/docs/guides/customization#style-the-completion-system-with-zstyle https://unix.stackexchange.com/questions/214657/what-does-zstyle-do/239980
#
# Prompt First
if [[ ! $TERM_PROGRAM = "WarpTerminal" ]] # not warp
  then
  # not warp, starship
  zi ice as"command" from"gh-r" \
    atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
    atpull"%atclone" src"init.zsh"
  zi ice lucid wait'!0'
  zi light starship/starship
else # if warp
  export STARSHIP_CONFIG="$HOME/.dotfiles/zsh/starshipwarp.toml"
  # warp TODO it needs to not load ❯ when in warp bc warp truncates input after that, so i don't see if im in a conda env etc https://github.com/warpdotdev/Warp/issues/765. be mindful that if i comment this out, not loading starship on warp, and run `bu` from warp, other shells will break TODO yeet starship for warp
  zi ice as"command" from"gh-r" \
    atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
    atpull"%atclone" src"init.zsh"
  zi light starship/starship
  fi



# Zsh-defer can't be deferred itself, it must run before it is used
zi light romkatv/zsh-defer

# TODO idk
  # Metaplugins https://wiki.zshell.dev/ecosystem/annexes/meta-plugins
  # zi light-mode for z-shell/z-a-meta-plugins \
  #   @annexes+ @console-tools @ext-git @fuzzy @py-utils @rust-utils @sharkdp @z-shell @zsh-users+fast @zunit @zsh-users
  # this is all of em except: @z-shell+ @prezto @developer-tools @fuzzy-src @romkatv

# direnv stuff
  zi ice as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' \
    atpull'%atclone' src"zhook.zsh"
  zi light direnv/direnv

# old
  # Oh-My-Zsh Library  https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/
  # backslash just escapes the newline char, using for readability 
  # zi-turbo a-c 0-9. heavier things should be loaded later. syntax highlighters must be loaded last
  # zi-turbo '0a' for \
  #   OMZL::bzr.zsh \
  #   OMZL::cli.zsh \
  #   OMZL::clipboard.zsh \
  #   OMZL::completion.zsh \
  #   OMZL::correction.zsh \
  #   OMZL::directories.zsh \
  #   OMZL::misc.zsh \
  #   OMZL::prompt_info_functions.zsh \
  #   OMZL::termsupport.zsh \
  #   OMZL::vcs_info.zsh \
  #   OMZL::grep.zsh \
  #   OMZL::history.zsh \
  #   OMZL::key-bindings.zsh \
  #   OMZL::git.zsh \
  #   OMZL::compfix.zsh \
  #   OMZL::diagnostics.zsh \
  #   OMZL::spectrum.zsh \
  #   OMZL::functions.zsh
  # ones im not using (but this may update in the future so kinda a shitty system)
  # OMZL::theme-and-appearance.zsh DO NOT USE this shit aliases ls to ls -G
  # Oh-My-Zsh Plugins https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
  # If an OMZP isn't working, try adding OMZL's it depends on I may not have loaded

#TODO not working; look at that issue for acs
# for macOS, prolly need `brew tap homebrew/command-not-found`
zi-turbo '0b' for \
  OMZP::command-not-found  #idek if this works
  # OMZP::aliases # 
# old 
#   OMZP::colored-man-pages
# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/termsupport.zsh \

# Github Plugins
zi-turbo '0c' for \
  lukechilds/zsh-nvm \
  z-shell/zui \
  z-shell/zi-console \
  MichaelAquilina/zsh-you-should-use \
  z-shell/zbrowse

# zsh-you-should-use reminds u to use alias u have set

# VERY slow way to load meta plugins 
# zi light-mode for z-shell/z-a-meta-plugins \
#   @annexes+ @console-tools @ext-git @fuzzy @py-utils @rust-utils @sharkdp @z-shell @zsh-users+fast @zunit @zsh-users


# # Fast way to load metaplugins 
# zi light z-shell/z-a-meta-plugins
# zi ice wait
# zi light @annexes+

# feature-rich syntax highlighting https://wiki.zshell.dev/ecosystem/plugins/f-sy-h
zi wait lucid for \
  atinit"ZI[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    z-shell/F-Sy-H \
  blockf \
    zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions



# syntax is part of @zsh-users, no overhead is added anyway so fuck it. keeping so I remember how to filter by term_program
# Syntax highlighting must be loaded last. doesn't work in warp, they use their own highlighting
# if [[ ! $TERM_PROGRAM = "WarpTerminal" ]]
# then
# zi-turbo '9c' for \
#   zsh-users/zsh-syntax-highlighting
# fi

# TODO move this to a sep file; fig out ocd solution to functions 
rga-fzf() {
	RG_PREFIX="rga -i --files-with-matches --hidden --type all"
	local file
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&a
	open "$file"
}

rga-fzfa() {
	RG_PREFIX="rga --hidden -i --files-with-matches --type all --rga-adapters=pdfpages,tesseract"
	local file
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&a
	open "$file"
}




venv () { 
	[ -f bin/activate ] || [ -f venv/bin/activate ] || python3 -m venv .; 
# source bin/activate 2> /dev/null || source venv/bin/activate   # commented out by conda initialize
	}

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}




# Save command history
# name it something other than .zsh_history so default settings don't erase old hist if histsize doesn't get sourced
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_h
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

#TODO doesn't work
unpriv() {
  # Clear in-memory history to prevent saving commands from the private session.
  fc -p /dev/null # temporarily sets the history file to /dev/null, effectively clearing the in-memory history.
  HISTFILE=${ZDOTDIR:-$HOME}/.zsh_h
  HISTSIZE=999999999
  SAVEHIST=$HISTSIZE
  # Restore the previous history file to resume normal operation.
  fc -P # restores the previous history file path, which allows zsh to start saving history again.
}


priv() {
  unset HISTFILE
}

# zsh-defer export GEM_HOME="$(ruby -e 'puts Gem.user_dir')" # TODO do i need this given that I'm using frum? also its pointing to 2.6 (macOS install) ):
zsh-defer eval "$(frum init)"




# TODO all path stuff in zshenv / deferred
# should i use eval "$(/opt/homebrew/bin/brew shellenv)"

# TODO put all fncs in sep file or folder and zsh-defer loading it


mkdr () {
  mkdir -p -- "$1" && 
  cd -P -- "$1"
}
# "which IP"
# tailscale ip -4
# tailscale ip -6
wip () {
  echo "$(connectionType) via $(priorityInterface) ($(ifconfig $(priorityInterface) | awk '/ether/{print $2}'))"
  echo "Internal  IPv4: $(ipconfig getifaddr $(priorityInterface))"
  ip=$(curl -s http://api.ipify.org)
  echo "Public    IPv4: $ip"
  ip6=$(curl -s http://api6.ipify.org)
  if [[ -n "$ip6" ]]; then
    echo "Public   IPv6: $ip6"
  fi

ts_status=$(tailscale status)

if [[ "$ts_status" != "Tailscale is stopped." ]]; then
  tailscale_ip=$(tailscale ip -4)
  tailscale_ip6=$(tailscale ip -6)
  echo "Tailscale IPv4: $tailscale_ip"
  echo "Tailscale IPv6: $tailscale_ip6"
fi
speedtest
}


priorityInterface ()
{
    route get default | awk '/interface/ {print $2}'
}
interfaceType ()
{
    ifconfig -v $1 | awk '/type: / {print $2}'
}
connectionType ()
{
    interfaceType $(priorityInterface)
}




# open man pages in dash
encodeuri() {
  local string="$*"
  local strlen=${#string}
  local encoded=""

  for (( pos = 0; pos < strlen; pos ++ )); do
    c=${string:$pos:1}
    case "$c" in
      [-_.~a-zA-Z0-9]) o="${c}" ;;
      *) printf -v o '%%%02x' "'$c"
    esac
    encoded+="${o}"
  done
  echo "${encoded}"
}
man() {
  if [[ -d /Applications/Dash.app && \
    -d "$HOME/Library/Application Support/Dash/DocSets/Man_Pages" ]]; then
    /usr/bin/open dash://$(encodeuri "$@")
  else
    /usr/bin/man "$@"
  fi
}
##################################################################################

# uses preview. no links or colors tho. https://scriptingosx.com/2022/11/on-viewing-man-pages-ventura-update/
# more sophisticated version of the script w caching here https://gist.github.com/PicoMitchell/619c12fd6a53ae6ec657514915d4edf9
# preman() {
#     mandoc -T pdf "$(/usr/bin/man -w $@)" | open -fa Preview
# }
export PATH=$PATH:/Users/aidangibson/.spicetify

# do what it normally does. but then also add a link to google maps lat+long
# command keyword prevents function from calling itself recursively. By using the command keyword, you explicitly instruct the shell to bypass any function or alias with the same name and execute the actual command or utility directly.
# $@ is all of the positional parameters (so u don't lose exiftool options i may have placed)
exiftool() {
  command exiftool "$@"
  pos=`command exiftool -c '%.8f' -s3 -GPSPosition "$_"`
  echo $pos
  #replace spaces with %20
  # ${var//<pattern>/<replacement>} replaces all pattern with replacement
  encoded_pos=${pos//" "/"%20"}
  # Replace commas with %2C
  encoded_pos=${encoded_pos//","/"%2C"}

  echo "https://maps.apple.com/?q=${encoded_pos}"
  echo "https://www.google.com/maps/search/?api=1&query=${encoded_pos}"
}

# gc() {
#   git clone "$1" && cd "$(basename "$1" .git)"
# }

gc() {
  git clone "$@"
  cd "$(basename "$1" .git)"
}
kill () {
  command kill -KILL $(pidof "$@")
}
# Export nvm completion settings for zsh-nvm plugin
export NVM_COMPLETION=true
export NVM_LAZY_LOAD=true

# zi light lukechilds/zsh-nvm

zsh-defer source "$HOME/.zaliases"

bullshit() {
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
}
zsh-defer bullshit


#shasum -a 256 nmapReed.txt is mac way, diff way on linux

v () {
    vt file "$(shasum -a 256 "$1" | cut -d ' ' -f 1)"
}
chan() {
    curl --form-string "text=$1" "https://api.chanify.net/v1/sender/$CHAN"
}


# load_conda() {
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!

con() {
__conda_setup="$('/Users/aidangibson/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/aidangibson/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/aidangibson/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/aidangibson/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
# }
# zsh-defer load_conda
}
zsh-defer con


nixu() {
  local commit_message="$1"
  nix flake update --commit-lock-file
  git commit -am "$commit_message"
  git push
}

# some old bullshit 

# Add any commands which depend on conda here
#TODO yeet this, it's making 'python' be python2.7. make it a function and defer it
# lazy_conda_aliases=('python' 'conda')
# load_conda() {
#   for lazy_conda_alias in $lazy_conda_aliases
#   do
#     unalias $lazy_conda_alias
#   done

#   __conda_prefix="$HOME/opt/anaconda3" # Set your conda Location

#   # >>> conda initialize >>>
#   __conda_setup="$("$__conda_prefix/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
#   if [ $? -eq 0 ]; then
#       eval "$__conda_setup"
#   else
#       if [ -f "$__conda_prefix/etc/profile.d/conda.sh" ]; then
#           . "$__conda_prefix/etc/profile.d/conda.sh"
#       else
#           export PATH="$__conda_prefix/bin:$PATH"
#       fi
#   fi
#   unset __conda_setup
#   # <<< conda initialize <<<

#   unset __conda_prefix
#   unfunction load_conda
# }

# for lazy_conda_alias in $lazy_conda_aliases
# do
#   alias $lazy_conda_alias="load_conda && $lazy_conda_alias"
# done
# Created by `pipx` on 2023-08-08 04:04:10
export PATH="$PATH:/Users/aidangibson/.local/bin"

sourcing() {
source <(pkgx --shellcode)  #docs.pkgx.sh/shellcode
source /Users/aidangibson/.config/broot/launcher/bash/br
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
}
zsh-defer sourcing




if [[ "$PROFILE_STARTUP" == true ]]; then
  unsetopt xtrace
  exec 2>&3 3>&-; zprof > ~/zshprofile$(date +'%s')
fi