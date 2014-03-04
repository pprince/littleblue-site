module.exports = (grunt) ->

  grunt.initConfig

    pkg: grunt.file.readJSON('package.json')

    env: process.env

    config: grunt.file.readJSON('config.json')

    clean:
      dev:
        src: ['BUILD/development/']
      prod:
        src: ['BUILD/production/']
      build:
        src: ['BUILD/']
      compass:
        src: ['.sass-cache/']
      bower:
        src: ['bower_components/', 'lib/']
      dist:
        src: ['htdocs/*']
        options:
          force: true


    bower:
      install:
        options:
          cleanTargetDir: false
          verbose: true
          copy: false


    jekyll:
      options:
        bundleExec: true
        src: 'site/jekyll'
        raw: 'encoding: UTF-8\n' +
          'name: <%= config.site_name %>\n' +
          'gems:\n' +
          '    - jekyll-pandoc-multiple-formats\n' +
          'highlighter: none\n' +
          'markdown: pandoc\n' +
          'pandoc:\n' +
          '    skip: true\n' +
          '    output: "./tmp"\n' +
          '    flags: "--smart"\n' +
          '    site_flags: "--toc"\n' +
          '    outputs:\n' +
          '        pdf:\n' +
          '        epub:\n' +
          'permalink: pretty'
      dev:
        options:
          dest: 'BUILD/development'
          drafts: true
          future: true
      prod:
        options:
          dest: 'BUILD/production'
          drafts: false
          future: false
      lint:
        options:
          doctor: true


    compass:
      options:
        sassDir:        'site/stylesheets'
        imagesDir:      'site/images'
        fontsDir:       'site/fonts'
        javascriptsDir: 'site/javascript'
        httpPath:       '/'
        httpFontsPath:  '/fonts'
        importPath: [
          'site/stylesheets/modules',
          'bower_components/garnish/src'
        ]
        relativeAssets: false
        bundleExec: true
        require: [
          "compass/import-once/activate"
          #sass-globbing  ## currently broken: compass/import-once and sass-globbing break each other.
          "normalize-scss"
          "breakpoint"
          "susy"
          "toolkit"
          "compass-recipes"
          "sassy-buttons"
          "sassy_noise"
          "bluesy-noise"
          "harsh"
        ] ## Note: This list should be sync'd with the list of gems to install (i.e., the Gemfile.)
      dev:
        options:
          environment: 'development'
          cssDir: 'BUILD/development/css'
          outputStyle: 'nested'
      prod:
        options:
          environment: 'production'
          cssDir: 'BUILD/production/css'
          outputStyle: 'compressed'
      compile: {}


    prettify:
      options:
        condense: true
        indent: 4
        indent_inner_html: false
        indent_scripts: 'normal'
      dev:
        expand: true
        cwd: 'BUILD/development'
        src: ['**/*.html']
        dest: 'BUILD/development'
      prod:
        expand: true
        cwd: 'BUILD/production'
        src: ['**/*.html']
        dest: 'BUILD/production'


    copy:
      options:
        mode: '644'
        nonull: true
      dev:
        files: [
          {
            cwd: 'site'
            src: ['images/**', 'fonts/*/web/*.woff', 'fonts/*/web/*.svg', 'fonts/*/web/*.eot', 'fonts/*/web/*.ttf', 'fonts/*/web/*.otf']
            dest: 'BUILD/development'
            expand: true
          },
        ]
      prod:
        files: [
          {
            cwd: 'site'
            src: ['images/**', 'fonts/*/web/*.woff', 'fonts/*/web/*.svg', 'fonts/*/web/*.eot', 'fonts/*/web/*.ttf', 'fonts/*/web/*.otf']
            dest: 'BUILD/production'
            expand: true
          },
        ]
      dist:
        files: [
          {
            cwd: 'BUILD/production'
            src: ['**']
            dest: 'htdocs'
            expand: true
          },
        ]
  
    chmod:
      options:
        mode: '755'
      dist:
        filter: 'isDirectory'
        src: ['htdocs/**', 'htdocs/']
        expand: true
    
    watch:
      options: {}
      compass:
        files: ['site/stylesheets/**/*.{sass,scss}']
        tasks: ['compass:dev', 'compass:prod']
      jekyll:
        files: ['site/jekyll/**']
        tasks: ['jekyll:dev', 'jekyll:prod']
      prettify_dev:
        files: ['BUILD/**/development/**/*.html']
        tasks: ['prettify:dev']
      prettify_prod:
        files: ['BUILD/**/production/**/*.html']
        tasks: ['prettify:prod']
      lr_dev:
        files: ['BUILD/development/**']
        options:
          livereload: 2020
      lr_prod:
        files: ['BUILD/production/**']
        options:
          livereload: 3030
    connect:
      dev:
        options:
          port: 2000
          base: 'BUILD/development'
          hostname: '*'
          livereload: 2020
       prod:
        options:
          port: 3000
          base: 'BUILD/production'
          hostname: '*'
          livereload: 3030
      

    coffeelint:
      gruntfile: ['gruntfile.coffee']
      options:
        indentation:                { level: 'warn' }
        max_line_length:            { level: 'warn' }
        no_trailing_whitespace:     { level: 'warn' }

    jshint:
      options:
        reporter: require('jshint-stylish')
      dev: ['site/javascripts/**/*.js']

    cssmetrics:
      dev:
        src: ['BUILD/development/**/*.css']
      prod:
        src: ['BUILD/production/**/*.css']


  # Load plugins that provide tasks.
  require('load-grunt-tasks')(grunt)
  
  #
  #require('load-grunt-tasks')(grunt)

  #
  require('time-grunt')(grunt)


  # Tasks You Can Call
  # ==================

  # Build
  # ---------------------
  grunt.registerTask 'build:dev',   ['jekyll:dev', 'compass:dev', 'copy:dev', 'prettify:dev']
  grunt.registerTask 'build:prod',  ['jekyll:prod', 'compass:prod', 'copy:prod', 'prettify:prod']
  grunt.registerTask 'build',       ['build:dev', 'build:prod']

  # Test
  # -------------------------------------------
  grunt.registerTask 'run:dev',      ['connect:dev', 'watch']
  grunt.registerTask 'run:prod',     ['connect:prod', 'watch']
  grunt.registerTask 'run',          ['connect', 'watch']

  # Deploy: Copy Production Build to htdocs/
  # ----------------------------------------
  grunt.registerTask 'dist',        ['clean:dist', 'copy:dist', 'chmod:dist']

  # Automatically Complain About (and Analyse) Your Code:
  # -----------------------------------------------------
  grunt.registerTask 'lint',        ['coffeelint', 'jekyll:lint', 'cssmetrics']
 
  # Task 'all'; mainly for debugging this Gruntfile
  # -----------------------------------------------
  grunt.registerTask 'all',         ['clean', 'bower', 'lint', 'dev', 'prod', 'dist', 'run']

  # Default Task, Or:  What Happens When You Just Run `grunt`?
  # ----------------------------------------------------------
  grunt.registerTask 'default',     ['build:dev', 'run:dev']
