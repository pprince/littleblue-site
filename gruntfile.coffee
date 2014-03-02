module.exports = (grunt) ->

  # configuration for Tasks and Targets
  grunt.initConfig
    site:
      name: 'Twitchy'

    pkg: grunt.file.readJSON('package.json')
    env: process.env

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
          'name: <%= site.name %>\n' +
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
        sassDir:        'site/styles'
        imagesDir:      'site/images'
        fontsDir:       'site/fonts'
        javascriptsDir: 'site/javascript'
        httpPath:       '/'
        httpFontsPath:  '/fonts'
        importPath:     ['site/styles/modules', 'bower_components/garnish/src']
        relativeAssets: false
        bundleExec: true
        require: [
          "compass/import-once/activate",
          "sassy-strings",
          "toolkit",
          "compass-recipes",
          "compass-normalize",
          "breakpoint",
          "susy",
          "sassy-buttons",
          "bluesy-noise",
          "sassy_noise"
        ]
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
        files: ['site/styles/**/*.{sass,scss}']
        tasks: ['compass:dev', 'compass:prod']
      jekyll:
        files: ['site/jekyll/**']
        tasks: ['jekyll:build']
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

    cssmetrics:
      dev:
        src: ['BUILD/development/**/*.css']
      prod:
        src: ['BUILD/production/**/*.css']

    sloc:
      options:
        tolerant: true
      '.': ['*.coffee', '*.cs', '*.js', '*.py']


  # Load plugins that provide tasks.
  grunt.loadNpmTasks 'grunt-jekyll'
  grunt.loadNpmTasks 'grunt-coffeelint'
  #grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-chmod'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-css-metrics'
  grunt.loadNpmTasks 'grunt-sloc'
  grunt.loadNpmTasks 'grunt-bower-task'
  #grunt.loadNpmTasks 'grunt-env'
  #grunt.loadNpmTasks 'grunt-contrib-uglify'
  #grunt.loadNpmTasks 'grunt-contrib-concat'
  #grunt.loadNpmTasks 'grunt-contrib-jshint'
  #grunt.loadNpmTasks 'grunt-contrib-nodeunit'
  #... commented-out ones are cantidates for not-usal->removal...


  # =================== #
  # TASKS YOU CAN CALL: #
  #
  grunt.registerTask 'builddev',    ['jekyll:dev', 'compass:dev', 'copy:dev']
  grunt.registerTask 'buildprod',   ['jekyll:prod', 'compass:prod', 'copy:prod']
  grunt.registerTask 'build',       ['builddev', 'buildprod']
  grunt.registerTask 'dev',         ['clean:dev', 'builddev']
  grunt.registerTask 'prod',        ['clean:prod', 'buildprod']
  grunt.registerTask 'rundev',      ['connect:dev', 'watch:dev']
  grunt.registerTask 'runprod',     ['connect:prod', 'watch:prod']
  grunt.registerTask 'run',         ['connect', 'watch']
  grunt.registerTask 'dist',        ['clean:dist', 'copy:dist', 'chmod:dist']
  grunt.registerTask 'lint',        ['coffeelint', 'jekyll:lint', 'cssmetrics', 'sloc']
  #
  grunt.registerTask 'all',         ['clean', 'bower', 'lint', 'dev', 'prod', 'dist', 'run']
  #
  grunt.registerTask 'default', ['builddev', 'rundev']
