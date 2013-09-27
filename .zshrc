# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"
#ZSH_THEME="agnoster"

DEFAULT_USER="eric"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/Cellar/emacs/24.3/bin:$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:~/bin:~/bin/play:~/Library/Haskell/bin

################################################################################ 
# Git

alias gs='git status'
alias gl='git log --stat'

function gcm() { git commit -au -m "$@" ;} # Fast git commit with message
function gcmp() { git commit -au -m "$@" ; git push; } # GCM and push

################################################################################ 

alias ezsh='e ~/.zshrc'
alias szsh='source ~/.zshrc'

alias rh="runhaskell"
alias xo='xdg-open'
alias e='emacs -nw'

alias play2102='~/Downloads/Play20/play'

alias jj="java -jar"
alias openCVToMaven='mvn install:install-file -Dfile=/usr/local/share/OpenCV/java/opencv-290.jar -DgroupId=opencv -DartifactId=opencv -Dversion=2.4.9 -Dpackaging=jar'
alias openCVClearIvy='rm -rf ~/.ivy2/cache/opencv'
alias openCVUpdateIvy='openCVToMaven; openCVClearIvy'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias pwdcp='pwd | pbcopy'

# Kills all processes matching regex.
function ekill() { ps aux | grep -e "$@" | grep -v grep | awk '{print $2}' | xargs -i kill -9 {}; }

