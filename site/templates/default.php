<?php
/**
 * @var Page $page
 */

use Kirby\Cms\Page;

?>
<?= snippet('header'); ?>
<h1><?= $page->title() ?></h1>
<?= snippet('footer'); ?>
<script type="module" src="http://localhost:5173/dev/js/common.js"></script>
