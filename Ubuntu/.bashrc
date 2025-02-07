# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# --- oh my posh terminal
eval "$(oh-my-posh init bash --config ~/custom.omp.json)"
# to fix unrendered space color in vscode terminal
clear

# --- gdb gef, no header info
alias gdb='gdb -q'

# --- homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1

# --- bat (better cat)
alias cat='bat --style="plain"'

# --- fzf, to find file/dir faster
eval "$(fzf --bash)"
# use fd instead of fzf
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
# Use fd (https://github.com/sharkdp/fd) for listing path candidates
# the first argument to the function ($1) is the base path to start traversal
# see the source code (completion.{bash,zsh}) for the details
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}
# use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# --- eza (much better ls)
alias ls='eza -la --no-user --no-permissions --icons=always'

# --- tldr (much friendlier man)
alias man='tldr'

# --- thefuck, to fix wrong syntax in command
eval $(thefuck --alias)
eval $(thefuck --alias tf)

# --- zoxide/z (better cd)
eval "$(zoxide init bash)"
alias cd='z'

# --- ripgrep/rg (better grep)
alias grep='rg'

# --- shortcut for update & upgrading apt and brew
alias aptbrew='sudo apt-get update -y && sudo apt-get upgrade -y && brew update && brew upgrade'

# --- open vsc in windows instead
code() {
     /mnt/c/Users/daffa/AppData/Local/Programs/Microsoft\ VS\ Code/Code.exe "$@" >/dev/null 2>&1 & disown
}
# alias code='/mnt/c/Users/daffa/AppData/Local/Programs/Microsoft\ VS\ Code/Code.exe "$@" >/dev/null 2>&1'

# --- use windows' python
alias py='/mnt/c/Users/daffa/AppData/Local/Microsoft/WindowsApps/python.exe'
alias pip='/mnt/c/Users/daffa/AppData/Local/Microsoft/WindowsApps/pip3.exe'

# --- git command aliases
alias gitp='git push -u origin'
alias gitc='git commit -m'
alias gitac='git add -A; git commit -m'
alias gita='git add'
alias gits='git status'
alias gitpu='git pull'
alias gitco='git checkout'
alias gitl='git log'
gitacp() {
    if [ "$#" -ne 2 ]; then
        echo "Usage: gitac \"commit message\" branch-name"
        return 1
    fi

    local commit_message="$1"
    local branch_name="$2"

    git add -A
    git commit -m "$commit_message"
    git push origin "$branch_name"
}

# pyenv
eval "$(pyenv init --path)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# alias for volatility
alias vol='python3 /mnt/c/Users/daffa/Documents/CTF\ Tools/volatility3/vol.py'

# alias for nvm win
# alias nvmw='/mnt/c/Users/daffa/AppData/Roaming/nvm/nvm.exe'

# alias for clear
alias c="clear"

# alias for node win (v22)
alias node='/mnt/c/Program\ Files/nodejs/node.exe'
alias npm='/mnt/c/Program\ Files/nodejs/npm'
alias npx='/mnt/c/Program\ Files/nodejs/npx'
alias ni='/mnt/c/Program\ Files/nodejs/npm install'
alias nr='/mnt/c/Program\ Files/nodejs/npm run'
alias nrd='/mnt/c/Program\ Files/nodejs/npm run dev'

# alias to open explorer on current dir
alias exp="explorer.exe ."

# alias for HxD
alias hxd="/mnt/c/Program\ Files/HxD/HxD.exe"

# alias for Audacity
alias auda="/mnt/c/Program\ Files/Audacity/Audacity.exe"

# alias for tweakpng
alias tweakpng="/mnt/c/Users/daffa/Documents/CTF\ Tools/tweakpng-1.4.6/x64/tweakpng.exe"

# alias for ImHex
alias imhex='/mnt/c/Program\ Files/ImHex/imhex-gui.exe'

# alias for john tools
alias zip2john='john-the-ripper.zip2john'
alias 7z2john='john-the-ripper.7z2john'
alias pdf2john='python3 /mnt/c/Users/daffa/Documents/CTF\ Tools/john-jumbo/run/pdf2john.py'

# alias for pdf-parser
alias pdfparser='python3 /mnt/c/Users/daffa/Documents/CTF\ Tools/pdf-parser.py'

# java compiler and runner shortcut
jav() {
    local filename="$1"
    local classname="${filename%.*}"
    javac "$filename" && java -cp . "$classname"
}

# prioritize apt over brew and user specific package
export PATH=/usr/bin:$PATH

# --- micro text editor typa shii
alias m='micro'

# --- var to store rockyou location
export rockyou='/home/praya/rockyou.txt'

# --- deno
alias deno='/mnt/c/Users/daffa/.deno/bin/deno.exe'

# --- bun
alias bun='/mnt/c/Users/daffa/.bun/bin/bun.exe'

# --- directory aliases
export doc="/mnt/c/Users/daffa/Documents/"
export down="/mnt/c/Users/daffa/Downloads/"
export daffa="/mnt/c/Users/daffa/"

# --- notepad++
alias note="/mnt/c/Program\ Files/Notepad++/notepad++.exe"

# --- dfx (icp)
. "$HOME/.local/share/dfx/env"

# --- run windows's flutter in ubuntu
flutter() {
    # Translate the current WSL directory to Windows path
    local win_dir
    win_dir=$(wslpath -w "$PWD")
    
    # Check if the path translation was successful
    if [[ -z "$win_dir" ]]; then
        echo "Error: Unable to translate the current directory to Windows path."
        return 1
    fi
    
    # Assemble Flutter arguments with proper quoting
    local args=("$@")
    local flutter_args=""
    for arg in "${args[@]}"; do
        # Escape any existing double quotes in arguments
        arg="${arg//\"/\\\"}"
        flutter_args+="$arg "
    done
    # Trim trailing space
    flutter_args=${flutter_args% }
    
    # Execute Flutter command via cmd.exe using 'flutter' (not 'flutter.exe')
    cmd.exe /C "flutter $flutter_args"
}

