'use strict';

var gulp = require('gulp');

gulp.paths = {
  serve : '.',
  src   : './components/*/scripts/**.cjsx',
  dev   : './dev',
  devFiles : './dev/**/*.js'
}

require('require-dir')('./gulp');

gulp.task('default', function() {
  gulp.start('cjsx');
});