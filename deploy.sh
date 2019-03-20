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
IFS= read -r -p "Enter commit message: " commitmsg

# if commitmsg empty
if [ -z "$commitmsg" ]
then
    echo "Commit message is empty"
    commitmsg="Add files via upload"
fi

printf "\n"
git add .
git commit -m "$commitmsg"
git push

exit
