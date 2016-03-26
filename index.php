<?php
// creates list of files that can be downloaded via HTTP
ini_set('display_errors', 1);
ini_set('error_reporting', -1);

$scriptName = basename(__FILE__);
$files = array();
$it = new DirectoryIterator(__DIR__);

foreach ($it as $file) {

    if (!$file->isDot()
        && $file->isReadable()
        && $file->getFilename() !== $scriptName
    ) {
        $files[] = $file->getFilename();
    }
}

?>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Directory contents</title>
        <style type="text/css">
            body {
                background: #fff;
                color: #333;

                font-size: 1.0em;
                font-weight: 300;
                font-family: sans-serif;
            }
        </style>
    </head>
    <body>
        <h1>Folder contents</h1>
        <ul class="links">
        <?php foreach ($files as $file) : ?>
            <li>
                <a href="/<?=$file?>">
                    <?=$file?>
                </a>
            </li>
        <?php endforeach ?>
        </ul>
    </body>
</html>
