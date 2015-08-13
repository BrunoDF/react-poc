'user strict';

var gulp  = require('gulp');
var gutil = require('gutil');
var cjsx  = require('gulp-cjsx');
var paths = gulp.paths;

gulp.task('cjsx', function() {
  gulp.src(paths.cjsxSrc)
    .pipe(cjsx({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest(paths.build));
});