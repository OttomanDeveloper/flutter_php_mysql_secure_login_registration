<?php

include 'DatabaseConfig.php';

$db = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);

$username = $_POST['username'];
$password = $_POST['password'];
$fullname = $_POST['fullname'];

if (empty($username) || empty($password)) {
    echoData('Fill all fields');
} else {
    checkUserExsit();
}

// Check User is New Or Already Registered
function checkUserExsit()
{
    global $db;
    global $username;
    global $fullname;

    $userQuery = "SELECT * FROM userData WHERE username ='$username'";
    $sendingQuery = mysqli_query($db, $userQuery);
    $checkQuery = mysqli_num_rows($sendingQuery);

    if ($checkQuery == 1) {
        // if Username is already registered
        tryLogin();
    } else {

        if (empty($fullname)) {
            echoData('Type Full Name');
        } else {
            trySignup();
        }

    }

}

function tryLogin()
{
    global $db;
    global $username;
    global $password;

    $sql = "SELECT * FROM userData where username = '$username'";

    $result = $db->query($sql);

    if ($result->num_rows > 0) {

        while ($row[] = $result->fetch_assoc()) {

            $tem = $row;
        }

        $dbPWD = $tem[0]['password'];

        if (password_verify($password, $dbPWD)) {
            echoData("Login Success");
        } else {
            echoData("Wrong Password");
        }

    } else {
        echoData("No User Found");
    }
}

function trySignup()
{
    global $db;
    global $username;
    global $password;
    global $fullname;

    $hashPwd = password_hash($password, PASSWORD_DEFAULT);

    $insert = "INSERT INTO userData (fullname,username,password)VALUES('$fullname','$username','$hashPwd')";
    $query = mysqli_query($db, $insert);

    if ($query) {
        echoData("Account Created");
    } else {
        echoData("Getting Error");
    }
}

function echoData($result)
{
    echo json_encode($result);
}
