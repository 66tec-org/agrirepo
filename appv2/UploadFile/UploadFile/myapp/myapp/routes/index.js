var express = require('express');
var multer = require('multer');
var path = require('path');
var router = express.Router();

router.use(express.static(__dirname+"./public/"));
var Storage=multer.diskStorage({
  destination:"./public/uploads/",
  filename:(req,file,cb)=>{
    cb(null,file.fieldname+"_"+Date.now()+path.extname(file.originalname));
  }
}); 

var upload = multer({
  storage:Storage
}).single('file'); 
/* GET home page. */

router.get('/index', function(req, res, next) {
  res.render('index', { title: 'Express' });
});
router.post('/upload', upload, function(req, res, next) {
  
  var success='uploads/'+req.file.filename;
  console.log(success);

  res.render('upload-file', { title: 'Upload File', success:success });
// res.send(success);
});

router.get('/upload', function(req, res, next) {
  res.render('upload-file', { title: 'Upload File', success:'' });
});

module.exports = router;
 