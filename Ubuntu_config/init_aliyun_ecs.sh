#!/bin/bash

echo "start initial Aliyun ECS..."

echo "current shell: $SHELL"
echo "support shells:"
cat /etc/shells

echo "install required packages..."
sudo apt-get update
sudo apt-get install -y --no-install-recommends git curl zsh autojump

# clone scripts repos
TMPDIR=$(mktemp -d) || exit 1
trap 'rm -rf "$TMPDIR"' EXIT
git clone https://github.com/nslogmeng/Scripts.git TMPDIR

# change to zsh
chsh -s /bin/zsh

echo "install oh-my-zsh..."
# install oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install oh-my-zsh custom plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

mv $TMPDIR/Ubuntu_config/aliyun_ecs_zshrc ~/.zshrc

source ~/.zshrc