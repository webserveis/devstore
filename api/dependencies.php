<?php

// Generic Controllers / DataAccess

use App\DataAccess\MyDataAccessPDO;
use App\Controllers\MyController;
use App\Controllers\FetchDataController;
use App\DataAccess\QueryStringHelper;


$container = $app->getContainer();

// monolog
$container['logger'] = function ($c) {
    $settings = $c->get('settings');
    $logger = new \Monolog\Logger($settings['logger']['name']);
    $logger->pushProcessor(new \Monolog\Processor\UidProcessor());
    $logger->pushHandler(new \Monolog\Handler\StreamHandler($settings['logger']['path'], \Monolog\Logger::DEBUG));

    return $logger;
};

// Database
$container['pdo'] = function ($c) {
    $settings = $c->get('settings')['pdo'];

    return new \FaaPz\PDO\Database($settings['dsn'], $settings['username'], $settings['password']);
};


$container['App\DataAccess\DataAccessPDO'] = function ($c) {
    return new MyDataAccessPDO($c->get('logger'), $c->get('pdo'), '');
};

$container['App\DataAccess\QueryStringHelper'] = function($c){
    return new QueryStringHelper();
};

// Generic Controller
$container['App\Controllers\MyController'] = function ($c) {
    return new MyController($c->get('logger'), $c->get('App\DataAccess\DataAccessPDO'));
};


// Custom Controllers / DataAccess
$container['App\Controllers\FetchDataController'] = function ($c) {
    return new FetchDataController($c->get('logger'), $c->get('App\DataAccess\DataAccessPDO'));
};




// ...
//$container['App\Controllers\MyCustomController'] = function ($c) {
//    return new MyCustomController($c->get('logger'), $c->get('App\DataAccess\MyCustomDataAccess'));
//};

//$container['App\DataAccess\MyCustomDataAccess'] = function ($c) {
//    return new MyCustomDataAccess($c->get('logger'), $c->get('pdo'), '');
//};

