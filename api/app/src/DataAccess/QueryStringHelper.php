<?php
namespace App\DataAccess;
use InvalidArgumentException;

define('_LIMIT_DEFAULT_', 25);
define('_LIMIT_MIN_', 1);
define('_LIMIT_MAX_', 100);

define('_OFFSET_MIN_', 0);
define('_OFFSET_MAX_', 9999);
define('_SORT_DEFAULT_', 'ASC');


/*
filter by
param:eq[value]
param:in[value,value2]
param:le[value],param2:eq[value]

https://avinetworks.com/docs/latest/api-guide/logs.html
*/
class QueryStringHelper {

    private static function getFieldRHS(string $s) : string {
        preg_match('/([[:word:]]+):/', $s, $match);
        return $match[1];
    }

    private static function isFilterParamRHS(string $field) : bool {
        //return preg_match('/([[:word:]]+):\b(eq|lt|eq|lt|lte|gt|gte)\b=([[:word:] :-]+)/', $field);
        return preg_match('/([[:word:]]+):\b(eq|lt|ne|lt|le|gt|ge|in|co)\b\[([[:word:] ,:-]+)/', $field);
    }

    private static function isSortParamRHS(string $field) : bool {
        return preg_match('/([[:word:]]+):\b(asc|desc)\b/', $field);
    }

    private static function getFilterOperatorRHS(string $s) : string {
        preg_match('/:\b(eq|lt|ne|lt|le|gt|ge|in|co)\b/', $s, $match);
        return $match[1];
    }

    private static function hasOperatorRHS(string $s) : bool {
        return preg_match('/([[:word:]]+):/', $s);
    }

    private static function getSortOperatorRHS(string $s) : string {
        preg_match('/:\b(asc|desc)\b/', $s, $match);
        return $match[1];
    }

    private static function getValueRHS(string $s) : string {
        //preg_match('/=([[:word:] :-]+)/', $s, $match);
        preg_match('/\[([[:word:] ,:-]+)/', $s, $match);
        return $match[1];
    }

    public static function parserSortRHS(string $s) : array {
        $s_split = explode(',', $s);
        $arr = [];
        foreach ($s_split as $row) {
            if (QueryStringHelper::isSortParamRHS($row)) {
                $arr[] = new SortParam(QueryStringHelper::getFieldRHS($row) , QueryStringHelper::getSortOperatorRHS($row));
                //$arr[getFieldRHS($field)] = getOperatorRHS($field);
                
            }
            else if (!QueryStringHelper::hasOperatorRHS($row)) {
                $arr[] = new SortParam($row, _SORT_DEFAULT_);
            }
            else {
                throw new InvalidArgumentException("sort param only accepts 'asc' or 'desc'");
            }
        }
        return $arr;
    }

    public static function parserFilterRHS(string $s) : array {
        $s_split = explode('],', $s);
        $arr = [];
        foreach ($s_split as $row) {
            if (QueryStringHelper::isFilterParamRHS($row)) {
                $arr[] = new FilterParam(QueryStringHelper::getFieldRHS($row) , QueryStringHelper::getFilterOperatorRHS($row) , QueryStringHelper::getValueRHS($row));
            } else {
                throw new InvalidArgumentException("filter param only accepts 'eq, ne, lt, le, gt, ge, in, co'");
            }
        }
        return $arr;
    }

    public static function makeLimitOffset(&$limit, &$offset = null) {

        if (!isset($limit)) $limit = _LIMIT_DEFAULT_;
        if (!isset($offset)) $offset = _OFFSET_MIN_;

        if (!is_numeric($limit)) {
            throw new InvalidArgumentException('limit param only accepts integers ' . _LIMIT_MIN_ . ' to ' . _LIMIT_MAX_);
        }

        if (!is_numeric($offset)) {
            throw new InvalidArgumentException('offset param only accepts integers ' . _OFFSET_MIN_ . ' to ' . _OFFSET_MAX_);
        }

        if ($limit < 1 || $limit > _LIMIT_MAX_) {
            throw new InvalidArgumentException('limit param only accepts integers ' . _LIMIT_MIN_ . ' to ' . _LIMIT_MAX_);
        }
        if ($offset < 0 || $offset > _OFFSET_MAX_) {
            throw new InvalidArgumentException('offset param only accepts integers ' . _OFFSET_MIN_ . ' to ' . _OFFSET_MAX_);
        }

        return [$limit, $offset];
    }

}

class SortParam {
    public string $fieldName = "", $operator = "asc";

    public function __construct(string $fieldName, string $operator) {
        $this->fieldName = $fieldName;
        $this->operator = $operator;
    }
}

class FilterParam {
    public string $fieldName = "", $operator = "eq";
    public $value;

    public function __construct(string $fieldName, string $operator, $value) {
        $this->fieldName = $fieldName;
        $this->operator = $operator;
        $this->value = $value;
    }
}