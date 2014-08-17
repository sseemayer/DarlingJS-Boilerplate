gulp = require 'gulp'

coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
sourcemaps = require 'gulp-sourcemaps'
jade = require 'gulp-jade'
uglify = require 'gulp-uglify'
rename = require 'gulp-rename'
stylus = require 'gulp-stylus'
bowerFiles = require 'bower-files'
nib = require 'nib'

gulp.task 'default', ['build']

gulp.task 'build', ['build-source', 'bower']
gulp.task 'build-source', ['coffee', 'jade', 'stylus', 'assets']

gulp.task 'coffee', () ->
	gulp.src('./src/**/*.coffee', './src/index.coffee')
		.pipe(sourcemaps.init())
		.pipe(coffee(bare: false))
		.pipe(concat("index.js"))
		.pipe(uglify())
		.pipe(sourcemaps.write(includeContent: true, sourceRoot: '/src/'))
		.pipe(gulp.dest('./build/'))


gulp.task 'jade', () ->
	gulp.src('./src/**/*.jade')
		.pipe(jade(locals: {}))
		.pipe(gulp.dest('./build/'))


gulp.task 'stylus', () ->
	gulp.src('./src/**/*.styl')
		.pipe(stylus(compress: false, use: nib()))
		.pipe(gulp.dest('./build/'))


gulp.task 'bower', () ->
	gulp.src(bowerFiles().js)
		.pipe(sourcemaps.init())
		.pipe(concat("libs.js"))
		.pipe(uglify())
		.pipe(sourcemaps.write(includeContent: true, sourceRoot: '/libs/'))
		.pipe(gulp.dest('./build/'))

gulp.task 'assets', () ->
	gulp.src('./assets/**/*')
		.pipe(gulp.dest('./build/assets'))
