var gulp = require('gulp');
var watch = require('gulp-watch');

var coffee = require('gulp-coffee');
var sourcemaps = require('gulp-sourcemaps');
var less = require('gulp-less');
var path = require('path');
var gutil = require('gulp-util');
var plumber = require('gulp-plumber');
var clean = require('gulp-clean');

var uglify = require('gulp-uglify');
var rename = require('gulp-rename');

var webpack = require('gulp-webpack');

var sequence = require('gulp-sequence');

var htmlmin = require('gulp-htmlmin');

gulp.task('html', function () {
  return gulp.src('src/**/*.html')
    .pipe(htmlmin({collapseWhitespace: true}))
    .pipe(gulp.dest('./dist'))
});

gulp.task('coffee', function () {
  gulp.src('./src/**/*.coffee')
    .pipe(plumber())
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest('./dist'))
});

gulp.task('less', function () {
  gulp.src('./src/**/*.less')
    .pipe(plumber())
    .pipe(less({paths: [path.join(__dirname, 'less', 'includes')]})).on('error', gutil.log)
    .pipe(gulp.dest('./dist'));
});

gulp.task('webpack', function () {
  gulp.src('./src/app.coffee')
    .pipe(plumber())
    .pipe(webpack({
      //watch: true,
      output: {
        filename: 'all.js',
        libraryTarget: 'umd'
      },
      module: {
        loaders: [
          //{test: /\.css/, loader: 'style!css'},
          //{test: /\.js/, loader: 'script'},
          {test: /\.less/, loader: 'style!css!less'},
          {test: /\.coffee/, loader: 'coffee'},
          //{test: /\.vue$/, loader: 'vue'},
          {test: /\.html$/, loader: "html"},
          {test: /\.(woff|woff2)$/, loader: "url?limit=10000&minetype=application/font-woff"},
          {test: /\.(eot|svg|ttf)$/, loader: "file"}
        ]
      },
      resolve: {
        modulesDirectories: ['node_modules'],
        extensions: ['', /*'css',*/'.less', '.js', '.coffee']
      },
      plugins: [new webpack.webpack.ResolverPlugin(new webpack.webpack.ResolverPlugin.DirectoryDescriptionFilePlugin("bower.json", ["main"]))]
    })).on('error', gutil.log)
    .pipe(gulp.dest('./dist'))
    .pipe(sourcemaps.init())
    .pipe(rename('all.min.js'))
    .pipe(uglify())
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('./dist'));
});

gulp.task('clean', function () {
  return gulp.src(['./dist/**/*.*']).pipe(plumber()).pipe(clean());
});

gulp.task('watch', function () {
  gulp.watch('./src/**/*.html', ['html']);
  gulp.watch('./src/**/*.coffee', ['coffee']);
  gulp.watch('./src/**/*.less', ['less']);
  gulp.watch('./src/**/*.*', ['webpack']);
});

gulp.task('build',sequence('clean', 'html', 'coffee', 'less', 'webpack'));

gulp.task('default', sequence('build','watch'));
