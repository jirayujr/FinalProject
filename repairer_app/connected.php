<?php
	header("Access-Control-Allow-Origin: *");
    error_reporting(0);
    error_reporting(E_ERROR | E_PARSE);
    header("content-type:text/javascript;charset=utf-8");
    // edit for boom computer
    //$link = mysqli_connect('localhost', 'jirayu', 'A4145', "repairerapp");
   $link = mysqli_connect('localhost', 'root', 'boom1999', "repairerapp");