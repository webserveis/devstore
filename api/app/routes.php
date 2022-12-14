<?php

use App\Controllers\MyController;

// Routes
$app->group('/v1', function () {

    $this->get('/status', MyController::class.':getApiStatus'); 

    $this->group('/categories', function () {
        $this->get('', MyController::class.':getAllCategories');
        $this->get('/{id:[0-9]+}', MyController::class.':getOneCategory');
    });

    $this->group('/products', function () {
        $this->get('', MyController::class.':getAllProducts');
        $this->get('/compact', MyController::class.':getAllProductsCompact');
        $this->get('/{id:[0-9]+}', MyController::class.':getOneProduct');
    });

    $this->group('/suppliers', function () {
        $this->get('', MyController::class.':getAllSuppliers');
        $this->get('/{id:[0-9]+}', MyController::class.':getOneSupplier');
    });

    $this->group('/stores', function () {
        $this->get('', MyController::class.':getAllStores');
        $this->get('/{id:[0-9]+}', MyController::class.':getOneSotre');
    });

    $this->group('/productslinks', function () {
        $this->get('', MyController::class.':getAllProductsLinks');
    });

    $this->group('/collections', function () {
        $this->get('', MyController::class.':getAllCollections');
        $this->get('/availables', MyController::class.':getAvailableCollections');
        $this->get('/{id:[0-9]+}', MyController::class.':getOneCollection');
    });
});