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
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet"  href="../about.css">
        <link rel="stylesheet" href="../css/bootstrap.min.css">
        <link rel="stylesheet" type="../text/css" href="fontawesome-free-5.13.0-web\css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Cabin+Condensed:wght@600&display=swap" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500&family=Playfair+Display+SC&display=swap" rel="stylesheet">
        
        <title>GALLERY</title>
  <title><?php
     echo $album_data['album_name'] ?></title>
<style>


.button {
  background-color: #4CAF50; /* Green */
  border: none;
  color: white;
  padding: 7px 25px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
}

.button2 {background-color: #101D87;} /* Blue */
</style>


</head>
<body>
    
<div class="container-fluid top-head" style="padding:5px;color: white; font-size: 12px;">
        <span><i class="fa fa-map-marker" aria-hidden="true" style="margin-left: 30px;color: #616161;font-size: 18px; margin:2px;"></i> R-8, BLOCK-1, SHARIFABAD, F.B. AREA, KARACHI </span>
        <span><i class="fa fa-phone" aria-hidden="true" style="color: #616161;font-size: 18px; margin:2px;" ></i>+9221-36370863</span>
        <span><i class="fa fa-envelope" aria-hidden="true" style="color: #616161;font-size: 18px; margin:2px;" ></i>info@trcss.com.pk</span>
        <!-- <a href="https://www.facebook.com/trcss2006">
        <span class=" social-icon"><i class="fa fa-facebook-official" aria-hidden="true"></i></span></a> -->
        <a href="https://twitter.com/trcss2006"style="float:right;"><i class="fa fa-twitter-square social-icon" aria-hidden="true" style="margin-left: 10px;" ></i></a>
        <a href="https://www.instagram.com/trcss2006/"style="float:right;"><i class="fa fa-instagram social-icon" aria-hidden="true"style="margin-left:10px"></i></a>
        <a href="https://www.facebook.com/trcss2006"style="float:right;"><i class="fa fa-facebook-official social-icon" aria-hidden="true"style="margin-left:10px"></i></a>
       
    </div>

<?php include('nav.php'); ?>
<div class="container-fluid" style="background-color: #f3f3f3; padding: 10px;  box-shadow:0px 0px 2px 0px;">
        
        <div class="container"> 
          <h1 style="color: rgb(80, 80, 80); margin: 4%; ">GALLERY</h1></div>
        </div>
  <div class="container" style="margin-top: 50px; margin-bottom: 50px;">
      <div class="container">
        <div class="row">
    
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
<a href="../gallery.php"><button class="button button2">Back</button></a>  <?php// echo $album_data['album_name'] ?> <?php //echo $photo_count->num_rows; ?><br><br>
<form method="POST" action="upload-photo.php?album_id=<?php echo $album_id ?>" enctype="multipart/form-data">
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
<img src="<?php echo $photo_data['photo_link'] ?>"" width="270px" height="270px" />
<?php }
?>

                    </div>
                </div>
            </div>
        </main> 
    </div>
    </div>
        
        </div>
      </div>
  </div>
  
  <footer>
      <div class="container-fluid" style="height: 60px; background-color: #003277; color: #eee; padding: 20px;">
        <h6 style="text-align: center; font-weight: 700;">All rights reserved 2019 | The Royal City School System | Powered by Plug Orange</h6>
      </div>
    </footer>

</body>

</php>