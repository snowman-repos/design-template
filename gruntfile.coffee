module.exports = (grunt) ->
	require('load-grunt-tasks')(grunt)
	require('time-grunt')(grunt)

	grunt.initConfig

		# Serve the site
		express:
			options:
				port: process.env.PORT || 9000
				cmd: 'coffee'
			dev:
				options:
					script: 'server.coffee'
			prod:
				options:
					script: 'server.coffee'
					node_env: 'production'

		# Open a browser window with the index page when grunt is run
		open:
			server:
				url: 'http://localhost:<%= express.options.port %>/styleguide'

		# Watch for changes to files and run tasks accordingly
		watch:
			less:
				files: ['./src/styleguide-template/public/*.less']
				tasks: ['kss']
			html:
				files: ['./src/styleguide-template/*.html']
				tasks: ['kss']
			coffee:
				files: ['./src/js/{,*/}*.{coffee,litcoffee,coffee.md}']
				tasks: ['newer:coffee:dist']
			stylus:
				files: ['./src/css/{,*/}*.styl']
				tasks: ['stylus', 'newer:kss']
			jade:
				files: ['./src/*.jade']
				tasks: ['newer:jade']
			livereload:
				files: [
					'./public/{,*//*}*.{html,jade}'
					'./public/css/{,*//*}*.css'
					'./public/js/{,*//*}*.js'
					'./public/{,*//*}*.{png,jpg,jpeg,gif,webp,svg,ttf,otf,woff}'
				]
				options:
					livereload: true
			express:
				files: ['server.coffee']
				tasks: ['express:dev']
				options:
					livereload: true
					nospawn: true
			gruntfile:
				files: ['gruntfile.coffee']

		coffee:
			dist:
				expand: true
				cwd: './src/js'
				src: '{,*/}*.coffee'
				dest: './public/js'
				ext: '.js'

		jade:
			dist:
				expand: true
				cwd: './src'
				src: '*.jade'
				dest: './public'
				ext: '.html'

		stylus:
			# options:
			# 	use: [
			# 		require('axis-css')
			# 	]
			dist:
				expand: true
				cwd: './src/css'
				src: 'main.styl'
				dest: './public/css'
				ext: '.css'

		imagemin:
			dist:
				expand: true
				cwd: './src/img'
				src: '{,*/}*.{png,jpg,jpeg,gif}'
				dest: './public/img'

		svgmin:
			dist:
				expand: true
				cwd: './src/img'
				src: '{,*/}*.svg'
				dest: './public/img'

		kss:
			files:
				src: './src/css/'
				dest: 'public/styleguide/'
			options:
				preprocessor: 'stylus'
				template: './src/styleguide-template/'

		copy:
			dist:
				expand: true
				dot: true
				cwd: './src/'
				dest: './public/'
				src: [
					'*.{ico,png,txt}'
					'.htaccess'
					'bower_components/**/*'
					'img/{,*/}*.{webp}'
					'fonts/*'
					'{,*/}*.css'
					'{,*/}*.js'
				]

		concurrent:
			server: [
				'coffee'
				'stylus'
				'jade'
				'kss'
				'copy'
			]
			dist: [
				'coffee'
				'stylus'
				'jade'
				'copy'
				'kss'
				'imagemin'
				'svgmin'
			]

	grunt.registerTask 'express-keepalive', 'Keep grunt running', ->
		this.async()

	grunt.registerTask 'serve', (target) ->
		if target is 'dist'
			grunt.task.run [
				'build'
				'express:prod'
				'kss'
				'open'
				'express-keepalive'
			]

		grunt.task.run [
			'concurrent:server'
			'express:dev'
			'open'
			'watch'
		]

	grunt.registerTask 'build', [
		'concurrent:dist'
		'copy'
	]

	grunt.registerTask 'default', [
		'serve'
	]