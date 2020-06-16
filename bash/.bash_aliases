alias aptshowman="apt-mark showmanual | diff --unchanged-line-format="" ~/.dependencies/apt-base-manual.txt - | sort"
alias exportaptshowman="aptshowman > ~/.dependencies/ubuntu-dependencies.txt"