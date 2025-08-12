#!/bin/bash

GREEN_COLOR='\033[0;32m'
RESET_COLOR='\033[0m'

echo "${GREEN_COLOR}start initial macOS..${RESET_COLOR}"

echo "${GREEN_COLOR}install home brew...${RESET_COLOR}"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "${GREEN_COLOR}install oh-my-zsh...${RESET_COLOR}"
# install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

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
echo "${GREEN_COLOR}brew install autojump...${RESET_COLOR}"
brew install autojump
echo "${GREEN_COLOR}install zsh-autosuggestions...${RESET_COLOR}"
git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
echo "${GREEN_COLOR}install zsh-syntax-highlighting...${RESET_COLOR}"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

echo "${GREEN_COLOR}initial macOS done!${RESET_COLOR}"