<?php
// pattadon nutes author
// edit value 

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

//echo "==selectDataMySql==";

// input to php
 // Getting the received JSON into $json variable.
    $json = file_get_contents('php://input');
 
 // Decoding the received JSON and store into $obj variable.
    $obj = json_decode($json,true);
 
 // Getting User selectName from JSON $obj array and store into $selectName.
    
    $tableText = $obj['table'];
    $selectNameText = $obj['selectName'];
    $conditionNameText = $obj['conditionName'];
    $valueNameText = $obj['valueConditionName'];

 


$sql = "SELECT $selectNameText FROM $tableText WHERE $conditionNameText ='$valueNameText'";
$result = $conn->query($sql);
//echo " ::hello1";

if ($result->num_rows > 0) {
    // output data of each row

    //echo $row["email"];
        //echo $row["$selectNameText"];
      //echo "id: " . $row["id"]. " - Name: " . $row["firstname"]. " " . $row["lastname"]. "<br>";
      //$textForm = array("email"=>$row["$selectNameText"]);
      //echo json_encode($textForm);
      while($row = $result->fetch_assoc()) {
        echo $row["$selectNameText"];
        // $textForm = array("$selectNameText"=>$row["$selectNameText"]);
        //echo json_encode($textForm);
      }   
  } else {
    echo "0 results";
  }
  
$conn->close();
 
?>