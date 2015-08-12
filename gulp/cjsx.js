'user strict';

var gulp  = require('gulp');
var gutil = require('gutil');
var cjsx  = require('gulp-cjsx');
var paths = gulp.paths;

gulp.task('cjsx', function() {
  gulp.src(paths.src)
    .pipe(cjsx({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest('dev/'));
});