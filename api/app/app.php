<?php
setlocale(LC_ALL,"es_ES");
date_default_timezone_set('Europe/Madrid');
mb_internal_encoding('UTF-8');
mb_http_output('UTF-8');

// To help the built-in PHP dev server, check if the request was actually for
// something which should probably be served as a static file
if (PHP_SAPI === 'cli-server' && $_SERVER['SCRIPT_FILENAME'] !== __FILE__) {
    return false;
}

require __DIR__.'/../vendor/autoload.php';

// Instantiate the app
$settings = require __DIR__.'/settings.php';
$app = new \Slim\App($settings);




// Set up dependencies
require __DIR__.'/dependencies.php';

// Register middleware
require __DIR__.'/middleware.php';

// Register routes
require __DIR__.'/routes.php';




// Run!
$app->run();
