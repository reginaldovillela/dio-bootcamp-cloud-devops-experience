<?php
$servername = "lab-k8s-database-conn";
$username = "root";
$password = "MySql@123";
$database = "meubanco";

// Criar conexão
$link = new mysqli($servername, $username, $password, $database);

/* check connection */
if (mysqli_connect_errno()) {
    printf("Connect failed: %s\n", mysqli_connect_error());
    exit();
}

?>
