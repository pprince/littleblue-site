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

        copy:
            statics:
                expand: true
                cwd: 'static/'
                src: '**'
                dest: 'htdocs/'

        shell:
            printenv:
                command: 'env'
                options:
                    stdout: true
                    stderr: true

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


    # Load plugins that provide tasks.
    grunt.loadNpmTasks 'grunt-contrib-uglify'
    grunt.loadNpmTasks 'grunt-contrib-concat'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-jshint'
    grunt.loadNpmTasks 'grunt-contrib-nodeunit'
    grunt.loadNpmTasks 'grunt-contrib-compass'
    grunt.loadNpmTasks 'grunt-bower-task'
    #grunt.loadNpmTasks 'grunt-env'
    grunt.loadNpmTasks 'grunt-shell'
    grunt.loadNpmTasks 'grunt-chmod'

    # Default task(s).
    grunt.registerTask 'dist', ['compass', 'copy', 'chmod']
    grunt.registerTask 'default', ['dist']
