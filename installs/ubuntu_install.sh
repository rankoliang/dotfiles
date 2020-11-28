git submodule update --init --recursive 
DOTFILES=$(pwd)
cd

sudo add-apt-repository ppa:kgilmer/speed-ricer -y
sudo add-apt-repository ppa:lazygit-team/release -y
sudo apt update
sudo apt upgrade
sudo apt install \
  arandr \
  autorandr \
  bat \
  cargo \
  compton \
  curl \
  feh \
  fd-find \
  fonts-inter \
  i3-gaps \
  i3blocks \
  lazygit \
  most \
  neovim \
  pavucontrol \
  redshift \
  rxvt-unicode \
  steam \
  stow \
  tmux \
  zathura \
  zsh \
  -y

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --no-bash --no-fish --no-update-rc --no-key-bindings --no-completion

# Solves bug in ubuntu 20.04 where ripgrep has issues installing with batcat. 
# https://bugs.launchpad.net/ubuntu/+source/rust-bat/+bug/1868517/comments/32
apt download ripgrep
sudo dpkg --force-overwrite -i ripgrep*.deb

cargo install exa

# change default terminal
sudo update-alternatives --set x-terminal-emulator $(which urxvt)

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

# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# install pyenv
curl https://pyenv.run | bash

mkdir -p ~/.config/nvim
mkdir ~/.vim
cd $DOTFILES && stow -vt ~ vim tmux git zsh fd-find i3 redshift urxvt general

rm -f ~/ripgrep_*.deb

# Install nvm and node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.0/install.sh | bash \
&& source $DOTFILES/nvm/nvm.sh \
&& nvm install 15.3.0 -v

# rbenv dependencies
sudo apt install gcc make libssl-dev libreadline-dev zlib1g-dev libsqlite3-dev -y \
&& git clone https://github.com/rbenv/rbenv.git ~/.rbenv \
&& source $DOTFILES/rbenv/rbenv.sh \
&& mkdir -p "$(rbenv root)"/plugins \
&& git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build \
&& rbenv install 2.7.2 -v && rbenv global 2.7.2 # install ruby

$DOTFILES/vim/coc-install-extensions.sh
nvim --headless +PlugInstall +qall

# Install MesloLGS font
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -O https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20Regular.ttf
curl -O https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20Bold.ttf
curl -O https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20Italic.ttf
curl -O https://raw.githubusercontent.com/romkatv/powerlevel10k-media/master/MesloLGS%20NF%20Bold%20Italic.ttf
fc-cache -f -v

sudo snap install discord spotify

source $DOTFILES/installs/screenlayout.sh $1

if [ ! $1 ]; then
  echo "Configure your monitor setup by running arandr and saving it as ~/.screenlayout/display.sh"
fi

echo "source ~/.dotfiles/rbenv/rbenv.sh" >> ~/.profile

feh --bg-fill $DOTFILES/assets/background.jpg

echo "changing your shell to zsh"
# change shell to zsh
chsh $USER -s $(which zsh)
