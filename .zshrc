# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"

DEFAULT_USER="ericmc"

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
source /etc/bash_completion.d/g4d

#source ~/.secrets.sh

# Customize to your needs...
export PATH=~/.cabal/bin:/usr/bin:$PATH:~/bin/scalaIDE:~/bin/eclipse:/usr/local/Cellar/emacs/24.3/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:~/bin:~/bin/play:~/bin/activator:~/Library/Haskell/bin:/usr/local/MATLAB/R2013a/bin

#export GOPATH=$HOME/Dropbox/t/2014_q2/go
export GOROOT=/usr/lib/google-golang
export PATH=$PATH:$GOPATH/bin:$HOME/bin/google-cloud-sdk/bin:$HOME/bin/ImageJ:$HOME/bin/julia
export PATH=~/.cabal/bin:$PATH
export PATH=~/bin/blender:$PATH

################################################################################
# Git

#alias gs='git status'
#alias gl='git log --stat'

#function gcm() { git commit -au -m "$@" ;} # Fast git commit with message
#function gcmp() { git commit -au -m "$@" ; git push; } # GCM and push

################################################################################

alias ezsh='e ~/.zshrc'
alias vzsh='v ~/.zshrc'
alias szsh='source ~/.zshrc'

alias rh="runhaskell"
alias xo='xdg-open'
alias e='emacs -nw'
alias v='vim'
alias s='~/bin/SublimeText2/sublime_text'
function ns { nohup ~/bin/SublimeText2/sublime_text $1 &; }
#alias ns='nohup ~/bin/SublimeText2/sublime_text &'

alias jj="java -jar"
alias openCVToMaven='mvn install:install-file -Dfile=/usr/local/share/OpenCV/java/opencv-300.jar -DgroupId=opencv -DartifactId=opencv -Dversion=3.0.0 -Dpackaging=jar'
alias openCVClearIvy='rm -rf ~/.ivy2/cache/opencv'
alias openCVUpdateIvy='openCVToMaven; openCVClearIvy'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias pwdcp='pwd | pbcopy'
alias finddirs='find . -type d'

#export SBT_OPTS="-Xmx8g"
export JAVA_HOME=/usr/lib/jvm/java-7-oracle

# Kills all processes matching regex.
function ekill() { ps aux | grep -e "$@" | grep -v grep | awk '{print $2}' | xargs -i kill -9 {}; }

# unregister broken GHC packages. Run this a few times to resolve dependency rot in installed packages.
# ghc-pkg-clean -f cabal/dev/packages*.conf also works.
function ghc-pkg-clean() {
    for p in `ghc-pkg check $* 2>&1  | grep problems | awk '{print $6}' | sed -e 's/:$//'`
    do
        echo unregistering $p; ghc-pkg $* unregister $p
    done
}

# remove all installed GHC/cabal packages, leaving ~/.cabal binaries and docs in place.
# When all else fails, use this to get out of dependency hell and start over.
function ghc-pkg-reset() {
    #read -p 'erasing all your user ghc and cabal packages - are you sure (y/n) ? ' ans
    test x$ans == xy && ( \
        echo 'erasing directories under ~/.ghc'; rm -rf `find ~/.ghc -maxdepth 1 -type d`; \
        echo 'erasing ~/.cabal/lib'; rm -rf ~/.cabal/lib; \
        # echo 'erasing ~/.cabal/packages'; rm -rf ~/.cabal/packages; \
        # echo 'erasing ~/.cabal/share'; rm -rf ~/.cabal/share; \
        )
}

function ghc-nuke() {
        echo 'erasing directories under ~/.ghc'; rm -rf `find ~/.ghc -maxdepth 1 -type d`;
        echo 'erasing ~/.cabal/lib'; rm -rf ~/.cabal/lib;
}

alias cabalupgrades="cabal list --installed  | egrep -iv '(synopsis|homepage|license)'"

######################################################################

alias fu=fileutil
alias fucp="fu cp -parallel_copy=32"

export CELL="vb"
export CH=/cns/$CELL-d/home/ericmc

function waitDo() {
  while inotifywait -qq -r -e modify $1; do $2; echo "DONE"; done
}

function waitBuild () {
  while inotifywait -qq -r -e modify $1; do blaze build -c opt $1/...; echo "DONE"; done
}

function waitTest () {
  while inotifywait -qq -r -e modify $1; do blaze test -c opt $1/...; echo "DONE"; done
}

function reshard () {
/google/data/ro/projects/mapreduce/mapreduce2 \
  --mapreduce_jobbase="reshard-$1" \
  --mapreduce_mapper="IdentityMapper" \
  --mapreduce_reducer="IdentityReducer" \
  --mapreduce_input_map="sstable:$2" \
  --mapreduce_output_format="sstable" \
  --mapreduce_output_map="$3"
}

export PATH=$PATH:/google/data/ro/teams/gas

function timer () {
  let "seconds = $1 * 60"
  echo "Timer set for $1 minutes ($seconds seconds) at:"
  date
  sleep $seconds;
  while true; do echo "Timer done!"; paplay /usr/share/sounds/gnome/default/alerts/bark.ogg; sleep 1; done
}

alias dblaunch=/usr/local/google/home/ericmc/t/2014_q2/trackG3/google3/blaze-bin/learning/dist_belief/driver/launcher

function cpTiffs () {
  cd $1
  find . -iname "*tif" -print0 | xargs -n1 -0 -P16 -I {} tiffcp -c none {} ../$2/{}
  cd ..
}

function cancelJobs() {
  borg --borg=$1 --user=ericmc lookupuser ericmc | xargs borg --borg=$1 --user=ericmc canceljob
}
