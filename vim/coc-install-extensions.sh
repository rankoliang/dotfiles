#!/usr/bin/env bash

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

# Install extensions
mkdir -p ~/.config/coc/extensions
cd ~/.config/coc/extensions
if [ ! -f package.json ]
then
  echo '{"dependencies":{}}'> package.json
fi
# Change extension names to the extensions you need
npm install coc-snippets coc-solargraph coc-json coc-vimlsp coc-vimtex coc-html coc-css coc-prettier coc-eslint coc-tsserver coc-tailwindcss --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
npm install -g eslint

