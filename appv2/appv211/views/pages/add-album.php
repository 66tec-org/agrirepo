<?php
include 'database.php';

if (isset($_POST['submit_album'])) {
$album = $_POST['album_name'];
if ($_FILES['photo']['name'] != null) {
    move_uploaded_file($_FILES['photo']['tmp_name'], "images/". $_FILES['photo']['name']);
    $photo_link = "images/". $_FILES['photo']['name'];
    
    $upload_photo = $mysqli->query("INSERT INTO gallery_albums (album_name) VALUES ('$album')");
    if ($upload_photo) {
header("Location:in.php");
} else {
echo $mysqli-'error';
}
}
}
?>