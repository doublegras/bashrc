# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;33m'     # begin blink
export LESS_TERMCAP_so=$'\e[01;44;37m' # begin reverse video
export LESS_TERMCAP_us=$'\e[01;37m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
export GROFF_NO_SGR=1                  # for konsole and gnome-terminal
export MANPAGER='less -s -M +Gg'

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

hex()
{
	echo $((0x$1))
}

git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

#kube_ctx() {
#  kubectl config current-context
#}
#
#kube_ns() {
#  kubectl config get-contexts | grep "*" | awk '{ print $5 }'
#}

if [ "$color_prompt" = yes ]; then
   # PS1=$prompt_color'\n\u·\H \e[0:37m[\w] \e[0;49;33m$(ip route get 1.1.1.1 | awk -F"src " '"'"'NR == 1{ split($2, a," ");print a[1]}'"'"')  \e[35m$(git_branch)\n\e[2;49;37m❯ \e[0:37m'
   #PS1="${prompt_color}\n\u·\H \[\e[0:37m\][\w] \[\e[0;49;33m\]$(ip route get 1.1.1.1 | awk -F'src ' 'NR == 1{ split($2, a," ");print a[1]}'\[\e[35m\]$(git_branch)\n\[\e[2;49;37m\]❯ \[\e[0:37m\]"
  PS1='\[\033[;94m\n\u·\H \[\e[0:37m\][\w] \[\e[0;49;33m\]$(ip route get 1.1.1.1 | awk -F"src " '\''NR == 1{ split($2, a," ");print a[1]}'\'')  \[\e[35m\]$(git_branch) \[\e[2;49;37m\]\n❯ \[\e[0:37m\]'

else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#export dr='--dry-run=client -o yaml'

alias ll='ls -lh'
alias la='ls -lha'
alias l='ls -CF'
alias myip='curl ifconfig.me'
alias lg='xrandr --current --verbose | grep Brightness | cut -d ":" -f 2'
alias dockrm='docker container prune --force'
alias postman='/snap/bin/postman'
alias dockernone='docker rmi $(docker images -f dangling=true -q)'
alias gw='gcc -Wall -Wextra -Werror'
alias ccw='cc -Wall -Wextra -Werror'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias copy='xclip -sel clip'
#alias k3s='export KUBECONFIG=/home/doublegras/development/dev-ops/kubernetes/k3s-cluster/kubeconfig'
#alias k8spi='export KUBECONFIG=/home/doublegras/development/dev-ops/pi-cluster/admin.conf'
#alias k8s='export KUBECONFIG=/home/doublegras/infra/kube-config.yaml'
#alias mini='export KUBECONFIG=/home/doublegras/.kube/config'
#alias kube='kubectl'
#alias ks='kubectl'
#alias k='kubectl'
alias gitlab='docker run --detach \
  --hostname gitlab.example.com \
  --publish 443:443 --publish 80:80 --publish 22:22 \
  --name gitlab \
  --restart always \
  --volume $GITLAB_HOME/config:/etc/gitlab \
  --volume $GITLAB_HOME/logs:/var/log/gitlab \
  --volume $GITLAB_HOME/data:/var/opt/gitlab \
  --shm-size 256m \
  gitlab/gitlab-ee:latest'
alias speed='wget --output-document=/dev/null http://speedtest.wdc01.softlayer.com/downloads/test500.zip'
alias gpt='python3 /home/doublegras/development/python/gpt/main.py'
alias kali='docker run -it --network host kali-full bash'
alias down='sudo shutdown now'
#alias ka='kubectl apply -f'
#alias kceph='kubectl -n rook-ceph exec -it deploy/rook-ceph-tools -- bash'
#alias rmcephimg="while read csi; do k exec -n rook-ceph deployments/rook-ceph-tools -- rbd rm \$csi -p replicapool; done < <(while read i; do k get pv -o yaml \$i | grep "imageName:" | awk '{print \$2}'; done < <(k get pv | grep "Released" | awk '{print \$1}'))"
#alias rmvol="while read i; do k delete pv \$i; done < <(k get pv | grep -i released | awk '{print \$1}')"
alias gns3="source /home/doublegras/gns3env/bin/activate && gns3&"
alias ip="ip --color=auto"
alias pi="/home/doublegras/development/c/pi/pi"
alias scale="xrandr --output DP-3 --scale 2x2"
alias py='python3'
alias mini='~/mini-moulinette/mini-moul.sh'
alias nv='nvim'
alias vim='nvim'
alias paco="$HOME"/francinette/tester.sh
alias rp='/opt/rp/src/build/rp-lin --colors'
alias val='valgrind --leak-check=full --show-leak-kinds=all -s -q'

#complete -o default -F __start_kubectl k
#complete -C '/usr/local/bin/aws_completer' aws
#source <(helm completion bash)

#k8s

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#export PATH=$PATH:/usr/local/go/bin
#source <(kubectl completion bash)


# Created by `pipx` on 2024-03-27 18:29:21
export PATH="$PATH:/home/doublegras/.local/bin"

export PATH="$PATH:/opt/nvim-linux64/bin"
