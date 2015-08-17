'user strict';

var gulp  = require('gulp');
var gutil = require('gutil');
var paths = gulp.paths;

gulp.task('html', function() {
  return gulp.src(paths.htmlSrc)
    .pipe(gulp.dest(paths.build));
});