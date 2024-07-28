<?php

use Kirby\Cms\App as Kirby;

Kirby::plugin('maxchene/vite-assets', [
  'components' => [
    'css' => function (Kirby $kirby, string $url, $options = []): string {
      if (option('debug') === false) {
        return uri($url);
      } else {
        return "http://localhost:3000/dev/css/{$url}.scss";
      }
    },
    'js' => function (Kirby $kirby, string $url, $options = []): string {
      return $url;
    }
  ],
]);

function uri($name): string
{
  $manifestFile = 'assets/.vite/manifest.json';
  $manifest = json_decode((string)file_get_contents($manifestFile), true, 512, JSON_THROW_ON_ERROR);
  foreach ($manifest as $item) {
    $url = $item['file'];
    if (str_contains($url, $name)) {
      return 'assets/' . $item['file'];
    }
  }
  return '';
}
