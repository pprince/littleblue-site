module.exports = (grunt) ->

  # configuration for Tasks and Targets
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    env: process.env
  
    coffeelint:
      gruntfile: ['gruntfile.coffee']
      options:
        indentation:        { level: 'warn' }
        max_line_length:    { level: 'warn' }

    sync: {}
    bower:
      install:
        options:
          copy: false
      
    compass:
      compile:
        options:
          config: 'config.rb'
  
    copy:
      options:
        mode: '644'
      distfiles:
        files: [
          {
            cwd: 'app'
            src: ['css/**', 'images/**', 'fonts/**']
            dest: 'dist/htdocs'
            expand: true
          }, {
            cwd: 'app/doc-root'
            src: ['**']
            dest: 'dist/htdocs'
            expand: true
          },
        ]
  
    chmod:
      options:
        mode: '755'
      distdirs:
        filter: 'isDirectory'
        src: [ 'dist/htdocs/**', 'dist/htdocs/', 'dist/']
        expand: true
    
    watch:
      statics:
        files: ['app/css/**', 'app/images/**', 'app/fonts/**', 'app/docroot/**']
        tasks: ['copy:distfiles', 'chmod:distdirs']
      compass:
        files: ['app/sass/**.scss', 'app/sass/**.sass']
        tasks: ['compass:compile']
  

  # Load plugins that provide tasks.
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


  # TASKS YOU CAN CALL:
  grunt.registerTask 'lint',      ['coffeelint']
  grunt.registerTask 'install',   ['sync', 'bower:install']
  grunt.registerTask 'build',     ['install', 'compass:compile']
  grunt.registerTask 'dist',      ['build', 'copy:distfiles','chmod:distdirs']

  # DEFAULT TASK when you just run `grunt`:
  grunt.registerTask 'default',   ['lint', 'dist']

  # NOTE that, as currently configured, calling `grunt` followed by `grunt
  # watch` will cause you to have exercised every configured target; this is
  # useful for debugging the gruntfile, and should be preserved.

