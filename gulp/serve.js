'user strict';

var gulp        = require('gulp');
var gutil       = require('gutil');
var browserSync = require('browser-sync');
var url         = require('url');
var proxy       = require('proxy-middleware');
var paths       = gulp.paths;

gulp.task('serve', ['cjsx', 'html'], function() {
  var proxyOptions = url.parse('http://docker:8080');
  proxyOptions.route = '/api';

  var routes = {
    '/bower_components' : 'bower_components'
  }

  browserSync.init({
    startPath: '/',
    server: {
      baseDir    : paths.serve,
      middleware : [proxy(proxyOptions)]//,
      // routes     : routes
    }
  });

  gulp.watch(paths.cjsxSrc, ['cjsx'])
  gulp.watch(paths.htmlSrc, ['html'])
  gulp.watch(paths.buildFiles).on('change', browserSync.reload)
});
