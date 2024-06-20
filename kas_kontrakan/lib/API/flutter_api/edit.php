<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
$conn = mysqli_connect("localhost", "root", "", "kas_kontrakan");

$id = $_POST['id'];
$nama = $_POST['nama'];
$alamat = $_POST['alamat'];

$data = mysqli_query($conn, "UPDATE mahasiswa SET nama='$nama', alamat='$alamat' WHERE id='$id'");
if ($data) {
    echo json_encode([
        'pesan' => 'Succses'
    ]);
} else {
    echo json_encode([
        'pesan' => 'Failed'
    ]);
}
