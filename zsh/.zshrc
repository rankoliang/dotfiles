# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

DOTFILES=$HOME/.dotfiles
ZSH_PLUGINS=$DOTFILES/zsh/plugins
[ -d $ZSH_PLUGINS ] || mkdir $ZSH_PLUGINS
ZSH_CONFIG=$HOME/.config/zsh
[ -d $ZSH_CONFIG ] || mkdir $ZSH_CONFIG

export EDITOR=/usr/bin/vim

# Setup p10k
source $ZSH_PLUGINS/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.dotfiles/zsh/.p10k.zsh.
[[ ! -f $DOTFILES/zsh/.p10k.zsh ]] || source $DOTFILES/zsh/.p10k.zsh


# Improves file globbing, like using the ^ to negate the pattern following it
setopt extendedglob
# cd without cd
# setopt autocd
# A command name with a = prepended is replaced with its full pathname.
# Uncomment to turn off:
# setopt noequals

# Function to access a directory by using ~dir_name (dir_name passed as a parameter)
# http://zsh.sourceforge.net/Intro/intro_5.html#SEC5
namedir () { eval $1=$PWD ; : ~$1 }

# Setup directory stack (http://zsh.sourceforge.net/Intro/intro_6.html#SEC6)
DIRSTACKSIZE=8
setopt autopushd pushdminus pushdsilent pushdtohome
alias dh='dirs -v'

# imports aliases
source $DOTFILES/aliases/.aliases

# Exports all manually installed apt packages
[[ -f ~/.dependencies/apt-base-manual.txt ]] && eamsm

# Enables vim mode
bindkey -v
  
# https://www.johnhawthorn.com/2012/09/vi-escape-delays/
# Sets the default keytimeout to 10 ms
KEYTIMEOUT=1

bindkey -a u undo
bindkey -a '^r' redo

bindkey -M vicmd "^r" fzf-history-widget
bindkey -M vicmd "^[c" fzf-cd-widget

function fzf-preview {
  if [[ $_p9k__keymap == "vicmd" || -z $BUFFER ]]; then
    # # This approach has issues with tmux-vim-navigator
    # local file=$(fzfp)
    # [[ -f $file ]] && $($EDITOR $file < /dev/tty) 
    local file=$(fzfp)
    if [[ -f $file ]]; then
      BUFFER=""
      LBUFFER="$(basename $EDITOR) $file"
    fi
  else
    LBUFFER="${LBUFFER}$(fzfp -m --height=70% | tr '\n' ' ')"
  fi
  local ret=$?
  zle reset-prompt
  return $ret
}
zle -N fzf-preview
bindkey -M vicmd "^p" fzf-preview 
bindkey -M viins "^p" fzf-preview 

# Use bat as a manpager
export MANPAGER="sh -c 'col -bx | batcat -l man -p'"

source $DOTFILES/nvm/nvm.sh
source $DOTFILES/rbenv/rbenv.sh
source $DOTFILES/pyenv/pyenv.sh

# Add path to exa
path+=("$HOME/.cargo/bin")

# PLUGINS (https://github.com/unixorn/awesome-zsh-plugins)

# Enables z command
source $ZSH_PLUGINS/zsh-z/zsh-z.plugin.zsh
# For autocomplete on the z plugin
autoload -U compinit && compinit
# Tab complete menu
# zstyle ':completion:*' menu select

# History from Oh My ZSH (https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/history.zsh)
HISTFILE=$ZSH_CONFIG/.zsh_history
source $ZSH_PLUGINS/history/history.zsh

# fzf from Oh My ZSH (https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/fzf/fzf.plugin.zsh)
source $ZSH_PLUGINS/fzf/fzf.plugin.zsh

export FZF_DEFAULT_OPS="--extended"
export FZF_CTRL_T_OPTS="--select-1 --exit-0"
# Options to fzf command
export FZF_COMPLETION_OPTS='-x'
export FZF_DEFAULT_COMMAND='fdfind --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"

# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fdfind --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fdfind --type d --hidden --follow --exclude ".git" . "$1"
}

source $ZSH_PLUGINS/fzf-tab/fzf-tab.plugin.zsh

source $ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh

# Enable for solarized theme
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'

# solarized dir colors
# https://github.com/joel-porquet/zsh-dircolors-solarized
# Run setupsolarized to use theme
source $ZSH_PLUGINS/zsh-dircolors-solarized/zsh-dircolors-solarized.zsh

[[ -f $DOTFILES/local/.zshrc.local ]] && source $DOTFILES/local/.zshrc.local

# MUST BE AT THE END OF THE FILE
# Syntax highlighting
source $ZSH_PLUGINS/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

