#!/bin/sh


# Install Ruby gems...
# I expect you to be in some sort of
# rbenv/virtualenv by this point !!
bundle install --no-cache

# Populate node_modules/
npm install

# This will perform `bower install`, and
# any additional initialization steps:
grunt install
