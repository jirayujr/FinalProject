<?php
// Computer Boom 
 $servername = "localhost";
 $username = "root";
 $password = "boom1999";
 $dbname = "repairerapp";

// Computer J
/*$servername = "localhost";
$username = "jirayu";
$password = "A4145";
$dbname = "repairerapp";*/

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}




// input to php
 // Getting the received JSON into $json variable.
    $json = file_get_contents('php://input');
 
 // Decoding the received JSON and store into $obj variable.
    $obj = json_decode($json,true);
 
 // Getting table, type, value from JSON $obj array and store into $tableNameText $typeNameText $valueNameText.
    $tableNameText = $obj['tableName'];
    $typeNameText = $obj['typeName'];
    $valueNameText = $obj['valueName'];


 


$sql = "DELETE FROM $tableNameText WHERE $typeNameText = '$valueNameText' ";// sreach sql in database
//$result = $conn->query($sql);
//echo " ::hello1";

if ($conn->query($sql) === TRUE) {
    echo "Record deleted successfully";
} else {
    echo "Error deleting record: " . $conn->error;
}

$conn->close();
 
?>