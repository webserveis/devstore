<?php
//http://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api#http-status

namespace App\Controllers;

use Psr\Log\LoggerInterface;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Message\ResponseInterface as Response;

use App\DataAccess\MyDataAccessPDO;
use App\DataAccess\QueryStringHelper;
use InvalidArgumentException;

define('_PRODUCTS_', 'products');
define('_CATEGORIES_', 'categories');
define('_SUPPLIERS_', 'suppliers');
define('_STORES_', 'stores');
define('_PRODUCTS_AVAILABLE_', 'products_available');
define('_LINK_PRODUCTS_', 'link_products');
define('_COLLECTIONS_', 'collections');


define('_JSON_FLAGS_', JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT );

class MyController {
    protected $logger;
    protected $dataaccess;

     public function __construct(LoggerInterface $logger, MyDataAccessPDO $dataaccess) {
        $this->logger = $logger;
        $this->dataaccess = $dataaccess;
    }

    public function testRoute(Request $req, Response $res, $args) {
        $params = $args;
        return $res->withJson($params, 200, _JSON_FLAGS_ );
    }


    public function getApiStatus(Request $request, Response $response, $args) {

        $this->logger->info(substr(strrchr(rtrim(__CLASS__, '\\'), '\\'), 1).': '.__FUNCTION__);

        $arrparams = $request->getParams();

        try {
            $data = $this->dataaccess->rawQuery("SELECT utime AS last_update FROM products ORDER BY utime DESC LIMIT 1;");
		} catch( \Exception $e ) {
           return $response ->withStatus(422)->write('error: fields');
        }

        return $response->withJson($data, 200, _JSON_FLAGS_ );

    }

    public function getAllCategories(Request $request, Response $response, $args) {

        $this->logger->info(substr(strrchr(rtrim(__CLASS__, '\\'), '\\'), 1).': '.__FUNCTION__);

        $arrparams = $request->getParams();


        $arrFieldsAvailable['filter'] = ['id','name','type','active'];
        $arrFieldsAvailable['sort'] = ['id','name','type','active'];
        return $this->callQueryString($response, _CATEGORIES_ ,$arrparams,$arrFieldsAvailable);


    }

    public function getOneCategory(Request $request, Response $response, $args) {
        $this->logger->info(substr(strrchr(rtrim(__CLASS__, '\\'), '\\'), 1).': '.__FUNCTION__);

        $this->logger->info("id:" . $args['id']);

        $result = $this->dataaccess->get(_CATEGORIES_, $args);
        if ($result == null) {
            return $response ->withStatus(404);
        } else {
            return $response->write(json_encode($result, _JSON_FLAGS_ ));
        }
    }

    public function getAllProducts(Request $request, Response $response, $args) {

        $this->logger->info(substr(strrchr(rtrim(__CLASS__, '\\'), '\\'), 1).': '.__FUNCTION__);

        $arrparams = $request->getParams();


        $arrFieldsAvailable['filter'] = ['id','category_id','supplier_id','name','reorder_level','labels','ctime','available'];
        $arrFieldsAvailable['sort'] = ['id','category_id','supplier_id','name','reorder_level','labels','ctime','available'];
        //Process filter

        return $this->callQueryString($response, _PRODUCTS_,$arrparams,$arrFieldsAvailable);

    }

    public function getOneProduct(Request $request, Response $response, $args) {
        $this->logger->info(substr(strrchr(rtrim(__CLASS__, '\\'), '\\'), 1).': '.__FUNCTION__);

        $this->logger->info("id:" . $args['id']);

        $result = $this->dataaccess->get(_PRODUCTS_, $args);
        if ($result == null) {
            return $response ->withStatus(404);
        } else {
            return $response->write(json_encode($result, _JSON_FLAGS_ ));
        }
    }


    public function getAllSuppliers(Request $request, Response $response, $args) {

        $this->logger->info(substr(strrchr(rtrim(__CLASS__, '\\'), '\\'), 1).': '.__FUNCTION__);

        $arrparams = $request->getParams();

        $arrFieldsAvailable['filter'] = ['id','name','email','website'];
        $arrFieldsAvailable['sort'] = ['id','name','email','website'];
        return $this->callQueryString($response, _SUPPLIERS_,$arrparams,$arrFieldsAvailable);

    }

    public function getOneSupplier(Request $request, Response $response, $args) {
        $this->logger->info(substr(strrchr(rtrim(__CLASS__, '\\'), '\\'), 1).': '.__FUNCTION__);

        $this->logger->info("id:" . $args['id']);

        $result = $this->dataaccess->get(_SUPPLIERS_, $args);
        if ($result == null) {
            return $response ->withStatus(404);
        } else {
            return $response->write(json_encode($result, _JSON_FLAGS_ ));
        }
    }

    public function getAllStores(Request $request, Response $response, $args) {

        $this->logger->info(substr(strrchr(rtrim(__CLASS__, '\\'), '\\'), 1).': '.__FUNCTION__);

        $arrparams = $request->getParams();

        $arrFieldsAvailable['filter'] = ['id','name','email','website'];
        $arrFieldsAvailable['sort'] = ['id','name','email','website'];
        return $this->callQueryString($response, _STORES_,$arrparams,$arrFieldsAvailable);

    }

    public function getOneSotre(Request $request, Response $response, $args) {
        $this->logger->info(substr(strrchr(rtrim(__CLASS__, '\\'), '\\'), 1).': '.__FUNCTION__);

        $this->logger->info("id:" . $args['id']);

        $result = $this->dataaccess->get(_STORES_, $args);
        if ($result == null) {
            return $response ->withStatus(404);
        } else {
            return $response->write(json_encode($result, _JSON_FLAGS_ ));
        }
    }

    public function getAllProductsCompact(Request $request, Response $response, $args) {

        $this->logger->info(substr(strrchr(rtrim(__CLASS__, '\\'), '\\'), 1).': '.__FUNCTION__);

        $arrparams = $request->getParams();

        $arrFieldsAvailable['filter'] = ['id','category_id','name','labels', 'reorder_level','price','discount','utime'];
        $arrFieldsAvailable['sort'] = ['id','category_id','name','reorder_level','price','discount','utime'];

        return $this->callQueryString($response, _PRODUCTS_AVAILABLE_,$arrparams,$arrFieldsAvailable);

    }


    public function getAllProductsLinks(Request $request, Response $response, $args) {

        $this->logger->info(substr(strrchr(rtrim(__CLASS__, '\\'), '\\'), 1).': '.__FUNCTION__);

        $arrparams = $request->getParams();

        $arrFieldsAvailable['filter'] = ['product_id','store_id','link','price','discount'];
        $arrFieldsAvailable['sort'] = ['product_id','store_id','link','price','discount'];

        return $this->callQueryString($response, _LINK_PRODUCTS_,$arrparams,$arrFieldsAvailable);

    }

    public function getAllCollections(Request $request, Response $response, $args) {

        $this->logger->info(substr(strrchr(rtrim(__CLASS__, '\\'), '\\'), 1).': '.__FUNCTION__);

        $arrparams = $request->getParams();

        $arrFieldsAvailable['filter'] = ['id','name','start_date','end_date','label'];
        $arrFieldsAvailable['sort'] = ['id','name','start_date','end_date','label'];
        return $this->callQueryString($response, _COLLECTIONS_,$arrparams,$arrFieldsAvailable);

    }

    public function getOneCollection(Request $request, Response $response, $args) {
        $this->logger->info(substr(strrchr(rtrim(__CLASS__, '\\'), '\\'), 1).': '.__FUNCTION__);

        $this->logger->info("id:" . $args['id']);

        $result = $this->dataaccess->get(_COLLECTIONS_, $args);
        if ($result == null) {
            return $response ->withStatus(404);
        } else {
            return $response->write(json_encode($result, _JSON_FLAGS_ ));
        }
    }



    public function getAvailableCollections(Request $request, Response $response, $args) {

        $this->logger->info(substr(strrchr(rtrim(__CLASS__, '\\'), '\\'), 1).': '.__FUNCTION__);

        $arrparams = $request->getParams();

        try {
            $data = $this->dataaccess->rawQuery("SELECT * FROM collections WHERE CURDATE() BETWEEN start_date AND end_date;");
        } catch( \Exception $e ) {
           return $response ->withStatus(422)->write('error: fields');
        }

        return $response->withJson($data, 200, _JSON_FLAGS_ );

    }


    public function getAll(Request $request, Response $response, $args) {

        $this->logger->info(substr(strrchr(rtrim(__CLASS__, '\\'), '\\'), 1).': '.__FUNCTION__);

        $this->logger->info("category_id:" . $args['category_id']);

        $result = $this->dataaccess->getAll("test_table", $args);
        if ($result == null) {
            return $response ->withStatus(404);
        } else {
            return $response->write(json_encode($result, _JSON_FLAGS_ ));
        }

    }

    public function getOne(Request $request, Response $response, $args) {
        $this->logger->info(substr(strrchr(rtrim(__CLASS__, '\\'), '\\'), 1).': '.__FUNCTION__);

        $this->logger->info("category_id:" . $args['category_id']);

        $result = $this->dataaccess->get("test_table", $args);
        if ($result == null) {
            return $response ->withStatus(404);
        } else {
            return $response->write(json_encode($result, _JSON_FLAGS_ ));
        }
    }


    private function callQueryString(&$response, $table, &$arrparams, &$arrFieldsAvailable) {

        try {
            if (isset($arrparams['filter'])) {
                $filterParams = QueryStringHelper::parserFilterRHS($arrparams['filter']);
                $fieldsAvailable = $arrFieldsAvailable['filter'];

                $field = array_column( $filterParams, 'fieldName');
                if (!array_intersect($field, $fieldsAvailable)) {
                    $fields = implode(', ', $fieldsAvailable);
                    return $response ->withStatus(422)->write("error: some fields no supported here, valid fields: {$fields}");
                }
            }
        } catch( \Exception $e ) {
           return $response ->withStatus(422)->write("error: " . $e->getMessage());
        }

        //Process sort filter
        try {
            if (isset($arrparams['sort_by'])) {
                $sortParams = QueryStringHelper::parserSortRHS($arrparams['sort_by']);
                $fieldsAvailable = $arrFieldsAvailable['sort'];

                $field = array_column( $sortParams, 'fieldName');
                if (!array_intersect($field, $fieldsAvailable)) {
                    $fields = implode(', ', $fieldsAvailable);
                    return $response->withStatus(422)->write("error: some sort fields no supported here, valid fields: {$fields}");
                }
            }
        } catch( \Exception $e ) {
           return $response ->withStatus(422)->write("error: " . $e->getMessage());
        }

        //Process limit page
        try {
            $offset = QueryStringHelper::makePageOffset($arrparams['limit'], $arrparams['page']);
        } catch( \Exception $e ) {
           return $response ->withStatus(422)->write("error: " . $e->getMessage());
        }

        //process request data from data base
        try {
            $result = $this->dataaccess->getAllExtended($table, $filterParams, $sortParams, $offset);
        } catch( \Exception $e ) {
           return $response ->withStatus(422)->write('error: fields' . $e);
        }

        if ($result == null) {
            return $response ->withStatus(404);
        } else {
            return $response->write(json_encode($result, _JSON_FLAGS_ ));
        }

    }
    
}