import babel from 'rollup-plugin-babel'
import browserSync from 'rollup-plugin-browsersync'
import commonjs from '@rollup/plugin-commonjs'
import livereload from 'rollup-plugin-livereload'
import { terser } from 'rollup-plugin-terser'
import postcss from 'rollup-plugin-postcss'
import phpServer from 'rollup-plugin-php-server'
import resolve from '@rollup/plugin-node-resolve'

const production = !process.env.ROLLUP_WATCH
const port = 8000

export default {
  input: 'src/js/index.js',
  output: {
    sourcemap: true,
    format: 'iife',
    name: 'app',
    file: 'www/assets/bundle.js'
  },
  plugins: [
    babel({
      exclude: 'node_modules/**'
    }),
    // If you have external dependencies installed from
    // npm, you'll most likely need these plugins. In
    // some cases you'll need additional configuration -
    // consult the documentation for details:
    // https://github.com/rollup/plugins/tree/master/packages/commonjs
    resolve({
      browser: true
    }),
    commonjs(),

    postcss({
      extract: true
    }),

    !production && phpServer({
      base: './www',
      port: port,
      directives: {
        'memory_limit': -1,
        'upload_max_filesize': '200M',
        'post_max_size': '200M'
      }
    }),

    !production && browserSync({
      proxy: `localhost:${port}`
    }),

    // Watch the `public` directory and refresh the
    // browser on changes when not in production
    !production && livereload('public'),

    // If we're building for production (npm run build
    // instead of npm run dev), minify
    production && terser()
  ],
  watch: {
    clearScreen: false
  }
}
