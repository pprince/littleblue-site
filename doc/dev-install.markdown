Prerequisites:
--------------

These should be installed before continuing.  I typically install them system-wide.

You can install even these dependencies into your homedir or another directory;
such configurations are left as an exercise.

- nodejs
- python 2.7
    - pip
    - virtualenv
    - virtualenvwrapper
- ruby 1.9.3


Install stuff into your home directory:
---------------------------------------

```
pip install --user git+https://github.com/pprince/virtualenvwrapper.gem.git@ppdevel#egg=virtualenvwrapper.gem
pip install --user git+https://github.com/pprince/virtualenvwrapper.npm.git@ppdevel#egg=virtualenvwrapper.npm
```


Setup virtualenvwrapper project for littleblue-site:
----------------------------------------------------

```
mkproject littleblue-site
cdvirtualenv
touch .gem
touch .npm
deactivate
workon littleblue-site

env     # -->  Verify that GEM_HOME and NPM_CONFIG_PREFIX are set >>_before continuing_<<.
```


Clone the repository:
---------------------

```
git clone git@github.com:pprince/littleblue-site.git .
```


install things "globally" into the virtualenv root:
---------------------------------------------------

```
pip install -r < requirements-dev.txt
npm install -g grunt-cli
gem install bundler
bundle install
```


install things "locally" into the project dir:
----------------------------------------------

```
npm install
grunt install   # -->  Runs `bower install`.
```
