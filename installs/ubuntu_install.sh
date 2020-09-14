apt install \
  tmux \
  batcat \
  fzf \
  zathura \
  keepassxc \
  steam \
  i3 \
  arandr \
  autorandr \
  light \
  pavucontrol \
  redshift \
  i3blocks
# Solves bug in ubuntu 20.04 where ripgrep has issues installing with batcat. 
# https://bugs.launchpad.net/ubuntu/+source/rust-bat/+bug/1868517/comments/32
apt download ripgrep
dpkg --force-overwrite -i ripgrep*.deb
usermod -a -G video $USER # permissions for light
curl https://pyenv.run | bash
