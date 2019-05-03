<?php 
/**
 * @author Yunus Emre
 */
define("ROUTE", "127.0.0.1");
define('DB_NAME', "database");
define('USERNAME', "username");
define('PASSWORD', "password");

// Try to connect mySQL db
$link = mysqli_connect(ROUTE, USERNAME, PASSWORD, DB_NAME);

// Check if error accur and write it's detail
if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    exit;
}

// Update cookplus_store 'www' to 'test' (only for necessary sites)
$link->query("UPDATE cookplus_store SET url = REPLACE(url, 'www', 'test') where store_id < 4;");

// Update cookplus_setting 'www' to 'test' only for necessary sites
$link->query("UPDATE cookplus_setting cs SET `value` = REPLACE(`value`, 'www', 'test') WHERE `key` = 'config_url';");

// Type detail information
echo "Success: A proper connection to MySQL was made! The " . DB_NAME . " database is updated." . PHP_EOL;
echo "Host information: " . mysqli_get_host_info($link) . PHP_EOL;

// Close connection
mysqli_close($link);



?>