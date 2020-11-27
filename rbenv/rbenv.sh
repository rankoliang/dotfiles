# adds ruby to the path
if [ -d "$HOME/.rbenv/" ] ; then
  PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi