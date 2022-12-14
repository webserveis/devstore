<?php

return [
    'settings' => [
        // Slim Settings
        'determineRouteBeforeAppMiddleware' => false,
        'displayErrorDetails' => true,
        'PoweredBy' => 'PR2StudioAPI',

        // database settings set DB NAME
        'pdo' => [
            'dsn' => 'mysql:host=localhost;dbname=dev_store;charset=utf8',
            'username' => 'root',
            'password' => '',
            'options'   => [
                PDO::ATTR_EMULATE_PREPARES => true
            ]
        ],

        // api rate limiter settings
        'api_rate_limiter' => [
            'requests' => '200',
            'inmins' => '60',
        ],

        // monolog settings
        'logger' => [
            'name' => 'app',
            'path' => __DIR__.'/../log/app.log',
        ],
        //Enable debugging (on by default)
        'debug' => true
    ],
];
