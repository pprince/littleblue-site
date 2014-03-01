pprince/littleblue-site
=======================

I have a website at http://littlebluetech.com/ and this is its Git repository.

This project serves primarily as a demonstration of a modern, roll-your-own,
static website, with build system and preprocessing.  Here I glue together
helpful components, rather than use something more pre-baked like Twitter's
Bootstrap.  I hope the results will be more DRY, and allow most of it to be
replicated between many projects without significant modification.

The static-ness is very handy in many instances, and the tool I use for that is
also the one recommended for use with GitHub Pages.  However, I do plan to
integrate Django or another Python web back-end framework at some point.


Features
--------

  * New Compass (1.0.0, currently alpha)

  * New SASS (3.3.0, currently release-cantidate)

    * Write SASS or SCSS instead of CSS

      * More capable than LESS!

      * Automatically generate codes for browser backward compatability and graceful degredation.

         * CSS3 prefixes, etc.

  * New *Susy* (2.0.0, currently release-cantidate)

    * Next-Generation CSS Grid Framework.

    * Responsive.

    * Clean, elegant, excellent.

  * Current *Jekyll* (1.4.3, stable)

    * Awesome blog-aware template preprocessor for static sites.

    * Also the recommended tool for users of Github Pages.

  * Package Management

    It's very simple for any developer to quickly replicate a self-contained
    environment with all the build dependencies baked in; this should get a
    team up-and-running quickly.

    * python: pip+virtualenv

      * virtualenvwrapper is strongly recommended, along with my virtualenvwrapper.gem and virtualenvwrapper.npm extensions

    * ruby-gem

      * provided by virtualenvwrapper.gem

    * node-npm

      * provided by virtualenvwrapper.npm

    * bower is also in the build, if you wish to use it for front-end assets.

  * Grunt

    * install

    * build

    * watch

      * livereload

  * HTML5, CSS3

    * Adheres to web standards.

      * Microformats!

      * Accessibility

  * Blends progressive enhancement and graceful degredation for best overall user experience.


Installation
------------

The following instructions and information should assist you in quickly
configuring a self-contained replica of my development environment.  Advanced
users may feel free to improvise.  I assume you will have forked this
repository; substitute the path to your own git repositories as appropriate
below.


### System Prerequisites ###

The following items must be installed before continuing.  I typically install
them system-wide, from distribution packages.

You can install even these dependencies into your homedir or another directory;
such configurations are left as an exercise.

- nodejs and npm
  - and npm
- python, 2.7
  - and pip
- ruby, 1.9.3
  - and gem
- pandoc

On Unix/Linux, you will need to be root to install the items above, system-wide.

You should not need to make use of the root user (or "su", or "sudo") beyond
this point; if you get permission-denied errors, double-check that you've
completed the previous steps correctly.

### Install Dev Tools to Home Directory ###

Distribution-provided versions of virtualenv and virtualenvwrapper are usually
out-of-date, so I generally pip-install the current version to my home
directory:

```
pip install --user virtualenv
pip install --user virtualenvwrapper
```

Also, I have managed to avoid RVM/rbenv and nvm, by having the Python-centric
virtualenvwrapper also handle my ruby and node global environments.  If you
want to do the same, you need only install my npm and gem plugins for
virtualwrapper:

```
pip install --user git+https://github.com/pprince/virtualenvwrapper.gem.git@ppdevel#egg=virtualenvwrapper.gem
pip install --user git+https://github.com/pprince/virtualenvwrapper.npm.git@ppdevel#egg=virtualenvwrapper.npm
```

Once you have done this, you can create a virtualenvwrapper project for your
working copy of the site:

```
mkproject littleblue-site
```

And, assuming you're using my extensions from above, you will want to activate
them for this project:

```
cdvirtualenv
touch .gem
touch .npm
deactivate
workon littleblue-site
```

### Verify Configuration ###

Before proceeding, it is imporant that you verify that the previous steps were
performed correctly.  Otherwise, your installations may not go where you
expect.  (The results can be confusing to sort out.)

Ensure that you have activated the project/environment with the `workon`
command.  I recommend you customize your shell prompt to keep you informed of
your current environment and git branch.

Then, use the `env` to ensure that GEM_HOME and NPM_CONFIG_PREFIX have been set
(and set to the same value) before continuing.


### Clone Your Repository ###

Substitute in the correct git URL for your fork of this repository.

Take note of the dot ('.') character after the URL below:

```
git clone git@github.com:pprince/littleblue-site.git .
```


### Install Dev Tools and Dependencies to the Virtualenv ###

We install the current version of bundler to our virtual environment root, and
then use it to install all of our Ruby development dependencies:

```
gem install bundler
bundle install
```

Although grunt-cli is really intended to be installed only once per system or
per user (such as, e.g., into your home directory like we installed
virtualenv), my virtualenvwrapper plugins assume you want an even greater
degree of independence and separation between environments.  So, for npm, you
have *both* a global and a local/project scope for each virtualenvwrapper
environment, and this installation will go into the virtual environment root:

```
npm install -g grunt-cli
```

Not actually currently necessary, but expected to be at some point:

```
pip install -r < requirements-dev.txt
```

### Install Per-Project/Local Dev Dependencies ###

This will populate the `./node_modules/` folder, installing the Grunt taskrunner et al.:

```
npm install
```

### Front-End Assets ###

Although I am currently managing front-end assets manually, Bower has been
integrated into the install/build process in case you would like to use it:

```
grunt install   # -->  Runs `bower install`.
```


LICENSE
=======

Copyright (c) 2013-2014, Paul Prince.  All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
