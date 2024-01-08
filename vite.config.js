import {defineConfig} from 'vite';
import {glob} from 'glob';
import path from 'node:path';
import { fileURLToPath } from 'node:url';


export function CustomHmr() {

  const refresh = ['site'];
  return {
    name: 'custom-hmr',
    enforce: 'post',
    // HMR
    handleHotUpdate({file, server}) {
      // only hot reload files with php extension inside 'site' folder
      if (file.includes('site') && file.endsWith('.php')) {
        server.ws.send({
          type: 'full-reload',
          path: '*'
        });
      }
    },
  }
}

export default defineConfig({
  plugins: [CustomHmr()],
  build: {
    outDir: 'assets/',
    assetsDir: '',
    manifest: true,
    cssMinify: 'lightningcss',
    rollupOptions: {
      input: Object.fromEntries(
        glob.sync('dev/**/[^_]*.{js,scss}').map(file => [
          // This remove `src/` as well as the file extension from each
          // file, so e.g. src/nested/foo.js becomes nested/foo
          path.relative(
            'dev',
            file.slice(0, file.length - path.extname(file).length)
          ),
          // This expands the relative paths to absolute paths, so e.g.
          // src/nested/foo becomes /project/src/nested/foo.js
          fileURLToPath(new URL(file, import.meta.url))
        ])
      ),
    },
  },
})
