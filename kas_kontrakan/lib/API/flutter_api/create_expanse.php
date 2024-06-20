<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header('Content-Type: application/json');

// Database credentials
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "kas_kontrakan";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get POST data from Flutter application
$username = $_POST['username'];
$amount = $_POST['amount'];
$type = $_POST['type'];  // In this case, type is 'pengeluaran'
$description = $_POST['description'];

// Prepare SQL statement
$sql = "INSERT INTO transactions (username, amount, type, description) VALUES (?, ?, ?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("siss", $username, $amount, $type, $description);

// Execute SQL statement
$response = array();
if ($stmt->execute()) {
    $response['success'] = true;
    $response['message'] = "Expense added successfully!";
} else {
    $response['success'] = false;
    $response['error'] = "Error: " . $conn->error;
}

// Close statement and connection
$stmt->close();
$conn->close();

// Return response to Flutter application
echo json_encode($response);
