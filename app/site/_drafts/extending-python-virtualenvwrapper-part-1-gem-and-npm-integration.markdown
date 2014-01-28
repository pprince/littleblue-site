---
layout: post
title: "Extending Python Virtualenvwrapper, Part 1"
subtitle: "Ruby gem and Node.js npm Integration"
tags: python ruby gem nodejs npm shell sh sysadmin development
---

Introduction
============

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
culpa qui officia deserunt mollit anim id est laborum.

{% highlight python %}
def post_activate_source(args):
    return """
if [ -e "${VIRTUAL_ENV}/.gem" ]; then
    if [ -n "${GEM_HOME+x}" ]; then
        export _OLD_GEM_HOME="$GEM_HOME"
    fi
    export GEM_HOME=$VIRTUAL_ENV

    if [ -n "${GEM_PATH+x}" ]; then
        export _OLD_GEM_PATH="$GEM_PATH"
    fi
    export GEM_PATH=""
fi

"""
{% endhighlight %}

Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
culpa qui officia deserunt mollit anim id est laborum.

{% highlight sh %}
if [ -e "${VIRTUAL_ENV}/.gem" ]; then
    if [ -n "${_OLD_GEM_HOME+x}" ]; then
        GEM_HOME="$_OLD_GEM_HOME"
        export GEM_HOME
        unset _OLD_GEM_HOME
    else
        unset GEM_HOME
    fi

    if [ -n "${_OLD_GEM_PATH+x}" ]; then
        GEM_PATH="$_OLD_GEM_PATH"
        export GEM_PATH
        unset _OLD_GEM_PATH
    else
        unset GEM_PATH
    fi
fi
{% endhighlight %}

A Second Section
----------------

Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium
doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore
veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim
ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia
consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque
porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur,
adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et
dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis
nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex
ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea
voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem
eum fugiat quo voluptas nulla pariatur?
