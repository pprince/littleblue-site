#!/bin/sh

GEM_OPTS="--no-ri --no-rdoc"

gem install $GEM_OPTS sass -v 3.3.0.rc.2
gem install $GEM_OPTS compass -v 1.0.0.alpha.17
npm install
grunt bower
