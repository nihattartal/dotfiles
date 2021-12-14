# If you come from bash you might have to change your $PATH.
export DISABLE_SPRING=1
export PATH=$HOME/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="false"

ZSH_DISABLE_COMPFIX="true"
# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git history fzf)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)"
  fi
}


#VIM
alias vi="$EDITOR"
alias vim="$EDITOR"

# Alex's git rebase selector
FZF_PREVIEW_BINDINGS="--bind page-up:preview-page-up,page-down:preview-page-down"
AUTOCOMPLETE_FZF_OPTIONS="--height ${FZF_TMUX_HEIGHT:-60%} ${FZF_PREVIEW_BINDINGS} ${FZF_DEFAULT_OPTS} -n2..,.. \
      --tiebreak=index $FZF_CTRL_R_OPTS +m"
git_autocomplete() {
  local selected preview_bindings
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  selected=$(run_selection_program $LBUFFER)
  LBUFFER="${LBUFFER}${selected}"
  local ret=$?
  zle reset-prompt
  return $ret
}
run_selection_program() {
  buffer=$1
  if [[ $buffer =~ "git rebase" ]] || [[ $buffer =~ "git commit --fixup" ]]; then
    git list-branch-commits | run_fzf_with_preview "git show {}"
  elif [[ $buffer =~ "git add" ]] || [[ $buffer =~ "git reset" ]] ; then
    { git diff --name-only; git ls-files --others --exclude-standard; } | run_fzf_with_preview "git ls-files --error-unmatch 2> /dev/null {} && git diff {} || git diff --no-index /dev/null {}"
  else
    git list-branch-commits | run_fzf_with_preview "git show {}"
  fi
}
run_fzf_with_preview() {
  FZF_DEFAULT_OPTS=${AUTOCOMPLETE_FZF_OPTIONS} fzf --preview="$1"
}

zle     -N   git_autocomplete
bindkey '^G' git_autocomplete

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh
if [ -e /Users/ntartal/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/ntartal/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

[[ -f /opt/dev/sh/chruby/chruby.sh ]] && type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; }

[[ -x /usr/local/bin/brew ]] && eval $(/usr/local/bin/brew shellenv)

[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)
