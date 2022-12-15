<?php
namespace App\DataAccess;

use Psr\Log\LoggerInterface;
use FaaPz\PDO\Database;
use FaaPz\PDO\Clause\Limit;
use FaaPz\PDO\Clause\Conditional;
use FaaPz\PDO\Clause\Grouping;

/**
 * Class MyCustomDataAccess.
 */
class MyDataAccessPDO {
    /**
     * @var \Psr\Log\LoggerInterface
     */
    private $logger;

    /**
     * @var \Database
     */
    private $pdo;

    /**
     * @var \App\DataAccess
     */
    private $maintable;

    /**
     * @param \Psr\Log\LoggerInterface $logger
     * @param \Database                     $pdo
     */
    public function __construct(LoggerInterface $logger, Database $pdo, $table) {
        $this->logger = $logger;
        $this->pdo = $pdo;
        $this->maintable = $table;
    }

    /**
     * @return array
     */
    public function getAllExtended($path,  &$filterParams = null, &$sortParams = null, $limitOffset) {
        $this
            ->logger
            ->info(substr(strrchr(rtrim(__CLASS__, '\\') , '\\') , 1) . ': ' . __FUNCTION__);

        $table = $this->maintable != '' ? $this->maintable : $path;

        $stmt = $this
            ->pdo
            ->select()
            ->from($table);

        //var_dump($filterParams);

        if (isset($filterParams)) {

            //$swp = array_unshift($this->makeConditional($filterParams)[0])

            $stmt->where(
                new Grouping('AND', ...$this->makeConditional($filterParams))
                //$group
            );
      
        }

        if (isset($sortParams)) {
            foreach ($sortParams as $key => $value) {
                $stmt->orderby($value->fieldName, $value->operator);
            }
        }

        [$limit, $offset] = $limitOffset;
        $stmt->limit(new Limit($limit, $offset));



        $affectedRows = $stmt->execute();
        if ($affectedRows) {
            $result = array();
            while ($row = $affectedRows->fetch(Database::FETCH_ASSOC)) {
                $result[] = $row;
            }
        }
        else {
            $result = null;
        }


        //print_r($stmt->__toString()); //sql setence
        //print_r($stmt->getValues()); //values

        return $result;
    }


    /**
     * @return array
     */
    public function getAll($path, $args) {
        $this->logger->info(substr(strrchr(rtrim(__CLASS__, '\\'), '\\'), 1).': '.__FUNCTION__);

        $table = $this->maintable != '' ? $this->maintable : $path;

        if ($args != null ) {

           $sql = "SELECT * FROM " . $table . ' WHERE ' . implode(',', array_flip($args)) . ' = :' . implode(',', array_flip($args));

            $stmt = $this
                ->pdo
                ->prepare($sql);
            // bind the key
            $stmt->bindValue(':' . implode(',', array_flip($args)) , implode(',', $args));

        } else {
            $stmt = $this->pdo->prepare('SELECT * FROM '. $table);
        }

        $stmt->execute();

        if ($stmt) {
            $result = array();
            while ($row = $stmt->fetch(\PDO::FETCH_ASSOC)) {
                $result[] = $row;
            }
        } else {
            $result = null;
        }

        return $result;
    }

    /**
     * @param int $id
     *
     * @return one object
     */
    public function get($path, $args) {
        $this
            ->logger
            ->info(substr(strrchr(rtrim(__CLASS__, '\\') , '\\') , 1) . ': ' . __FUNCTION__);

        $table = $this->maintable != '' ? $this->maintable : $path;

        $sql = "SELECT * FROM " . $table . ' WHERE ' . implode(',', array_flip($args)) . ' = :' . implode(',', array_flip($args));

        $stmt = $this
            ->pdo
            ->prepare($sql);
        // bind the key
        $stmt->bindValue(':' . implode(',', array_flip($args)) , implode(',', $args));

        $stmt->execute();
        if ($stmt) {
            $result = $stmt->fetch(\PDO::FETCH_ASSOC);
        }
        else {
            $result = null;
        }

        return $result;
    }

    /**
     * @param array $request_data
     *
     * @return int (last inserted id)
     */
    public function add($path, $request_data) {
        $this
            ->logger
            ->info(substr(strrchr(rtrim(__CLASS__, '\\') , '\\') , 1) . ': ' . __FUNCTION__);

        $table = $this->maintable != '' ? $this->maintable : $path;

        if ($request_data == null) {
            return false;
        }

        $columnString = implode(',', array_flip($request_data));
        $valueString = ":" . implode(',:', array_flip($request_data));

        $sql = "INSERT INTO " . $table . " (" . $columnString . ") VALUES (" . $valueString . ")";
        $stmt = $this
            ->pdo
            ->prepare($sql);

        foreach ($request_data as $key => $value) {
            $stmt->bindValue(':' . $key, $request_data[$key]);
        }

        $stmt->execute();

        return $this
            ->pdo
            ->lastInsertId();
    }

    /**
     * @param array $request_data
     *
     * @return bool
     */
    public function update($path, $args, $request_data) {
        $this
            ->logger
            ->info(substr(strrchr(rtrim(__CLASS__, '\\') , '\\') , 1) . ': ' . __FUNCTION__);

        $table = $this->maintable != '' ? $this->maintable : $path;

        // if no data to update or not key set = return false
        if ($request_data == null || !isset($args[implode(',', array_flip($args)) ])) {
            return false;
        }

        $sets = 'SET ';
        foreach ($request_data as $key => $value) {
            $sets = $sets . $key . ' = :' . $key . ', ';
        }
        $sets = rtrim($sets, ", ");

        $sql = "UPDATE " . $table . ' ' . $sets . ' WHERE ' . implode(',', array_flip($args)) . ' = :' . implode(',', array_flip($args));

        $stmt = $this
            ->pdo
            ->prepare($sql);

        foreach ($request_data as $key => $value) {
            $stmt->bindValue(':' . $key, $request_data[$key]);
        }

        // bind the key
        $stmt->bindValue(':' . implode(',', array_flip($args)) , implode(',', $args));

        $stmt->execute();

        return ($stmt->rowCount() == 1) ? true : false;
    }

    /**
     * @param int pk
     *
     * @return bool
     */
    public function delete($path, $args) {
        $this
            ->logger
            ->info(substr(strrchr(rtrim(__CLASS__, '\\') , '\\') , 1) . ': ' . __FUNCTION__);

        $table = $this->maintable != '' ? $this->maintable : $path;

        $sql = "DELETE FROM " . $table . ' WHERE ' . implode(',', array_flip($args)) . ' = :' . implode(',', array_flip($args));

        $stmt = $this
            ->pdo
            ->prepare($sql);
        // bind the key
        $stmt->bindValue(':' . implode(',', array_flip($args)) , implode(',', $args));

        $stmt->execute();

        return ($stmt->rowCount() > 0) ? true : false;
    }

    public function rawQuery($sql) {

        $stmt = $this
            ->pdo
            ->prepare($sql);
        $stmt->execute();
        if ($stmt) {
            $result = array();
            while ($row = $stmt->fetch(\PDO::FETCH_ASSOC)) {
                $result[] = $row;
            }
        }
        else {
            $result = null;
        }

        return $result;
    }


    private function makeConditional($filterParams ) {
        $arr = [];
        foreach ($filterParams as $key => $row) {

            switch ($row->operator) {
                case "eq":
                    $arr[] = new Conditional("{$row->fieldName}", "=", $row->value);
                break;
                case "ne":
                    $arr[] = new Conditional("{$row->fieldName}", "!=", $row->value);
                break;
                case "lt":
                    $arr[] = new Conditional("{$row->fieldName}", "<", $row->value);
                break;
                case "le":
                    $arr[] = new Conditional("{$row->fieldName}", "<=", $row->value);
                break;
                case "gt":
                    $arr[] = new Conditional("{$row->fieldName}", ">", $row->value);
                break;
                case "ge":
                    $arr[] = new Conditional("{$row->fieldName}", ">=", $row->value);
                break;
                case "in":
                    $arr_sanitized = array_map('trim', explode(',', $row->value));
                    $arr[] = new Conditional("{$row->fieldName}", "IN", $arr_sanitized);
                break;
                case "co": 
                    $arr[] = new Conditional("{$row->fieldName}", "LIKE", '%'. $row->value . '%');
                break;
            }
        
        }
        return $arr;
    }

}