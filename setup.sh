#!/bin/bash

dotfiles_dir=$(dirname "$(realpath "$0")")

if [[ ! -x "$(command -v stow)" ]]; then
    echo "Please install stow first!"
    exit 1
fi

mv .zshrc ~
mkdir -p ~/.config/gtk-3.0
mkdir -p ~/.config/zsh
mkdir -p ~/.config/zsh-st
mkdir -p ~/Documents/tasks
mkdir -p ~/.config/lazygit
mkdir -p ~/.local/bin

ln -sf "$dotfiles_dir/.bashrc" ~/
ln -sf "$dotfiles_dir/.inputrc" ~/
ln -sf "$dotfiles_dir/.editrc" ~/
ln -sf "$dotfiles_dir/.clang-format" ~/

stow --target="$HOME" nvim/
stow --target="$HOME" zsh/
stow --target="$HOME" tmux/
stow --target="$HOME" git/
stow --target="$HOME" python/
stow --target="$HOME" lazygit/
stow --target="$HOME" taskwarrior/
stow --target="$HOME" alacritty/
stow --target="$HOME" kitty/
stow --target="$HOME" gtk/
stow --target="$HOME" tldr/
stow --target="$HOME" ranger/
stow --target="$HOME" lf/

ln -sf "$dotfiles_dir/python_scripts/unzip_cn.py" ~/.local/bin/unzip_cn
ln -sf "$dotfiles_dir/bash_scripts/cclangd" ~/.local/bin/cclangd

if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [[ -x "$(command -v brew)" ]]; then
    # Use USTC homebrew source
    # shellcheck disable=SC2164
    cd "$(brew --repo)"
    if [ "$(git remote get-url origin)" != "https://mirrors.ustc.edu.cn/brew.git" ]; then
        git remote set-url origin https://mirrors.ustc.edu.cn/brew.git
    fi
    # shellcheck disable=SC2164
    cd "$(brew --repo homebrew/core)"
    if [ "$(git remote get-url origin)" != "https://mirrors.ustc.edu.cn/linuxbrew-core.git" ]; then
        git remote set-url origin https://mirrors.ustc.edu.cn/linuxbrew-core.git
    fi
    # shellcheck disable=SC2164
    cd "$dotfiles_dir"

    declare -A brew_pack
    brew_pack[lazygit]=jesseduffield/lazygit/lazygit
    brew_pack[delta]=git-delta
    brew_pack[clang-format]=llvm
    brew_pack[clangd]=llvm
    brew_pack[cppcheck]=cppcheck
    brew_pack[shellcheck]=shellcheck
    brew_pack[rg]=ripgrep
    brew_pack[fd]=fd
    brew_pack[xdotool]=xdotool
    brew_pack[valgrind]=valgrind
    brew_pack[duf]=duf
    brew_pack[ncdu]=ncdu
    brew_pack[exa]=exa
    brew_pack[tldr]=tealdeer
    brew_pack[bat]=bat
    brew_pack[procs]=procs
    brew_pack[cpulimit]=cpulimit

    for exec_name in "${!brew_pack[@]}"; do
        if ! command -v $exec_name &> /dev/null; then
            brew install ${brew_pack[$exec_name]}
        fi
    done
elif [[ -x "$(command -v pacman)" ]]; then
    declare -A pacman_pack
    pacman_pack[lazygit]=lazygit
    pacman_pack[delta]=git-delta
    pacman_pack[clang-format]=clang
    pacman_pack[clangd]=clang
    pacman_pack[cppcheck]=cppcheck
    pacman_pack[shellcheck]=shellcheck
    pacman_pack[rg]=ripgrep
    pacman_pack[fd]=fd
    pacman_pack[xdotool]=xdotool
    pacman_pack[gdb]=gdb
    pacman_pack[valgrind]=valgrind
    pacman_pack[duf]=duf
    pacman_pack[gdu]=gdu
    pacman_pack[exa]=exa
    pacman_pack[tldr]=tealdeer
    pacman_pack[bat]=bat
    pacman_pack[procs]=procs
    pacman_pack[cpulimit]=cpulimit
    pacman_pack[tokei]=tokei
    pacman_pack[atool]=atool
    pacman_pack[xclip]=xclip
    pacman_pack[btm]=bottom
    pacman_pack[words]=words
    pacman_pack[lf]=lf

    for exec_name in "${!pacman_pack[@]}"; do
        if command -v $exec_name &> /dev/null; then
            unset pacman_pack[$exec_name]
        fi
    done
    if [[ ${#pacman_pack[@]} -ge 1 ]]; then
        sudo pacman -S ${pacman_pack[*]}
    fi
elif [[ -x "$(command -v apt)" ]]; then
    declare -A apt_pack
    apt_pack[lazygit]=lazygit
    apt_pack[delta]=git-delta
    apt_pack[clang-format]=clang
    apt_pack[clangd]=clang
    apt_pack[cppcheck]=cppcheck
    apt_pack[shellcheck]=shellcheck
    apt_pack[rg]=ripgrep
    apt_pack[fd]=fd-find
    apt_pack[xdotool]=xdotool
    apt_pack[gdb]=gdb
    apt_pack[valgrind]=valgrind
    apt_pack[duf]=duf
    apt_pack[gdu]=gdu
    apt_pack[exa]=exa
    apt_pack[tldr]=tealdeer
    apt_pack[bat]=bat
    apt_pack[procs]=procs
    apt_pack[cpulimit]=cpulimit
    apt_pack[tokei]=tokei
    apt_pack[atool]=atool
    apt_pack[xclip]=xclip
    apt_pack[btm]=bottom
    apt_pack[fzf]=fzf
    apt_pack[sql]=libsqlite3-dev
    apt_pack[tmux]=tmux
    apt_pack[python]=python3
    apt_pack[pip3]=pip3
    apt_pack[taskwarrior]=taskwarrior
    apt_pack[cargo]=cargo

    for exec_name in "${!apt_pack[@]}"; do
        if ! command -v $exec_name &> /dev/null; then
            sudo apt install ${apt_pack[$exec_name]}
        fi
    done
else
    echo "Please first install homebrew manually!"
fi

if [[ -x "$(command -v pip3)" ]]; then
    pip3 install pynvim
elif [[ -x "$(command -v pip)" ]]; then 
    pip install pynvim
fi
