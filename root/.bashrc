#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -X --color=auto'
PS1='[\u@\h \w]\$ '
