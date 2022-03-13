<?php

//echo "hello";


// pattadon nutes author
//send All Data to mysql

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
}else{
   // echo "sucess connection";
}


// input to php
 // Getting the received JSON into $json variable.
 $json = file_get_contents('php://input');
 
 // Decoding the received JSON and store into $obj variable.
    $obj = json_decode($json,true);

    $tableNameText = $obj['table_name'];
    $getRecondText = $obj['get_recond'];
   
    //echo $tableNameText;
    //echo $getRecondText;
    //echo $idJobText;
    
    $sql = "SELECT * FROM $tableNameText ORDER BY $getRecondText DESC LIMIT 1";
    $result = $conn->query($sql);
    //echo " ::hello1";

    if ($result->num_rows > 0) {
    // output data of each row
    while($row = $result->fetch_assoc()) {
        echo  $row["$getRecondText"];
    }
    } else {
    echo "0";
    }
    

$conn->close();

?>
