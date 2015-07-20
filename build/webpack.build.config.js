var webpack = require("webpack");
var version = require("../package.json").version;
var banner =
  "/**\n" +
  " * acfun-api-cms v" + version + "\n" +
  " * https://git.acfun.tv/wangrenhui/acfun-api-cms\n" +
  " * Released under the MIT License.\n" +
  " */\n";

module.exports = [
  {
    entry: "./src/app.coffee",
    output: {
      path: "./dist",
      filename: "app.min.js"
    },
    module: {
      loaders: [
        {test: /\.less/, loader: 'style!css!less'},
        {test: /\.coffee/, loader: 'coffee'},
        {test: /\.html$/, loader: "html"},
        {test: /\.(woff|woff2)$/, loader: "url?limit=10000&minetype=application/font-woff"},
        {test: /\.(eot|svg|ttf)$/, loader: "file"},
        {test: /\.(png|jpg|gif)$/, loader: "url-loader"}
      ]
    },
    resolve: {
      modulesDirectories: ['node_modules'],
      extensions: ['', '.html', '.less', '.js', '.coffee']
    },
    plugins: [
      new webpack.optimize.UglifyJsPlugin,
      new webpack.BannerPlugin(banner, {raw: true})
    ]
  }
];