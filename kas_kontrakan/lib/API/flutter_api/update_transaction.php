<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header('Content-Type: application/json');

// Database configuration
$host = "localhost"; // Nama host database Anda
$username = "root"; // Username database Anda
$password = ""; // Password database Anda
$database_name = "kas_kontrakan"; // Nama database Anda

// Koneksi ke database
$mysqli = new mysqli($host, $username, $password, $database_name);

// Cek koneksi
if ($mysqli->connect_error) {
    die('Connection Error (' . $mysqli->connect_errno . ') ' . $mysqli->connect_error);
}

// Mendapatkan data dari body request
$data = json_decode(file_get_contents('php://input'), true);

$id = $data['id'];
$amount = $data['amount'];
$description = $data['description'];

// Query update
$query = "UPDATE transactions SET amount=?, description=? WHERE id=?";
$stmt = $mysqli->prepare($query);

// Bind parameter ke query
$stmt->bind_param('dsi', $amount, $description, $id);

// Eksekusi query
if ($stmt->execute()) {
    $response = [
        'success' => true,
        'message' => 'Transaction updated successfully.'
    ];
} else {
    $response = [
        'success' => false,
        'message' => 'Failed to update transaction.'
    ];
}

// Mengirim respons
header('Content-Type: application/json');
echo json_encode($response);

// Tutup statement dan koneksi
$stmt->close();
$mysqli->close();
