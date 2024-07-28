<?php
/**
 * @var \Kirby\Cms\App $kirby
 * @var \Kirby\Cms\Site $site
 */
?>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Document</title>
  <?= css('style') ?>
  <?php if (option('debug') === true): ?>
    <script type="module" src="http://localhost:3000/@vite/client"></script>
  <?php endif; ?>
</head>
<body>
