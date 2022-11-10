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
  <?= css([
    'assets/css/style.css',
    '@auto'
  ]) ?>
  <?= js('assets/js/common.js', ['defer' => true, 'type' => 'module']) ?>
  <?= js('@auto', ['defer' => true, 'type' => 'module']) ?>
</head>
<body>
