# dotfiles

## Introduction

This is currently a work in progress. If you are looking to copy these dotfiles, I strongly encourage you to only use these as inspiration only and customize to your own needs. Use at your own risk. I use currently use [GNU Stow](https://www.gnu.org/software/stow/) to create symlinks of the necessary files to my home folder.

## Installing

**WARNING THIS SCRIPT WILL MAKE MAJOR MODIFICATIONS TO YOUR SYSTEM**

From a clean install, download git using

```
sudo apt install git
```

Then setup your git credentials by making a file at ~/.dotfiles/local/.gitconfig.local

```
[user]
  email=email@gmail.com
  name=First Last
```

Clone this repository with
```
git clone git@github.com:rankoliang/dotfiles.git ~/.dotfiles
```

Set up an ssh key starting from https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/checking-for-existing-ssh-keys

Navigate folder and start the install script by running

```
cd ~/.dotfiles
./installs/ubuntu_install.sh <xrandr profile (optional)>
```

The xrandr profiles will be in screenlayouts.
You will need to create your own. You can use arandr to generate them.

## Grub

My preferred additional grub settings in /etc/default/grub

```
GRUB_DEFAULT=saved
GRUB_SAVEDDEFAULT=true
```

Run `sudo update-grub` after the file has been edited.

## Issues

Note: to fix an issue with installing both bat and ripgrep on Ubuntu 20.04, reference [this](https://bugs.launchpad.net/ubuntu/+source/rust-bat/+bug/1868517/comments/32)

### x570 Tomahawk Motherboard
For ethernet issues on this motherboard, download the linux driver here:
https://www.realtek.com/en/component/zoo/category/network-interface-controllers-10-100-1000m-gigabit-ethernet-pci-express-software

Then, run
```
tar vjxf path_to_driver
```

and follow the directions in the readme.
