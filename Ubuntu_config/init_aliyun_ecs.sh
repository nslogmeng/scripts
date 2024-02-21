#!/bin/bash

GREEN_COLOR='\033[0;32m'
RESET_COLOR='\033[0m'

echo "${GREEN_COLOR}start initial Aliyun ECS...${RESET_COLOR}"

echo "${GREEN_COLOR}current shell: $SHELL${RESET_COLOR}"
echo "${GREEN_COLOR}support shells:${RESET_COLOR}"
cat /etc/shells

echo "${GREEN_COLOR}install required packages...${RESET_COLOR}"
sudo apt-get update
sudo apt-get install -y --no-install-recommends git curl zsh autojump

# clone scripts repos
TMPDIR=$(mktemp -d) || exit 1
trap 'rm -rf "$TMPDIR"' EXIT
echo "${GREEN_COLOR}fetch script repo ${TMPDIR}...${RESET_COLOR}"
git clone https://github.com/nslogmeng/scripts.git $TMPDIR/scripts

# change to zsh
chsh -s /bin/zsh

echo "${GREEN_COLOR}install oh-my-zsh...${RESET_COLOR}"
# install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "${GREEN_COLOR}install oh-my-zsh plugins..."
# install oh-my-zsh custom plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

echo "${GREEN_COLOR}set up oh-my-zsh...${RESET_COLOR}"
mv $TMPDIR/scripts/Ubuntu_config/aliyun_ecs_zshrc ~/.zshrc

source ~/.zshrc

echo "${GREEN_COLOR} initial Aliyun ECS done!${RESET_COLOR}"