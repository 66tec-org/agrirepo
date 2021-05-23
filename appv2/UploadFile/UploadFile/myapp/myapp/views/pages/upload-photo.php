<?php include 'database.php';

$album_id = $_GET['album_id'];
if ($_FILES['photo']['name'] != null) {
move_uploaded_file($_FILES['photo']['tmp_name'], "images/". $_FILES['photo']['name']);
$photo_link = "images/". $_FILES['photo']['name'];

$upload_photo = $mysqli->query("INSERT INTO gallery_photos (`album_id`, `photo_link`)  VALUES ('$album_id', '$photo_link')");
if ($upload_photo) {
header("Location: view-album.php?album_id=$album_id&upload_action=success");
} else {
echo $mysqli->error;
}
} else {
header("Location: in.php");
}
?>