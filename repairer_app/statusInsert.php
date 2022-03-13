<?php
// pattadon nutes author
//send All Data to mysql

echo "hello";


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
    echo "sucess connection";
}

// input to php
 // Getting the received JSON into $json variable.
 $json = file_get_contents('php://input');
 
 // Decoding the received JSON and store into $obj variable.
    $obj = json_decode($json,true);

    $idJobText = $obj['id_job'];
    $dateStartText = $obj['date_start'];
    $dateEndText = $obj['date_end'];
    $statusWorkText = $obj['status_work'];
    $orderStartText = $obj['orderStart_date'];
    $orderEndText = $obj['orderEnd_date'];
    $orderJobText = $obj['order_job'];
 

    echo $idJobText;
    echo $dateStartText;
    echo $dateEndText;
    echo $statusWorkText;
    echo $orderStartText;
    echo $orderEndText;
    echo $orderJobText;
    
    
    $sql = "INSERT INTO jobstatus (id_job, date_start, date_end, status_work, orderStart_date, orderEnd_date,order_job)
    VALUES ('$idJobText','$dateStartText','$dateEndText','$statusWorkText','$orderStartText',
    '$orderEndText','$orderJobText')";
    
    if ($conn->query($sql) === TRUE) {
    echo "New record created successfully";
    } else {
    echo "Error: " . $sql . "<br>" . $conn->error;
    }
    

?>