'user strict';

var gulp  = require('gulp');
var gutil = require('gutil');
var paths = gulp.paths;

gulp.task('html', function() {
  gulp.src(paths.htmlSrc)
    .pipe(gulp.dest(paths.build));
});