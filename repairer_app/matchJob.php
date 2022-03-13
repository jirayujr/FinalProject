<?php
//echo "==============matchRepairer===============";


// Computer Boom 
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
  //  echo "sucess connection";
}


// input to php
 // Getting the received JSON into $json variable.
 $json = file_get_contents('php://input');
 
 // Decoding the received JSON and store into $obj variable.
    $obj = json_decode($json,true);

    $idCustomerText = $obj['idCustomer'];
    $idRepairerText = $obj['idRepairer'];
    $idJobText = $obj['idJob'];
    $orderMatchText = $obj['orderMatch'];

    echo $idCustomerText;
    echo "=";
    echo $idRepairerText;
    echo "=";
    echo $idJobText;
    echo "=";
    echo $orderMatchText;

    
    $sql = "INSERT INTO table_match_job (id_customer, id_repairer, id_job,orderMatch)
    VALUES ('$idCustomerText','$idRepairerText','$idJobText','$orderMatchText')";
    
    if ($conn->query($sql) === TRUE) {
    echo "New record created successfully";
    } else {
    echo "Error: " . $sql . "<br>" . $conn->error;
    }
    
$conn->close();
 
?>