export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.plenv/bin:$PATH"
export PATH=/usr/local/opt/openssl/bin:$PATH
export PERL_CPANM_OPT="--local-lib=~/perl5"
export PATH=$HOME/bin:/usr/local/bin:$PATH 
export PATH=$HOME/perl5/bin:$PATH;
export PERL5LIB=$HOME/perl5/lib/perl5:$PERL5LIB;
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export ZSH=/home/n-osako/.oh-my-zsh
export PATH=$HOME/merp:$PATH
export PATH=$HOME/shdir/:$PATH
export PATH=$HOME/merp:$PATH
export PATH="$HOME/.exenv/bin:$PATH"
export WWW_HOME="google.co.jp"
export EDITOR=emacs

alias python="python3"
# export PATH="$PATH:$HOME/.composer/vendor/bin"
alias chrome="open /Applications/Google\ Chrome.app"
alias oj="g++ main.cpp && oj"
alias ls="ls -G"
alias g++="g++-9"
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
# alias netres='sudo service network-manager restart'
# alias hdmi-monitor='xrandr --output HDMI1 --auto --right-of eDP1'
# alias nautilus='nautilus --new-window'
source ~/.bash_profile
eval "$(exenv init -)"
ZSH_THEME="cobalt2"
# ZSH_THEME="gnzh"
plugins=(git ruby bundler rails )

# export LSCOLORS=cxfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'




autoload -Uz colors
# colors

#プロンプト

autoload -Uz vcs_info
setopt prompt_subst
# zstyle ':vcs_info:git:*' check-for-changes true
# zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
# zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
# zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
# zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
PROMPT="\$vcs_info_msg_0_'%(?.%{$fg[white]%}(_๑òωó)_ﾊﾞｧﾝ.%{$fg[white]%}ﾀﾞｧﾒ(乂д･｀))%{$fg[white]%}: %{$fg[blue]%}%~ %(?.%{${fg[green]}%}-> .%{${fg[red]}%}-> )%{${reset_color}%}"

autoload -U compinit
compinit
zstyle ':completion:*:default' menu select=2

autoload -U compinit
compinit
setopt auto_cd
setopt auto_pushd
setopt correct

#コマンドをtypeしたときに聞きなおしてくれる
#表示を詰めてくれる
setopt list_packed

bindkey -e

# 他のターミナルとヒストリーを共有
setopt share_history

# ヒストリーに重複を表示しない
setopt histignorealldups

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=5000

# 補完で大文字にもマッチ
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Ctrl+rでヒストリーのインクリメンタルサーチ、Ctrl+sで逆順
bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward

setopt auto_cd
function chpwd() { ls }


# mkdirとcdを同時実行
function mkcd() {
  if [[ -d $1 ]]; then
    echo "$1 already exists!"
    cd $1
  else
    mkdir -p $1 && cd $1
  fi
}

# create emacs env file
perl -wle \
   'do { print qq/(setenv "$_" "$ENV{$_}")/ if exists $ENV{$_} } for @ARGV' \
    PATH > ~/.emacs.d/shellenv.el

function google() {
    local str opt
    if [ $# != 0 ]; then
        for i in $*; do
            str="$str+$i"
        done
        str=`echo $str | sed 's/^\+//'`
        opt='search?num=50&hl=ja&lr=lang_ja'
        opt="${opt}&q=${str}"
    fi
    w3m http://www.google.co.jp/$opt
}

function md2pdf() {
    if [ $# = 1 ]; then
        fname_ext=$1
        fname="${fname_ext%.*}"
        pandoc $1 -o $fname.pdf -V mainfont=IPAPGothic -V fontsize=16pt --pdf-engine=lualatex
    else
        echo 'usage: md2pdf file.md'
    fi
}


function md2docx() {
    if [ $# = 1 ]; then
        fname_ext=$1
        fname="${fname_ext%.*}"
        pandoc $1 -t docx -o $fname.docx -V mainfont=IPAPGothic -V fontsize=16pt --toc --highlight-style=zenburn
    else
        echo 'usage: md2docx file.md'
    fi
}
# eval "$(rbenv init -)"
eval "$(plenv init -)"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

[[ -d ~/.rbenv  ]] && \
  export PATH=${HOME}/.rbenv/bin:${PATH} && \
  eval "$(rbenv init -)"


function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history


# function powerline_precmd() {
#     PS1="$(powerline-shell --shell zsh $?)"
# }

# function install_powerline_precmd() {
#   for s in "${precmd_functions[@]}"; do
#     if [ "$s" = "powerline_precmd" ]; then
#       return
#     fi
#   done
#   precmd_functions+=(powerline_precmd)
# }

# if [ "$TERM" != "linux" ]; then
#     install_powerline_precmd
# fi


# MacPorts Installer addition on 2014-09-25_at_18:39:26: adding an appropriate PATH variable for use with MacPorts.
# Finished adapting your PATH environment variable for use with MacPorts.









