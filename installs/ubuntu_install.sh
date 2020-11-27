git submodule update --init --recursive 
cd
sudo add-apt-repository ppa:kgilmer/speed-ricer
sudo apt install \
  nvim \
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
  light \
  pavucontrol \
  redshift \
  i3blocks \
  compton \
  rxvt-unicode \
  fd-find \
  most \
  cargo
# Solves bug in ubuntu 20.04 where ripgrep has issues installing with batcat. 
# https://bugs.launchpad.net/ubuntu/+source/rust-bat/+bug/1868517/comments/32
apt download ripgrep
sudo dpkg --force-overwrite -i ripgrep*.deb

cargo install exa

# UNIVERSAL CTAGS
# dependencies 
sudo apt install \
    gcc make \
    pkg-config autoconf automake \
    python3-docutils \
    libseccomp-dev \
    libjansson-dev \
    libyaml-dev \
    libxml2-dev

git clone git@github.com:universal-ctags/ctags.git
cd ctags
./autogen.sh
./configure
make
sudo make install

# change 
sudo update-alternatives --set x-terminal-emulator $(which urxvt)

# change shell to zsh
chsh $USER -s $(which zsh)

# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

curl https://pyenv.run | bash

