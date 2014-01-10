#!/bin/sh


# Install Ruby gems...
# I expect you to be in some sort of
# rbenv/virtualenv by this point !!
GEM_OPTS="--no-ri --no-rdoc"
gem install $GEM_OPTS sass -v 3.3.0.rc.2
gem install $GEM_OPTS compass -v 1.0.0.alpha.17
gem install $GEM_OPTS sassy-buttons -v 0.2.6


# Populate node_modules/
npm install


# This will perform `bower install`, and
# any additional initialization steps:
grunt install
