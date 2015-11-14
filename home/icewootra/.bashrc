#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s extglob globstar #failglob

alias ls='ls --color=auto --group-directories-first -X -h'
alias grep='grep --color=auto'
alias termdown='termdown -a -b -c 60 -f clb8x10 -t PWN3D'
alias pbcopy='xclip -selection clipboard -i'
alias pbpaste='xclip -selection clipboard -o'
alias json='json_reformat | pygmentize -l json'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
PS1='[\u@\h \w]\$ '

# Man pages coloring
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

export EDITOR=vim
export HISTCONTROL=ignoredups:ignorespace

source <(dircolors)

nchttp () {
	{ echo -ne "HTTP/1.0 200 OK\r\nContent-Type: text/plain\r\n\r\n"; cat; } | nc -l "$@"
}

nchttpl () {
	{
		echo -ne "HTTP/1.0 200 OK\r\nContent-Type: text/html\r\n\r\n"
		link="$(cat)"
		echo -n "<a href='$link'>$link</a>"
	} | nc -l "$@"
}

pbpipe() {
	pbcopy
	pbpaste
	#exec xclip -selection clipboard -o
}

export PATH="$PATH:$HOME/.cabal/bin"
