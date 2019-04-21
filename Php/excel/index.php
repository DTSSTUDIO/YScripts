<?php
/**
 * Created by PhpStorm.
 * User: krcyuma
 * Date: 1/23/2019
 * Time: 3:23 PM
 */

require "excel.php";

define("FILE_PATH", ""); // Path to file -  Ex. "sample.xlsx"
define("USERNAME", "");
define("PASSWORD", "");
define("TABLE_NAME", "");

$excel = new Excel(FILE_PATH);

$values = $excel->getTableValues();

$excel->connectToMySQL(USERNAME, PASSWORD);
$queries = $excel->createMySQLQuery($values, TABLE_NAME);
$excel->executeQueries($queries);