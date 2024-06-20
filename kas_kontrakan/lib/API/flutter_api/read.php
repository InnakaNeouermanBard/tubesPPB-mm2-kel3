<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
$conn = mysqli_connect("localhost", "root", "", "kas_kontrakan");
$query = mysqli_query($conn, "SELECT * from mahasiswa");
$data = mysqli_fetch_all($query, MYSQLI_ASSOC);
echo json_encode($data);
