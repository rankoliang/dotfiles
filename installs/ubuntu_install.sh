git submodule update --init --recursive 
DOTFILES=$(pwd)
cd

sudo add-apt-repository ppa:kgilmer/speed-ricer -y
sudo apt update
sudo apt upgrade
sudo apt install \
  neovim \
  stow \
  zsh \
  tmux \
  bat \
  fzf \
  zathura \
  steam \
  i3-gaps \
  arandr \
  autorandr \
  pavucontrol \
  redshift \
  i3blocks \
  compton \
  rxvt-unicode \
  fd-find \
  most \
  curl \
  -y
# Solves bug in ubuntu 20.04 where ripgrep has issues installing with batcat. 
# https://bugs.launchpad.net/ubuntu/+source/rust-bat/+bug/1868517/comments/32
apt download ripgrep
sudo dpkg --force-overwrite -i ripgrep*.deb

sudo apt install cargo -y && cargo install exa

# UNIVERSAL CTAGS
# dependencies 
sudo apt install \
    gcc make \
    pkg-config autoconf automake \
    python3-docutils \
    libseccomp-dev \
    libjansson-dev \
    libyaml-dev \
    libxml2-dev \
    -y \
&& git clone https://github.com/universal-ctags/ctags.git \
&& cd ctags \
&& ./autogen.sh \
&& ./configure \
&& make \
&& sudo make install

# change shell to zsh
chsh $USER -s $(which zsh)

# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# install pyenv
curl https://pyenv.run | bash

cd $DOTFILES && stow -vt ~ vim tmux git zsh fd-find i3 redshift urxvt

rm -f ~/ripgrep_*.deb

# Install nvm and node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.1/install.sh | bash && nvm install 15.3.0 -v

# rbenv dependencies
sudo apt install gcc make libssl-dev libreadline-dev zlib1g-dev libsqlite3-dev -y \
  && git clone https://github.com/rbenv/rbenv.git ~/.rbenv \
  && mkdir -p "$(rbenv root)"/plugins # install ruby-build \
  && git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build \
  && rbenv install 2.7.2 -v && rbenv global 2.7.2 # install ruby

# Install MesloLGS font
mkdir /tmp/p10k-fonts
cd /tmp/p10k-fonts
curl -O https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
curl -O https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
curl -O https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
curl -O https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
mv * ~/.local/share/fonts
fc-cache -f -v

# change default terminal
sudo update-alternatives --set x-terminal-emulator $(which urxvt)
