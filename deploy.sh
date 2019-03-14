#!/bin/bash

prjname="spemer.github.io"

echo "=============================="
echo ${prjname}
echo "=============================="

# install missing gems
bundle install

# build on a local server
bundle exec jekyll serve

# get commit message
printf "\n"
read -p "Enter commit message: " commitmsg

# commit
git add .
git commit -m ${commitmsg}
git push

exit
