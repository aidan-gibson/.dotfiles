# Zmodloads https://zsh.sourceforge.io/Doc/Release/Shell-Builtin-Commands.html#index-zmodload
zmodload zsh/zprof # enables zprof command
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
# https://www.reddit.com/r/zsh/comments/h9mdvc/why_do_i_get_this_error_zsh_no_matches_found/


# Bindkeys
# TODO set cmd+shift+F to rga-fzf https://wiki.zshell.dev/docs/guides/syntax/bindkey#-bindkey

# ZStyles https://wiki.zshell.dev/docs/guides/customization#style-the-completion-system-with-zstyle https://unix.stackexchange.com/questions/214657/what-does-zstyle-do/239980
#
# Prompt First
if [[ ! $TERM_PROGRAM = "WarpTerminal" ]]
then
zi ice wait as"command" from"gh-r" \
  atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
  atpull"%atclone" src"init.zsh"
zi ice lucid wait'!0'
zi load starship/starship
else
zi ice as"command" from"gh-r" \
  atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
  atpull"%atclone" src"init.zsh"
zi light starship/starship
fi
# Zsh-defer can't be deferred itself, it must run before it is used
zi light romkatv/zsh-defer
#
# Metaplugins https://wiki.zshell.dev/ecosystem/annexes/meta-plugins
# zi light-mode for z-shell/z-a-meta-plugins \
#   @annexes+ @console-tools @ext-git @fuzzy @py-utils @rust-utils @sharkdp @z-shell @zsh-users+fast @zunit @zsh-users
# this is all of em except: @z-shell+ @prezto @developer-tools @fuzzy-src @romkatv

# Oh-My-Zsh Library  https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/
# backslash just escapes the newline char, using for readability 
# zi-turbo a-c 0-9. heavier things should be loaded later. syntax highlighters must be loaded last
# zi-turbo '0a' for \
#   OMZL::git.zsh \
#   OMZL::compfix.zsh \
#   OMZL::diagnostics.zsh \
#   OMZL::spectrum.zsh \
#   OMZL::functions.zsh \
#   OMZL::theme-and-appearance.zsh \
#   OMZL::bzr.zsh \
#   OMZL::cli.zsh \
#   OMZL::clipboard.zsh \
#   OMZL::completion.zsh \
#   OMZL::directories.zsh \
#   OMZL::grep.zsh \
#   OMZL::history.zsh \
#   OMZL::key-bindings.zsh \
#   OMZL::misc.zsh \
#   OMZL::prompt_info_functions.zsh \
#   OMZL::termsupport.zsh \
#   OMZL::vcs_info.zsh \
# ones im not using (but this may update in the future so kinda a shitty system)

# Oh-My-Zsh Plugins https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
# If an OMZP isn't working, try adding OMZL's it depends on I may not have loaded
zi-turbo '0b' for \
  OMZP::command-not-found \
  OMZP::colored-man-pages \
  https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/termsupport.zsh \
  OMZP::aliases

# Github Plugins
zi-turbo '0c' for \
  z-shell/zui \
  z-shell/zi-console \
  MichaelAquilina/zsh-you-should-use \
  z-shell/zbrowse


zsh-defer export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"









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
# rga-fzf() {
# 	RG_PREFIX="rga --files-with-matches"
# 	local file
# 	file="$(
# 		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
# 			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
# 				--phony -q "$1" \
# 				--bind "change:reload:$RG_PREFIX {q}" \
# 				--preview-window="70%:wrap"
# 	)" &&
# 	echo "opening $file" &&a
# 	xdg-open "$file"
# }

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

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

source "$HOME/.zaliases"


# Save command history
# name it something other than .zsh_history so default settings don't erase old hist if histsize doesn't get sourced
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_h
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
export PATH="/opt/homebrew/opt/sphinx-doc/bin:$PATH"

# TODO defer this
eval "$(frum init)"

# https://unix.stackexchange.com/questions/125385/combined-mkdir-and-cd
mkdr () {
  mkdir -p -- "$1" && 
  cd -P -- "$1"
}