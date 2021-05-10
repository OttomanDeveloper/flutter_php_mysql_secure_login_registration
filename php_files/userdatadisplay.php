<?php

include 'DatabaseConfig.php';

$username = $_POST['username'];

// Create connection
$conn = new mysqli($HostName, $HostUser, $HostPass, $DatabaseName);

if ($conn->connect_error) {

    die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT * FROM userData where username = '$username'";

$result = $conn->query($sql);

if ($result->num_rows > 0) {

    while ($row[] = $result->fetch_assoc()) {

        $tem = $row;

        $json = json_encode($tem);
    }
} else {
    echo json_encode("No Data Found");
}
echo $json;

$conn->close();
