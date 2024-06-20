<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
$conn = mysqli_connect("localhost", "root", "", "kas_kontrakan");

$username = $_POST['username'];
$email = $_POST['email'];
$password = $_POST['password'];

$data = mysqli_query($conn, "INSERT INTO login SET username='$username', email='$email', password='$password' ");
if ($data) {
    echo json_encode([
        'pesan' => 'Succses'
    ]);
} else {
    echo json_encode([
        'pesan' => 'Failed'
    ]);
}
