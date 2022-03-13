<?php
// pattadon nutes author
// edit value 


//Computer Boom 
 $servername = "localhost";
 $username = "root";
 $password = "boom1999";
 $dbname = "repairerapp";

// Computer J
/*
$servername = "localhost";
$username = "jirayu";
$password = "A4145";
$dbname = "repairerapp";*/

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}else{
    //echo "sucess connection";
}


echo "==updateDataMySql1==";

// input to php
 // Getting the received JSON into $json variable.
    $json = file_get_contents('php://input');
 
 // Decoding the received JSON and store into $obj variable.
    $obj = json_decode($json,true);
 
 // Getting User email from JSON $obj array and store into $email.
    
    $tableText = $obj['table'];
    $dataTypeText = $obj['dataType'];
    $dataValueText= $obj['dataValue'];
    $dataTypeConditionText = $obj['dataTypeCondtion'];
    $valueConditonText = $obj['valueConditon'];

 


$sql = "UPDATE $tableText SET $dataTypeText = '$dataValueText' WHERE  $dataTypeConditionText  = '$valueConditonText'";// sreach sql in database
$result = $conn->query($sql);
//echo " ::hello1";

if ($conn->query($sql) === TRUE) {
    echo "Record updated successfully";
  } else {
    echo "Error updating record: " . $conn->error;
  }
  
$conn->close();
 
?>