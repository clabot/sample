'use strict'
module.exports = (grunt) ->

  grunt.initConfig
    coffee:
      src:
        expand: yes
        cwd: 'src'
        src: ['**/*.coffee']
        dest: 'src'
        ext: '.js'

  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.registerTask 'default', ['coffee']
