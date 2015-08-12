'user strict';

var gulp        = require('gulp');
var gutil       = require('gutil');
var browserSync = require('browser-sync');
var url         = require('url');
var proxy       = require('proxy-middleware');
var paths       = gulp.paths;

gulp.task('serve', ['cjsx'], function() {
  var proxyOptions = url.parse('http://docker:8080');
  proxyOptions.route = '/api';

  browserSync.init({
    startPath: '/',
    server: {
      baseDir: paths.serve,
      middleware: [proxy(proxyOptions)]
    }
  });

  gulp.watch(paths.src, ['cjsx'])
  gulp.watch(paths.devFiles).on('change', browserSync.reload)
});
