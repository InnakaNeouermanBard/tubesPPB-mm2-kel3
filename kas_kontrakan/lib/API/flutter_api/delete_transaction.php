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
$id = $_POST['id'];

// Prepare SQL statement
$sql = "DELETE FROM transactions WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $id);

// Execute SQL statement
$response = array();
if ($stmt->execute()) {
    $response['success'] = true;
    $response['message'] = "Transaction deleted successfully!";
} else {
    $response['success'] = false;
    $response['error'] = "Error: " . $conn->error;
}

// Close statement and connection
$stmt->close();
$conn->close();

// Return response to Flutter application
echo json_encode($response);
