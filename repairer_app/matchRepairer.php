<?php
//echo "==============matchRepairer===============";


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
global $conn;
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

//  get data from file
    $dateText = $obj['date'];
    $typeRepairerText = $obj['typeRepairer'];
    $latText = $obj['lat'];
    $lngText = $obj['lng'];
    $idText = $obj['id'];


    //echo $dateText;
    //echo $typeRepairerText;
    //echo $latText;
    //echo $lngText;
    //echo $idText;

    //echo "()()()()()()()()(())";
    //$diffLngText = $lngText - 90;
    //$diffLatText = $latText - 12;
    //echo $diffLngText;
    //echo $diffLatText;

    $checkKeyText = 0;//check value lat and lng
    $ansIdText = 0;// return id text

    $selectNameText = "id_repairer";// select name field text 

    $sql = "SELECT * FROM table_find_repaierer WHERE type_repairer = '$typeRepairerText' AND status_repairer = 'free'";// select from where
    $result = $conn->query($sql);// value query to result

    /*
    // test status cancel
    $sqlCancel = "SELECT * FROM table_cancel_customer_repairer WHERE id_customer = '$idText'  AND type_repairer = 'computerTechnician' ";//select from cancel customer repairer
    $resultCancel = $conn->query($sqlCancel);// value query to result cancel

    // date now
    $yearNow = date("Y");
    $monthNow = date("n");
    $dayNow = date("j");
    //echo $yearNow;
    //echo $monthNow;
    //echo $dayNow;

    
    if($resultCancel->num_rows > 0){
        //echo "testValue";
        while($rowCancel = $resultCancel->fetch_assoc() ){
            //echo $rowCancel["status_cancel"];

            if($rowCancel["id_repairer"] == '3'){

                if($rowCancel["year_cancel"] == $yearNow){
                    
                    if($rowCancel["month_cancel"] == $monthNow){
                        //if($rowCancel["year_cencel"] == $yearNow)
                        if($rowCancel["day_cancel"] >= $dayNow){
                            echo $rowCancel["status_cancel"];
                            echo $rowCancel["day_cancel"];
                        }
                    }
                    
                }
            }
        }
    }
    */

    /*
    $today = date("j/n/Y"); 
    echo $today;

    if($resultCancel->num_rows > 0){
        //echo "testValue";
        while($rowCancel = $resultCancel->fetch_assoc() ){
            //echo $rowCancel["status_cancel"];
            if($rowCancel["date_cancel"] == $today){
                echo $rowCancel["status_cancel"];
            }
        }
    }
    */

    if ($result->num_rows > 0) {// check if result_number > 0 
     
        while($row = $result->fetch_assoc()) {//load data field
            //echo "+";
            //echo $row["$selectNameText"];
            //echo "=lat=";
            //echo $row["lat"];
            //echo "=lng=";
            //echo $row["lng"];
            //echo "+";
            $KeyText = abs(($row["lat"] + $row["lng"]) - ($latText + $lngText));// check lat and lng
            //echo "KeyText:: $KeyText";

            // check value lat lng

            if($checkKeyText == 0 && $KeyText != 0){// check value lat lng first data but lat lng is not equal
               // echo "=1=";
              //  echo "=checkKeyText == 0 && KeyText != 0=";
               // $checkKeyText = $KeyText;//edit
              //  echo $checkKeyText;
               // echo "=selectNameText=";
                //$ansIdText = $row["$selectNameText"];//edit
                //echo "ansId :: $ansIdText";

                if(checkCancel($idText,$row["id_repairer"],$row["type_repairer"],$conn) == true){// checkCancel value
                    //echo "checkCancel+true@";
                }else{
                    //echo "checkCancel+false@";
                    $checkKeyText = $KeyText;//edit
                    $ansIdText = $row["$selectNameText"];//edit
                }

            }elseif($checkKeyText == 0 && $KeyText == 0){//check value lat lng first data but lat lng is 0
                //echo "=2=";
               // echo "checkKeyText == 0 && KeyText == 0";
               if(checkCancel($idText,$row["id_repairer"],$row["type_repairer"],$conn) == true){// checkCancel value
                   // echo "checkCancel* true";

               }else{
                   //echo "checkCancel* false";
                   $ansIdText = $row["$selectNameText"];
                   //echo "ansId :: $ansIdText";
                   break;
               }
            }elseif($checkKeyText != 0 && $KeyText != 0){// check value lat lng data change value
                //echo "=3=";

                if(checkCancel($idText,$row["id_repairer"],$row["type_repairer"],$conn) == true){// check cancel value
                    //echo "checkCancel^true";
                }else{
                    //echo "checkCancel^false";
                    
                    //echo "=checkKeyText != null=";
                    if($checkKeyText > $KeyText){ // compare lag lng old new repairer
                        // echo "checkKeyText > KeyText";
                        $checkKeyText = $KeyText;
                        //echo "keyText:: $KeyText";
                        // $idText = $row["$selectNameText"];
                        // echo "idText:: $idText";
                        $ansIdText = $row["$selectNameText"];
                        //echo "ansId :: $ansIdText";
                    }elseif($checkKeyText < $KeyText){
                        //echo "checkKeyText < KeyText";
                    }elseif($checkKeyText == $KeyText){
                        //echo "checkKeyText = KeyText";
                    }
                }


                
            }elseif($checkKeyText != 0 && $KeyText == 0){// check value lat lng data other lag lng now not equal 0
                //echo "=4=";


                if(checkCancel($idText,$row["id_repairer"],$row["type_repairer"],$conn) == true){// checkCancel value
                   // echo "checkCancel%true";
                }else{
                   // echo "checkCancel%false";
                    //echo "checkKeyText != 0 && KeyText == 0";
                    $ansIdText = $row["$selectNameText"];
                    //echo "ansId :: $ansIdText";
                    break;
                }

            }else{ // other
                echo "error";
            }
           // echo " =update+::";
           // echo $ansIdText;
           // echo "::+update= ";
        }
        //echo "ansIdFinal :: $ansIdText";
        //echo "@";
        echo $ansIdText;
        //echo "@";
        //checkCancel($idText,'3','computerTechnician',$conn);
        //if(true == checkCancel($idText,'3','computerTechnician',$conn)){
        //    echo "checkCancel_true";
        //}
 
    } else {
        echo "0 results";
    }
  
    function checkCancel($id_customer1,$id_repairer1,$type_repairer1,$conn1){ // function checkCancel
        $ansCancel = false;// ans value cancel
        //echo "+";
        // select from table sql
        $sqlCancel = "SELECT * FROM table_cancel_customer_repairer WHERE id_customer = '$id_customer1'  AND type_repairer = '$type_repairer1' ";//select from cancel customer repairer
        $resultCancel = $conn1->query($sqlCancel);// value query to result cancel

        // date now
        $yearNow = date("Y");
        $monthNow = date("n");
        $dayNow = date("j");

        
        if($resultCancel->num_rows > 0){
            //echo "testValue";
            while($rowCancel = $resultCancel->fetch_assoc() ){
                //echo $rowCancel["status_cancel"];

                if($rowCancel["id_repairer"] == $id_repairer1){

                    if($rowCancel["year_cancel"] == $yearNow){
                        
                        if($rowCancel["month_cancel"] == $monthNow){
                            //if($rowCancel["year_cencel"] == $yearNow)
                            if($rowCancel["day_cancel"] >= $dayNow){
                               // echo $rowCancel["status_cancel"];
                               // echo $rowCancel["day_cancel"];
                                return true;
                            }
                        }
                        
                    }
                }
            }
        }
    
    //    echo "+";
    }

$conn->close();
 
?>