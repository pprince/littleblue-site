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

  * New Susy (2.0.0, currently beta)

    * Next-Generation CSS Responsive Grid Framework.

    * Clean, elegant, excellent.

  * Jekyll (1.4.3, stable)

    * Awesome blog-aware template preprocessor for static sites.

    * Also the recommended tool for users of Github Pages.

  * Integrated Package Management

    It's very simple for any developer to quickly replicate a self-contained environment with all the build dependencies baked in; this should get a team up-and-running quickly.

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
