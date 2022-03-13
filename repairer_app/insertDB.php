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
    echo "sucess connection";
}

// input to php
 // Getting the received JSON into $json variable.
 $json = file_get_contents('php://input');
 
 // echo $json;
 // Decoding the received JSON and store into $obj variable.
    $obj = json_decode($json,true);
    //$numArr = count($obj);
    $typeName  = "";
    echo "++";
    echo $obj['sizeArr'];
    //$int_value = (int) $obj['sizeArr'];
    echo "++";
    echo "--";
    echo $obj['tableName'];
    $tableNameText = $obj['tableName'];
    echo "--";
    for ($i = 0; $i < ($obj['sizeArr'] - 2) / 2; $i++) {
      echo "=[$i ]=";
      echo $obj[$i];
      if($i < ((($obj['sizeArr'] - 2)/2)-1)){
        $typeName = $typeName."$obj[$i],";
      }else{
        $typeName = $typeName."$obj[$i]";
      }
    }
    echo $typeName;
    
    
    $valueName = "";
    for ($i = (($obj['sizeArr'] - 2) / 2); $i < ($obj['sizeArr'] - 2); $i++) {
      echo "+[$i ]+";
      echo $obj[$i];
      if($i < (($obj['sizeArr'] - 2)-1)){
        $valueName = $valueName."'$obj[$i]',";
      }else{
        $valueName = $valueName."'$obj[$i]'";
      }
    }
    echo $valueName;
    
    //$textTableCheck  = "id_customer, id_repairer,id_job,orderMatch";
    $keyTableCheck = "'1', '2', 'Toyota','1'";
    $sql = "INSERT INTO $tableNameText ($typeName)
    VALUES ($valueName)";

    if ($conn->query($sql) === TRUE) {
      echo "New record created successfully";
    } else {
      echo "Error: " . $sql . "<br>" . $conn->error;
    }

    /*$idText = $obj(0);
    echo "+";
    echo $idText;
    echo "+";

    $typeValue = array("id_customer", "id_repairer", "id_job","orderMatch ");
    $value = array("1", "2", "Toyota","1");
    $textTable  = "id_customer, id_repairer,id_job,orderMatch";
    $keyTable = "'1', '2', 'Toyota','1'";
    $sql = "INSERT INTO table_match_job ($textTable)
    VALUES ($keyTable)";
    
    if ($conn->query($sql) === TRUE) {
      echo "New record created successfully";
    } else {
      echo "Error: " . $sql . "<br>" . $conn->error;
    }
    
    echo "=========end==========";*/
    /*
    $idText = $obj['id'];
    $firstnameText = $obj['firstname'];
    $lastnameText = $obj['lastname'];
    $typeText = $obj['type'];
    $addressText = $obj['address'];

    $phoneText = $obj['phone'];
    $userText = $obj['user'];
    $passwordText = $obj['password'];
    $avatarText = $obj['avatar'];
    $latText = $obj['lat'];

    $lngText = $obj['lng'];

    echo $idText;
    echo $firstnameText;
    echo $lastnameText;
    echo $typeText;
    echo $addressText;

    echo $phoneText;
    echo $userText;
    echo $passwordText;
    echo $avatarText;
    echo $latText;

    echo $lngText;
    //INSERT INTO `givefix` (`date1`, `time1`, `typeRepairer`, `identifySymptoms`, `address1`, `image1`, `image2`, `image3`, `image4`, `lat`, `lng`) VALUES ('1', '11', '1', '1', '1', '1', '1', '1', '2', '1', '1');
    
    $sql = "INSERT INTO user (id, firstname, lastname, type, address, phone, user, password, avatar, lat, lng)
    VALUES ('$idText','$firstnameText','$lastnameText','$typeText','$addressText',
    '$phoneText','$userText','$passwordText','$avatarText','$latText','$lngText')";
    

    if ($conn->query($sql) === TRUE) {
    echo "New record created successfully";
    } else {
    echo "Error: " . $sql . "<br>" . $conn->error;
    }
    */
?>