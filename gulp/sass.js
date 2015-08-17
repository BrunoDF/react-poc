'user strict';

var gulp  = require('gulp');
var gutil = require('gutil');
var sass  = require('gulp-sass');
var paths = gulp.paths;

gulp.task('sass', function() {
  return gulp.src(paths.sassSrc)
    .pipe(sass().on('error', sass.logError))
    .pipe(gulp.dest(paths.build));
});