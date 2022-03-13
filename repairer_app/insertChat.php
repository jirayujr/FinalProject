<?php
	include 'connected.php';
	header("Access-Control-Allow-Origin: *");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}

if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
				
		$id_customer = $_GET['id_customer'];
		$id_repairer = $_GET['id_repairer'];
		$firstname_customer = $_GET['firstname_customer'];
		$firstname_repairer = $_GET['firstname_repairer'];
		$time = $_GET['time'];
		$date = $_GET['date'];
		$text_detail = $_GET['text_detail'];
		$orderChat = $_GET['orderChat'];
		$whoSend = $_GET['whoSend'];
		//$lat = $_GET['lat'];
		//$lng = $_GET['lng'];
		
							
		$sql = "INSERT INTO `chat_table`(`id_customer`, `id_repairer`, `firstname_customer`, `firstname_repairer`, `time`, `date`, `text_detail`, `orderChat`,`whoSend`) VALUES ('$id_customer','$id_repairer','$firstname_customer','$firstname_repairer','$time','$date','$text_detail','$orderChat','$whoSend')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome JR ";
   
}
	mysqli_close($link);