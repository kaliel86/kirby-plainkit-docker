<?php
/**
 * @var \Kirby\Cms\App $kirby
 * @var \Kirby\Cms\Site $site
 */
$cssFiles = [
  'assets/js/common.js'
];

$jsFiles = [
  'assets/js/common.js'
];
?>

<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Document</title>
  <link rel="stylesheet" href="http://localhost:5173/dev/css/style.scss">
  <?php if (option('debug') === true): ?>
    <script type="module" src="http://localhost:5173/@vite/client"></script>
    <script type="module" src="http://localhost:5173/dev/js/common.js"></script>
  <?php endif; ?>

</head>
<body>
