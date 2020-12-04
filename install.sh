#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install curl tilix synaptic yakuake openssh-server chromium-browser spyder3 git vim htop most zsh python3-pip fonts-powerline git-extras unrar zip unzip p7zip-full p7zip-rar rar openjdk-11-jdk steam

sudo pip3 install tldr setuptools

sudo snap install spotify
sudo snap install code --classic

sudo systemctl enable ssh
sudo systemctl start ssh

sudo dd if=/dev/zero of=/swapfile bs=100M count=20
sudo mkswap /swapfile && chmod 600 /swapfile && swapon /swapfile

sudo su - root -c 'cat <<EOT >>/etc/fstab
tmpfs /tmp tmpfs defaults,noatime,mode=1777 0 0
tmpfs /var/tmp tmpfs defaults,noatime,mode=1777 0 0
tmpfs /var/log tmpfs defaults,noatime,mode=0755 0 0
/swapfile    none    swap  sw     0    0
EOT'

sudo su - root -c 'curl https://gist.githubusercontent.com/Esl1h/65c0d67780ee6212ebce00efe76d6007/raw/6fbfc331b9a6be1522d3df7f6ea190659893915b/sysctl.conf >>/etc/sysctl.conf'

sudo sysctl -p

sudo su - root -c 'curl https://gist.githubusercontent.com/Esl1h/29beb6d8af2b16d5438b66180705ad95/raw/7db839086cc92e1f9d073c13adb67026fc75989a/ssh_config >/etc/ssh/ssh_config'

sudo apt autoremove && sudo apt autoclean && sudo apt clean

# https://www.esli-nux.com/2017/04/ssd-no-linux.html
# https://www.esli-nux.com/2014/08/usar-arquivo-como-memoria-swap.html
# Config files on gists in https://gist.github.com/Esl1h (ssh_config and sysctl.conf)

echo "\n\n\n\n"
echo ################################
read -n 1 -s -r -p "Now, will be install oh-my-zsh - When finished, press CTRL+D to continue , ok? Press any key to continue"

# Install oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# install fonts do ZSH and powerlevel theme
mkdir ~/.fonts
wget -c https://github.com/ryanoasis/nerd-fonts/releases/download/v1.2.0/Hack.zip -P ~/.fonts/
cd ~/.fonts/ && unzip Hack.zip

# install some plugins to zsh - syntax high lighting and command auto suggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# powerlevel9k zsh theme
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# install and config zshrc file:
rm ~/.zshrc
wget -c https://raw.githubusercontent.com/Esl1h/my-terminal/master/zshrc -O ~/.zshrc
echo export ZSH=\""$HOME"/.oh-my-zsh\" >>~/.zshrc
echo "source \$ZSH/oh-my-zsh.sh" >>~/.zshrc
echo 'export MANPAGER="/usr/bin/most -s" ' >>~/.zshrc
