# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }
# export JAVA_HOME=/home/fuwei/jdk1.8.0_101
export NEXUS_HOME=/home/fuwei/nexus-2.14.0-01
export JAVA_HOME=/home/fuwei/jdk1.7.0_75
export NEXUS_HOME_BIN=$NEXUS_HOME/bin
export JAVA_BIN=$JAVA_HOME/bin
export JAVA_LIB=$JAVA_HOME/lib
export CLASSPATH=.:$JAVA_LIB/tools.jar:$JAVA_LIB/dt.jar
export PATH=$JAVA_BIN:$PATH:$NEXUS_HOME_BIN

alias cd-="cd -"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias ......="cd ../../../../.."
alias ls="ls -a"
