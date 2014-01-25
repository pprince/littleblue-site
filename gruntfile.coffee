module.exports = (grunt) ->

  # configuration for Tasks and Targets
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    env: process.env

    jekyll:
      options:
        src: 'app/jekyll'
      build:
        options:
          dest: 'app/build'
      lint:
        options:
          doctor: true

    copy:
      options:
        mode: '644'
        nonull: true
      distfiles:
        files: [
          {
            cwd: 'app/build'
            src: ['**']
            dest: 'htdocs'
            expand: true
          },
        ]
  
    chmod:
      options:
        mode: '755'
      distdirs:
        filter: 'isDirectory'
        src: ['htdocs/**', 'htdocs/']
        expand: true
    
    watch:
      statics:
        files: ['app/images/**', 'app/fonts/**']
        tasks: ['copy:distfiles', 'chmod:distdirs']
      compass:
        files: ['app/sass/**']
        tasks: ['build', 'dist']
      jekyll:
        files: ['app/jekyll/**']
        tasks: ['build', 'dist']
 
    bower:
      install:
        options:
          copy: false
    sync: {}
      
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
 

  # Load plugins that provide tasks.
  grunt.loadNpmTasks 'grunt-jekyll'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-bower-task'
  grunt.loadNpmTasks 'grunt-sync-pkg'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-chmod'
  #grunt.loadNpmTasks 'grunt-env'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  #grunt.loadNpmTasks 'grunt-contrib-uglify'
  #grunt.loadNpmTasks 'grunt-contrib-concat'
  #grunt.loadNpmTasks 'grunt-contrib-jshint'
  #grunt.loadNpmTasks 'grunt-contrib-nodeunit'
  #... commented-out ones are cantidates for not-usal->removal...


  # =================== #
  # TASKS YOU CAN CALL: #
  #
  grunt.registerTask 'install', ['sync', 'bower:install']
  grunt.registerTask 'lint',    ['coffeelint', 'jekyll:lint']
  grunt.registerTask 'build',   ['jekyll:build', 'compass:compile']
  grunt.registerTask 'dist',    ['copy:distfiles', 'chmod:distdirs']
  grunt.registerTask 'all',     ['install', 'build', 'lint', 'dist', 'watch']

  # ------------ . . . . . .
  # DEFAULT TASK when you just run `grunt`:
  # ---------------------------------------
  grunt.registerTask    'default', ['build', 'dist']
