module.exports = (grunt) ->
    
    # Project configuration.
    grunt.initConfig
        pkg: grunt.file.readJSON('package.json')
        env: process.env

        bower:
            install:
                options:
                    copy: false

        compass:
            compile:
                options:
                    config: 'config.rb'

        coffeelint:
            gruntfile: ['gruntfile.coffee']
            options:
                indentation:
                    level: 'warn'

        copy:
            statics:
                expand: true
                cwd: 'static/'
                src: '**'
                dest: 'htdocs/'

        chmod:
            dist_files:
                expand: true
                src: 'htdocs/**'
                filter: 'isFile'
                options:
                    mode: '644'
            dist_dirs:
                expand: true
                src: [ 'htdocs/**', 'htdocs/' ]
                filter: 'isDirectory'
                options:
                    mode: '755'

        watch:
            statics:
                files: ['static/**']
                tasks: ['copy', 'chmod']
            compass:
                files: ['**/*.scss', '**/*.sass']
                tasks: ['compass']

    # Load plugins that provide tasks.
    grunt.loadNpmTasks 'grunt-contrib-uglify'
    grunt.loadNpmTasks 'grunt-contrib-concat'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-jshint'
    grunt.loadNpmTasks 'grunt-contrib-nodeunit'
    grunt.loadNpmTasks 'grunt-contrib-compass'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-bower-task'
    #grunt.loadNpmTasks 'grunt-env'
    grunt.loadNpmTasks 'grunt-shell'
    grunt.loadNpmTasks 'grunt-chmod'
    grunt.loadNpmTasks 'grunt-sync-pkg'
    grunt.loadNpmTasks 'grunt-coffeelint'

    # TASKS YOU CALL:
    grunt.registerTask 'install', ['sync', 'bower']
    grunt.registerTask 'build', ['compass', 'copy', 'chmod']
    grunt.registerTask 'devbuild', ['coffeelint', 'build']
    grunt.registerTask 'dist', ['install', 'build']

    # DEFAULT TASK when you just run `grunt`:
    grunt.registerTask 'default', ['devbuild']
