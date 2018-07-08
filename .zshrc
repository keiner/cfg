#ZSH THEME-----------------------{{{
# Path to custom ZSH Theme
export ZSH_CUSTOM=$HOME/cfg/
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bureau_custom"
#-----------------------}}}
#STUFF---------------------{{{
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
 #COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
## -----------------------}}}
#PLUGINS-----------------------{{{
plugins=(git)
plugins=(zsh-autosuggestions)
bindkey '^ ' autosuggest-accept
source $ZSH/oh-my-zsh.sh
#-----------------------}}}
# USER CONFIGURATION-----------------------{{{

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
## -----------------------}}}
#ALI  -----------------------{{{
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

if [ -f ~/cfg/.aliasesrc ]; then
	. ~/cfg/.aliasesrc
fi
#-----------------------}}}
#SCRIPTS-----------------------{{{
. ~/cfg/scripts/.play
. ~/cfg/scripts/.interpr
#-----------------------}}}
#TMUX-----------------------{{{
if [ -z $TMUX ];   then                 
	  /usr/bin/tmux attach || /usr/bin/tmux new
  fi 
#-----------------------}}}
 #TODO LIST -----------------------{{{
if [ -f ~/.todo ]; then
    cat ~/.todo
fi      
#-----------------------}}}
#EDITOR-----------------------{{{
export EDITOR='vim'
#-----------------------}}}
 #REMOTE SOUND-----------------------{{{
# pactl load-module module-tunnel-sink-new server=minnimi sink_name=Remote channels=2 rate=44100
#-----------------------}}}
#PERL-----------------------{{{
PERL_MB_OPT="--install_base \"/home/$USER/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/$USER/perl5"; export PERL_MM_OPT;
#-----------------------}}}
#NVM-----------------------{{{
export NVM_DIR="/home/$USER/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion
#-----------------------}}}
