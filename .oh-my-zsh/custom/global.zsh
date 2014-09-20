# Customize to your needs...
export PATH=/opt/ghc/7.8.3/bin:/opt/cabal/1.20/bin:~/.cabal/bin:/usr/bin:$PATH:~/bin/scalaIDE:~/bin/eclipse:/usr/local/Cellar/emacs/24.3/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:~/bin:~/bin/play:~/bin/activator:~/Library/Haskell/bin:/usr/local/MATLAB/R2013a/bin

export PATH=$PATH:$GOPATH/bin:$HOME/bin/google-cloud-sdk/bin:$HOME/bin/ImageJ:$HOME/bin/julia
export PATH=~/.cabal/bin:$PATH
export PATH=~/bin/blender:$PATH
export PATH=~/bin/stylish-haskell/.cabal-sandbox/bin:$PATH:~/bin/go_appengine

alias ezsh='e ~/.oh-my-zsh/custom/global.zsh'
alias vzsh='v ~/.oh-my-zsh/custom/global.zsh'
alias szsh='source ~/.zshrc'
alias rh="runhaskell"
alias xo='xdg-open'
alias e='emacs -nw'
alias vesh='vcsh ericsh'
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
# export JAVA_HOME=/usr/lib/jvm/java-7-oracle
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
# Kills all processes matching regex.
function ekill() { ps aux | grep -e "$@" | grep -v grep | awk '{print $2}' | xargs -i kill -9 {}; }
# unregister broken GHC packages. Run this a few times to resolve dependency rot in installed packages.
# ghc-pkg-clean -f cabal/dev/packages*.conf also works.
function ghc-pkg-clean() {
for p in `ghc-pkg check $* 2>&1 | grep problems | awk '{print $6}' | sed -e 's/:$//'`
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
alias cabalupgrades="cabal list --installed | egrep -iv '(synopsis|homepage|license)'"
######################################################################
alias fu=fileutil
alias fucp="fu cp -parallel_copy=32"
export CELL="ib"
export CH=/cns/$CELL-d/home/ericmc
export BH=/cns/$CELL-d/home/ericmc/2014_q3/brainData
function waitDo() {
while inotifywait -qq -r -e modify $1; do $2; echo "DONE"; done
}
function waitBuild () {
while inotifywait -qq -r -e modify $1; do time blaze build -c opt $1/... ; echo "DONE"; done
}
function waitBuildLocal () {
while inotifywait -qq -r -e modify $1; do time blaze build -c opt $1/... --noforge; echo "DONE"; done
}
function waitTest () {
while inotifywait -qq -r -e modify $1; do time blaze test -c opt $1/... --test_output=all; echo "DONE"; done
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
function eCancelJobs() {
borg --borg=$1 --user=ericmc lookupuser ericmc | grep $2 | xargs borg --borg=$1 --user=ericmc canceljob
}
function rme() {
find $1 -regex ".*#.*" -exec rm {} \;
}
function rmcl() {
g4d $1; g4 change --revert_files -d $1; cd -
}
# The next line updates PATH for the Google Cloud SDK.
# source '/usr/local/google/home/ericmc/google-cloud-sdk/path.bash.inc'
# The next line enables bash completion for gcloud.
# source '/usr/local/google/home/ericmc/google-cloud-sdk/completion.bash.inc'
PATH=$PATH:/usr/local/google/home/ericmc/google-cloud-sdk/bin 
