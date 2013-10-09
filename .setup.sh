#! /bin/bash

mkdir ~/bin

curl https://raw.github.com/n8han/conscript/master/setup.sh | sh

cs n8han/giter8

curl -s https://raw.github.com/paulp/sbt-extras/master/sbt > ~/bin/sbt && chmod 0755 ~/bin/sbt

curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

curl -Lo- https://bit.ly/janus-bootstrap | bash

apt-get install mr vcsh
