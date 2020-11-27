# dotfiles

## Introduction

This is currently a work in progress. If you are looking to copy these dotfiles, I strongly encourage you to only use these as inspiration only and customize to your own needs. Use at your own risk. I use currently use [GNU Stow](https://www.gnu.org/software/stow/) to create symlinks of the necessary files to my home folder. I also have a `local/.gitconfig.local` file that the [.gitconfig file](git/.gitconfig) will link to similar to this:

```
[user]
email=email@gmail.com
name=First Last
```

Note: to fix an issue with installing both bat and ripgrep on Ubuntu 20.04, reference [this](https://bugs.launchpad.net/ubuntu/+source/rust-bat/+bug/1868517/comments/32)
