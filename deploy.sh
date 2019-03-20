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
git add .

# commit
if [ -z "$commitmsg" ]
then
    echo "commit message is empty"
    git commit -m "Add files via upload"
else
    git commit -m "$commitmsg"
fi

git push

exit
