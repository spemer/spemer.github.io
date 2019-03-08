#!/bin/bash

# install missing gems
bundle install

# build on a local server
bundle exec jekyll serve


# commit
git add .
git commit -m 'Deploy'
git push


exit
