<?php
require './autoload.php';

use PhpOffice\PhpSpreadsheet\Reader\Xlsx;

class Excel {
    private $reader;
    private $spreadsheet;

    private $pageIndex;
    private $attributeRowIndex;
    private $rowStartIndex;
    private $rowEndIndex;
    private $columnStartIndex;
    private $columnEndIndex;

    private $mySQLLink;

    function __construct(
        $filepath,
        $rowStartIndex = 1,
        $rowEndIndex = 61,
        $columnStartIndex = 1,
        $columnEndIndex = 13,
        $attributeRowIndex = 1,
        $pageIndex = 1
    ) {

        $this->pageIndex = $pageIndex;
        $this->attributeRowIndex = $attributeRowIndex;
        $this->rowStartIndex = $rowStartIndex;
        $this->rowEndIndex = $rowEndIndex;
        $this->columnStartIndex = $columnStartIndex;
        $this->columnEndIndex = $columnEndIndex;

        try {
            // Create xlsx reader with read-only privileges
            $this->reader = new Xlsx();
            $this->reader->setReadDataOnly(true);

            // Load the data
            $this->spreadsheet = $this->reader->load($filepath);
        } catch (\PhpOffice\PhpSpreadsheet\Reader\Exception $e) {
            echo $e . "\n";
        }

    }

    function getCellValue($column, $row) {
        try {
            return $this->spreadsheet->getSheet($this->pageIndex - 1)->getCellByColumnAndRow($column, $row);
        } catch (\PhpOffice\PhpSpreadsheet\Exception $e) {
            echo $e . "\n";
        }
    }

    function getColumnValues($column) {
        $values = [];
        for ($row = $this->rowStartIndex; $row <= $this->rowEndIndex; $row++) {
            // Dont add attribute row
            if ($row == $this->attributeRowIndex) {
                continue;
            }

            $values[] = $this->getCellValue($column, $row);
        }
        return $values;
    }

    function getRowValues($row) {
        $values = [];
        for ($column = $this->columnStartIndex; $column <= $this->columnEndIndex; $column++) {
            $values[] = $this->getCellValue($column, $row);
        }
        return $values;
    }

    function getAttributes() {
        return $this->getRowValues($this->attributeRowIndex);
    }

    function connectToMySQL(
        $username,
        $password,
        $db_name = "cookplus_main_db",
        $route = "127.0.0.1"
    ) {
        $this->mySQLLink = mysqli_connect($route, $username, $password, $db_name);

        // Check if error occur and write it's detail
        if (!$this->mySQLLink) {
            echo "Error: Unable to connect to MySQL." . PHP_EOL;
            echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
            echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
            return;
        } else {
            echo "Success: A proper connection to MySQL was made! The " . $db_name . " database is updated." . PHP_EOL;
            echo "Host information: " . mysqli_get_host_info($this->mySQLLink) . PHP_EOL;
        }
    }

    function getTableValues() {
        $values = array();
        $attributes = $this->getAttributes();
        $attributesIndex = 0;
        for ($column = $this->columnStartIndex; $column <= $this->columnEndIndex; $column++) {
            $values[$attributes[$attributesIndex]->getValue()] = $this->getColumnValues($column);
            $attributesIndex++;
        }
        return $values;
    }

    function getMySQLLink() {
        if ($this->mySQLLink) {
            return $this->mySQLLink;
        } else {
            $this->showMySQLLinkError();
            return null;
        }

    }

    public function __destruct() {
        if ($this->mySQLLink) {
            // Close mySQL connection
            mysqli_close($this->mySQLLink);
        }
    }

    function executeQueries($queries) {
        if ($this->mySQLLink) {
            foreach ($queries as $query) {
                $this->mySQLLink->query($query);
            }
        } else {
            $this->showMySQLLinkError();
        }

    }

    function createInsertQuery($array, $tableName) {
        // Return data
        $queries = [];

        // Gather attributes of mySQL data
        $attributes = [];
        foreach ($array as $key => $dArr) {
            $attributes[] = $key;
        }

        // Create mySQL query
        for ($i = 0; $i < count($array[$attributes[0]]); $i++) {
            // Create base of query
            $query = "INSERT INTO " . $tableName . " (";
            foreach ($array as $key => $dArr) {
                $query .= $key . ", ";
            }
            $query = substr($query, 0, -2);
            $query .= ") VALUES (";

            // Gather values
            for ($j = 0; $j < count($attributes); $j++) {
                // Gather values of query
                if ($attributes[$j] == 'scode') { // Hardcoded !
                    $query .= $array[$attributes[$j]][$i] . ", ";
                } else {
                    $query .= "'" . $array[$attributes[$j]][$i] . "'" . ", ";
                }
            }
            $query = substr($query, 0, -2);
            $query .= ");";

            $queries[] = $query;
        }

        return $queries;
    }

    function createUpdateQuery($array, $setArr, $whereArr) {
        $queries = [];

    }

    function printArray($array) {
        foreach ($array as $value) {
            echo $value . " ";
        }
        echo "\n";
    }

    private function showMySQLLinkError() {
        echo "No MySQL connection. Use connectToMySQL method" . "\n";
    }
}