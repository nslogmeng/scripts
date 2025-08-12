#!/bin/bash

GREEN_COLOR='\033[0;32m'
RESET_COLOR='\033[0m'

set -e

echo "${GREEN_COLOR}start initial macOS..${RESET_COLOR}"

# check homebrew
if ! command -v brew &> /dev/null; then
    echo "${GREEN_COLOR}install home brew...${RESET_COLOR}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "${GREEN_COLOR}homebrew already installed.${RESET_COLOR}"
fi

# check oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "${GREEN_COLOR}install oh-my-zsh...${RESET_COLOR}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "${GREEN_COLOR}oh-my-zsh already installed.${RESET_COLOR}"
fi

# clone scripts repos
echo "${GREEN_COLOR}fetch script repo...${RESET_COLOR}"
TMPDIR=$(mktemp -d) || exit 1
trap 'rm -rf "$TMPDIR"' EXIT
git clone https://github.com/nslogmeng/scripts.git $TMPDIR/scripts

echo "${GREEN_COLOR}set up home files...${RESET_COLOR}"
mv $TMPDIR/scripts/configs/.zshrc ~/.zshrc
mv $TMPDIR/scripts/configs/.gitconfig ~/.gitconfig
source ~/.zshrc

echo "${GREEN_COLOR}install oh-my-zsh plugins...${RESET_COLOR}"
# install oh-my-zsh custom plugins
# check autojump
if ! command -v autojump &> /dev/null; then
    echo "${GREEN_COLOR}install autojump...${RESET_COLOR}"
    brew install autojump
else
    echo "${GREEN_COLOR}autojump already installed.${RESET_COLOR}"
fi

# check zsh-autosuggestions
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    echo "${GREEN_COLOR}install zsh-autosuggestions...${RESET_COLOR}"
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
else
    echo "${GREEN_COLOR}zsh-autosuggestions already installed.${RESET_COLOR}"
fi

# check zsh-syntax-highlighting
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    echo "${GREEN_COLOR}install zsh-syntax-highlighting...${RESET_COLOR}"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
else
    echo "${GREEN_COLOR}zsh-syntax-highlighting already installed.${RESET_COLOR}"
fi

echo "${GREEN_COLOR}initial macOS done!${RESET_COLOR}"