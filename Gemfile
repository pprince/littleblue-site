# I get quite a few of my gems via Git (including some I could get from rubygems.)
# The rest come from:
source "https://rubygems.org"

# IIRC, at least one gem needs ruby >= 1.9, and one gem needs ruby <= 1.9,
# but I cannot remember which.  Regardless, 1.9.3 is the only version I test with.
#ruby "1.9"


# Jekyll
# ======

# Jekyll, the blog-aware static-site generator + plugins
# Version 1.4.3 has a bug on windows-only that will not be patched until next version.
# Version 2.0.0.alpha has problems running under grunt-jekyll
# So, we use version:
gem "jekyll", "=1.4.2"


# Jekyll Plugins
# --------------

# I have forked this one, and am bending it to suit my will.
gem "jekyll-pandoc-multiple-formats", :github => "pprince/jekyll-pandoc-multiple-formats", :branch => "ppdevel"


# Sass and Compass
# ================

# Sass 3.3 is almost out!  w00t!
gem "sass", :github => "nex3/sass", :tag => "3.3.0.rc.6"

# I have forked this one, only for a tiny change!  I need to contribute it upstream!
gem "compass", :github => "pprince/compass", :branch => "ppdevel" # 1.0.0.alpha.18


# Compass Extensions
# ------------------

# All of the following gems, in both the automatically imported and other lists,
# should be in the list of gems for compass to require.  This list is currently
# maintained in the Gruntfile (`gruntfile.coffee`), and this should be
# synchronized with that one.


# ### Auto-Imported ###

# The following extensions in this section are automatically imported when you
# `@import "base"`.  You can use their features in your modules, partials,
# etc., without `@import`-ing anything yourself.

# I wanted to use both sass-globbing and compass-import-once, but they
# interfere with each other; sass-globbing has been disabled.
# See: https://github.com/chriseppstein/compass/issues/1529
gem "compass-import-once", :require => "compass/import-once/activate"
#gem "sass-globbing"

# Breakpoint is already stable; great job guyz!
gem "breakpoint", "~> 2.4.1"

# SusyNext aka Susy 2.0 is almost out!  w00t!
gem "susy", :github => "ericam/susy", :tag => "2.0.0.rc.1"

# Apparently Toolkit 2.0 is also almost out.  It looks OK.
gem "toolkit", "=2.0.0.alpha.10"

# This one seems OK to include in global import because it's specifically
# non-conflicting.
gem "scut", "~> 0.9.1"

gem "harsh"
gem "sassy-buttons"


# ### Additionally Available ###

# EVEN MOAR COMPASS EXTENSIONS!
# Although we `require` them here, you will still need to `@import` (from your
# SASS and SCSS files) the things you want to use from Compass/Sass extensions.

# These are *not* automatically imported into your stylesheets.

# Also almost out, but I currently *reset* rather than normalize, so, meh.
gem "normalize-scss", "=3.0.0.alpha.2"

gem "compass-recipes"

gem "sassy_noise"
gem "bluesy-noise", :github => "pprince/bluesy-noise", :branch => "ppdevel"

# Other Gems
# ==========

# chunky_png is the pure-ruby PNG generation/manipulation library.
# oily_png is a ruby native C code extension that significantly
# speeds up chunky_png.
gem "chunky_png", "~> 1.3.0"
gem "oily_png", "~> 1.1.1"

# for git psdiff
gem "psd", "~> 2.1.0"
