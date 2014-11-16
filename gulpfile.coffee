gulp = require 'gulp'
gutil = require 'gulp-util'
gulpif = require 'gulp-if'
uglify = require 'gulp-uglify'
streamify = require 'gulp-streamify'
source = require 'vinyl-source-stream'
browserify = require 'browserify'
watchify = require 'watchify'
connect = require 'gulp-connect'
prettyHrtime = require 'pretty-hrtime'
nodemon = require 'gulp-nodemon'
autoprefixer = require 'gulp-autoprefixer'
sourcemaps = require 'gulp-sourcemaps'

env = process.env.NODE_ENV
dest = './dist'

gulp.task 'build', ['browserify']

gulp.task 'browserify', ->
  bundleMethod = if global.isWatching then watchify else browserify
  bundler = bundleMethod
    entries: ['./src/client.coffee']
    extensions: ['.coffee']

  start = ->
    gutil.log 'Starting', gutil.colors.green("'bundle'") + '...'
    process.hrtime()

  end = (startTime) ->
    taskTime = process.hrtime(startTime)
    prettyTime = prettyHrtime(taskTime)
    gutil.log 'Finished', gutil.colors.green("'bundle'"), 'after', gutil.colors.magenta(prettyTime)

  error = (err) ->
    console.log "error"
    gutil.log 'Error', gutil.colors.red(err)
    @emit 'end'

  bundle = ->
    startTime = start()

    return bundler
      .bundle(debug: true)
      .on('error', error)
      .pipe(source('client.js'))
      .pipe(gulpif(env is 'production', streamify(uglify())))
      .pipe(gulp.dest("#{dest}/scripts"))
      .on('end', end.bind(@, startTime))

  if global.isWatching
    bundler.on 'update', bundle

  return bundle()

gulp.task 'watch', ->
  global.isWatching = true
  gulp.watch('src/**/*.coffee', ['browserify'])

gulp.task 'serve', ->
  nodemon({
    script: './src/server.coffee',
    env: {
      NODE_ENV: 'development'
    }
  })
    .on('start', ['watch'])
    .on('restart', ->
      console.log "Restarting..."
    )

gulp.task 'default', ['build', 'serve']
