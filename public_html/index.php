<?php
/**
 * A simple front router file, seraches for a file and returns it.
 * The only excuse for this file to exists is to add gzip compression
 * support to PHP built-in-server
 */

try {
    ob_start(extension_loaded('zlib') ? 'ob_gzhandler' : null);
    $file = $_SERVER['DOCUMENT_ROOT'] . $_SERVER['REQUEST_URI'];

    if (!preg_match('/.+\.php$/i', $file)
        && is_file($file)
        && is_readable($file)
    ) {
        readfile($file);
    } else {
        http_response_code(404);
    }
} finally {
    ob_end_flush();
}
