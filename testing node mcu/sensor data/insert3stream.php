<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
//Creating Array for JSON response
$response = array();
 
// Check if we got the field from the user
if (isset($_GET['component_name']) && isset($_GET['component_value']) && isset($_GET['zone_name'])&& isset($_GET['chamber_name'])&& isset($_GET['farm_name']) ) {
 
    $component_name = $_GET['component_name'];
    $component_value = $_GET['component_value'];
    $zone_name = $_GET['zone_name'];
    $chamber_name = $_GET['chamber_name'];
    $farm_name = $_GET['farm_name'];
    // Include data base connect class
    $filepath = realpath (dirname(__FILE__));
	require_once($filepath."/db_connect.php");
 
    // Connecting to database 
    $db = new DB_CONNECT();
     $con = $db->connect();
 
    // Fire SQL query to insert data in weather
    $result = mysqli_query($con,"INSERT INTO component_stream (component_name,component_value,zone_name,chamber_name,farm_name) 
    VALUES('$component_name','$component_value','$zone_name','$chamber_name','$farm_name')");
 
    // Check for succesfull execution of query
    if ($result) {
        // successfully inserted 
        $response["success"] = 1;
        $response["message"] = "Row successfully created.";
 
        // Show JSON response
        echo json_encode($response);
    } else {
        // Failed to insert data in database
        $response["success"] = 0;
        $response["message"] = "Something has been wrong";
 
        // Show JSON response
        echo json_encode($response);
    }
} else {
    // If required parameter is missing
    $response["success"] = 0;
    $response["message"] = "Parameter(s) are missing. Please check the request";
 
    // Show JSON response
    echo json_encode($response);
}
?>