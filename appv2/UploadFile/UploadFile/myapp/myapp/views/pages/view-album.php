<?php
include 'database.php';
if (isset($_GET['album_id'])) {
$album_id = $_GET['album_id']; 
$get_album = $mysqli->query("SELECT * FROM gallery_albums WHERE album_id = $album_id");
$album_data = $get_album->fetch_assoc();
} else {
header("Location: in.php");
}
?>





<!DOCTYPE php>
<php lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1">
    <link rel="stylesheet" href="../src/style.css">
    <link rel="stylesheet" href="../src/add_res.css">
    <link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
    <title><?php
     echo $album_data['album_name'] ?></title>
</head>
<body>
<?php
                ?>  
            <div class="recent-grid">
                <div class="projects">
                    <div class="card">
                        
                    </div>
                </div>
                <div class="customers">                    
                    <div class="contact-left">
                    <?php 
$photo_count = $mysqli->query("SELECT * FROM gallery_photos WHERE album_id = $album_id");
?>
<a href="in.php">Home</a> | <?php echo $album_data['album_name'] ?> (<?php echo $photo_count->num_rows; ?>)<br><br>
<form method="POST" action="upload-photo.php?album_id=<?php echo $album_id ?>" enctype="multipart/form-data">
<label>Add photo to this album:</label><br>
<input type="file" name="photo" /> <button type="submit" name="upload_photo">Upload</button>
</form>
<?php
if (isset($_GET['upload_action'])) {
if ($_GET['upload_action'] == "success") { ?>
<br><br>Photo successfully added to this album!<br><br>
<?php }
}
?>
<?php
$photos = $mysqli->query("SELECT * FROM gallery_photos WHERE album_id = $album_id");
while($photo_data = $photos->fetch_assoc()) { 

?>
<img src="<?php echo $photo_data['photo_link'] ?>"" width="200px" height="200px" />
<?php }
?>

                    </div>
                </div>
            </div>
        </main> 
    </div>
</body>
</php>