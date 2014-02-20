module.exports = (grunt) ->

  # configuration for Tasks and Targets
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    env: process.env

    connect:
      server:
        options:
          port: 10002
          base: 'htdocs'
          hostname: '*'
          livereload: 10012


    clean:
      build:
        src: ['app/_site', 'app/.sass-cache']
      dist:
        src: ['htdocs/*']
        options:
          force: true

    jekyll:
      options:
        src: 'app/site'
        config: 'config/jekyll/config.yml'
      build:
        options:
          dest: 'app/_site'
          drafts: true
          future: true
      lint:
        options:
          doctor: true

    copy:
      options:
        mode: '644'
        nonull: true
      build:
        files: [
          {
            cwd: 'app'
            src: ['images/**', 'fonts/*/web/*.woff', 'fonts/*/web/*.svg', 'fonts/*/web/*.eot', 'fonts/*/web/*.ttf', 'fonts/*/web/*.otf']
            dest: 'app/_site'
            expand: true
          },
        ]
      dist:
        files: [
          {
            cwd: 'app/_site'
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
      options:
        interrupt: false
        spawn: true
      statics:
        files: ['app/images/**', 'app/fonts/**']
        tasks: ['copy:dist', 'chmod:dist']
      compass:
        files: ['app/stylesheets/**']
        tasks: ['compass:compile']
      jekyll:
        files: ['app/site/**']
        tasks: ['jekyll:build']
      dist:
        files: ['app/_site/**']
        tasks: ['copy:dist', 'chmod:dist']
      livereload:
        files: ['htdocs/**/*', 'htdocs/*']
        options:
          livereload: 10012
 
    bower:
      install:
        options:
          bowerOptions:
            production: false

    sync:
      include: ['name', 'version', 'main', 'ignore', 'private']
      
    compass:
      compile:
        options:
          config: 'config/compass/config.rb'
          importPath: 'lib/sass'

    coffeelint:
      gruntfile: ['gruntfile.coffee']
      options:
        indentation:                { level: 'warn' }
        max_line_length:            { level: 'warn' }
        no_trailing_whitespace:     { level: 'warn' }

    cssmetrics:
      dev:
        src: ['app/_site/css/**.css']

    sloc:
      options:
        tolerant: true
      '.': ['*.coffee', '*.cs', '*.js', '*.py']
 

  # Load plugins that provide tasks.
  grunt.loadNpmTasks 'grunt-jekyll'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-bower-task'
  grunt.loadNpmTasks 'grunt-sync-pkg'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-chmod'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-css-metrics'
  grunt.loadNpmTasks 'grunt-sloc'
  #grunt.loadNpmTasks 'grunt-env'
  #grunt.loadNpmTasks 'grunt-contrib-uglify'
  #grunt.loadNpmTasks 'grunt-contrib-concat'
  #grunt.loadNpmTasks 'grunt-contrib-jshint'
  #grunt.loadNpmTasks 'grunt-contrib-nodeunit'
  #... commented-out ones are cantidates for not-usal->removal...


  # =================== #
  # TASKS YOU CAN CALL: #
  #
  grunt.registerTask 'install', ['bower:install']
  grunt.registerTask 'lint',    ['coffeelint', 'jekyll:lint', 'cssmetrics', 'sloc']
  grunt.registerTask 'build',   ['clean:build', 'jekyll:build', 'compass:compile', 'copy:build']
  grunt.registerTask 'dist',    ['clean:dist', 'copy:dist', 'chmod:dist']
  grunt.registerTask 'run',     ['connect', 'watch']
  grunt.registerTask 'all',     ['clean', 'sync', 'install', 'build', 'lint', 'dist', 'connect', 'watch']

  # ------------ . . . . . .
  # DEFAULT TASK when you just run `grunt`:
  # ---------------------------------------
  grunt.registerTask 'default', ['build', 'dist', 'run']
