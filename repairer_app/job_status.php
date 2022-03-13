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

    $idJobText = $obj['id_job'];
    
   
    //echo $idJobText;

    $sql = "SELECT *  FROM jobstatus WHERE id_job = $idJobText";
    $result = $conn->query($sql);
    //echo " ::hello1";

    if ($result->num_rows > 0) {
    // output data of each row
    while($row = $result->fetch_assoc()) {
        echo  $row["status_work"];
    }
    } else {
    echo "0 results";
    }

$conn->close();

?>
