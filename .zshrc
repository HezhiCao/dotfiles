# if [[ -f "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

sourced_home=1
export PATH="/usr/local/cuda/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="/opt/apps:$PATH"
export PATH="/usr/lib:$PATH"
export PATH="$PATH:$HOME/.meteor"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/share/nvim/site/pack/packer/start/asynctasks.vim/bin:$PATH"
export PATH="$HOME/perl5/bin:${PATH}"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/lib"

export http_proxy="http://127.0.0.1:7890"
export https_proxy="http://127.0.0.1:7890"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/inshallah/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/inshallah/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/inshallah/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/inshallah/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# <<< conda# disable sort when completing `git checkout`
# source ./.bash_profile
# source $ZDOTDIR/.zshrc

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
export EDITOR=nvim
export VISUAL=nvim
export GPG_TTY=$(tty)
setopt appendhistory
alias pip3=pip
alias python-config=python3-config
alias mendeley="mendeley --disable-gpu-sandbox"

export remote="root@101.37.253.81"
export server="chz@222.195.77.158"
export xzy="zhengyangxue@222.195.74.144"

PERL5LIB="/home/inshallah/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/inshallah/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/inshallah/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/inshallah/perl5"; export PERL_MM_OPT;
