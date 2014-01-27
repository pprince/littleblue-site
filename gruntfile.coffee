module.exports = (grunt) ->

  # configuration for Tasks and Targets
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    env: process.env

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
        config: 'app/site/_config.yml'
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
            src: ['images/**', 'fonts/**']
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
      statics:
        files: ['app/images/**', 'app/fonts/**']
        tasks: ['copy:dist', 'chmod:dist']
      compass:
        files: ['app/sass/**']
        tasks: ['build', 'dist']
      jekyll:
        files: ['app/site/**']
        tasks: ['build', 'dist']
      livereload:
        files: ['htdocs/**']
        options:
          livereload: true
 
    bower:
      install:
        options:
          copy: false

    sync:
      include: ['name', 'version', 'main', 'ignore', 'private']
      
    compass:
      compile:
        options:
          config: 'app/config.rb'
          basePath: 'app/'

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
      '.': ['**.coffee', '**.cs', '**.js', '**.py']
 

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
  grunt.registerTask 'install', ['sync', 'bower:install']
  grunt.registerTask 'lint',    ['coffeelint', 'jekyll:lint', 'cssmetrics', 'sloc']
  grunt.registerTask 'build',   ['jekyll:build', 'compass:compile', 'copy:build']
  grunt.registerTask 'dist',    ['copy:dist', 'chmod:dist']
  grunt.registerTask 'all',     ['clean', 'install', 'build', 'lint', 'dist', 'watch']

  # ------------ . . . . . .
  # DEFAULT TASK when you just run `grunt`:
  # ---------------------------------------
  grunt.registerTask 'default', ['clean', 'build', 'dist']
