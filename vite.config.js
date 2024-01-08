import {defineConfig} from 'vite';


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
    manifest: true,
    cssMinify: 'lightningcss',
    rollupOptions: {
      input: 'dev/js/common.js',
    },
  },
})
