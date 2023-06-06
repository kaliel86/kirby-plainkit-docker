const {src, dest, watch, series} = require('gulp');
const uglify = require('gulp-uglify');
const {exec} = require('child_process');

// css deps
const postcss = require('gulp-postcss');
const autoprefixer = require('autoprefixer');
const cssnano = require('cssnano');
const sass = require('gulp-sass')(require('sass'));
const size = require('gulp-size');

const browserSync = require('browser-sync').create();


const sassFiles = 'dev/scss/**/*.scss';
const jsFiles = 'dev/js/**/*.js';
const phpFilesHotReload = 'site/**/*.php';
const iconsFiles = 'dev/icons/*.svg';

function js() {
  return src(jsFiles)
    .pipe(uglify())
    .pipe(size())
    .pipe(dest('./assets/js'));
}

function css() {
  const plugins = [
    autoprefixer(),
    cssnano({
      discardComments: {
        removeAll: true
      },
      discardDuplicates: true,
      discardEmpty: true,
      minifyFontValues: true,
      minifySelectors: true,
      zindex: false
    })
  ];

  return src(sassFiles)
    .pipe(sass().on('error', sass.logError))
    .pipe(browserSync.stream())
    .pipe(postcss(plugins))
    .pipe(size())
    .pipe(dest('assets/css'));
}

function reload() {


  browserSync.init({
    open: false,
    proxy: 'http://php',
    files: phpFilesHotReload
  });

  watch(sassFiles, css);
  watch(jsFiles).on('change', series(js, browserSync.reload));
  watch(iconsFiles, sprite);
}

function sprite() {
  return exec('node sprite.js');
}

exports.js = js;
exports.css = css;
exports.default = reload;
