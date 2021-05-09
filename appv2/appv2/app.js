const express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var http = require('http');  
var url = require('url');    
var session = require('express-session');
var bodyParser = require('body-parser');
const app = express();
const port = 7000;
var mysql = require('mysql');
var con = mysql.createConnection({
  host: "localhost",
  user: "tecozk_root",
  password: "dbase_fc",
  database: "tecozk_agritech2"
});
con.connect(function(err) {
  if (err) throw err;
console.log("Connected!");
});  



app.use(session({
	secret: 'secret',
	resave: true,
	saveUninitialized: true
}));
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');
//setup public folder
app.use(express.static('./public'));
app.use('/fa', express.static(__dirname + '/node_modules/font-awesome/css'));
app.use('/fonts', express.static(__dirname + '/node_modules/font-awesome/fonts'));

app.use(bodyParser.urlencoded({ extended: false }));
// parse application/json
app.use(bodyParser.json());

///////////////////////////////////

app.get('/',function (req, res) {
  res.render('pages/index')
});

app.get('/home',function (req, res) {
  res.render('pages/home')
});

app.get('/newfarm',function (req, res) {
  if (req.session.loggedin) {
  var username_dash = req.session.username;
  con.query('SELECT role from user_login where username = ?',username_dash, function (error, rsi) {
    var usertype = rsi[0].role;
  res.render('pages/newfarm',{username_dash:username_dash,usertype:usertype });
  });
  } else {
  res.send('Please login to view this page!');
  }
});

app.get('/signup',function (req, res) {
  res.render('pages/signup')
});

app.get('/login',function (req, res) {
  res.render('pages/login')
});

app.get('/logout',function (req, res) {
  req.session.loggedin = false;
  res.render('pages/login')
});


// app.get('/newzone',function (req, res) {
//   var username_dash = req.session.username;
//     res.render('pages/newzone',{username_dash:username_dash });
//   });


app.get('/dashboarduser',function (req, res) {
  if (req.session.loggedin) {
  var username_dash = req.session.username;
  con.query('SELECT role from user_login where username = ?',username_dash, function (error, rsi) {
    var usertype = rsi[0].role;
  res.render('pages/dashboarduser',{username_dash:username_dash,usertype:usertype });
  });
} else {
  res.send('Please login to view this page!');
}
});

// app.get('/dashboardadmin',function (req, res) {
//   res.render('pages/dashboardadmin')
// });


app.get('/allchambers',function (req, res, next){
  if (req.session.loggedin) {
       var username_dash = req.session.username;
      con.query('SELECT * from stream_chamber ORDER BY stream_id DESC LIMIT 10', function (err, rs) {
        con.query('SELECT role from user_login where username = ?',username_dash, function (error, rsi) {
          var usertype = rsi[0].role;
          res.render('pages/allchambers', {username_dash:username_dash,stream: rs,usertype:usertype });
      });});
  } else {
      res.render('errors/notloggedinerror');
  }
});

app.get('/currentchambers',function (req, res, next){
  if (req.session.loggedin) {
      // res.send('Welcome back, ' + req.session.username + '!');
       var username_dash = req.session.username;
      con.query('SELECT * from stream_chamber ORDER BY stream_id DESC LIMIT 10', function (err, rs) {
          res.render('pages/currentchambers', {username_dash:username_dash,stream: rs });
      //  res.render('pages/users');
      });
  } else {
      res.send('Please login to view this page!');
  }
});


// app.get('/buychamber',function (req, res, next){
//   if (req.session.loggedin) {
//       // res.send('Welcome back, ' + req.session.username + '!');
//        var username_dash = req.session.username;
//       //con.query('SELECT * from stream_chamber ORDER BY stream_id DESC LIMIT 10', function (err, rs) {
//           res.render('pages/buychamber', {username_dash:username_dash});
//       //});
//   } else {
//       res.send('Please login to view this page!');
//   }  
// });

// app.get('/croptimeline',function (req, res, next){
//   if (req.session.loggedin) {
//       // res.send('Welcome back, ' + req.session.username + '!');
//        var username_dash = req.session.username;
//       //con.query('SELECT * from stream_chamber ORDER BY stream_id DESC LIMIT 10', function (err, rs) {
//           res.render('pages/croptimeline', {username_dash:username_dash });
//       //});
//   } else {
//       res.send('Please login to view this page!');
//   }
  // res.end();
// });

// app.get('/forms',function (req, res) {
//   res.render('pages/forms')
// });

app.get('/newzone',function (req, res,next) {
  if (req.session.loggedin) {
    username_dash = req.session.username;
    con.query('SELECT chamber_name from chamber where user_name = ?',username_dash, function (err, rsi) {
     con.query('SELECT farm_name from farm where user_name = ?',username_dash, function (err, rs) {
        con.query('SELECT role from user_login where username = ?',username_dash, function (error, rsi) {
          var usertype = rsi[0].role;
    
        res.render('pages/newzone', {username_dash:username_dash,stream: rs,stream2: rsi,usertype: usertype });
    });  });});
  } else {
  res.send('Please login to view this page!');
  }
});

app.get('/newchamber',function (req, res,next) {
  if (req.session.loggedin) {
  var username_dash = req.session.username;
  con.query('SELECT zone_name from zone where user_name = ?',username_dash, function (err, rsi) {
    
    con.query('SELECT farm_name from farm where user_name = ?',username_dash, function (err, rs) {
      con.query('SELECT role from user_login where username = ?',username_dash, function (error, rsi) {
        var usertype = rsi[0].role;
  
      res.render('pages/newchamber', {username_dash:username_dash,stream: rs,stream2: rsi,usertype:usertype });
  });     });});
  } else {
    res.send('Please login to view this page!');
      }
});

app.get('/newcomponent',function (req, res) {
  if (req.session.loggedin) {
  var username_dash = req.session.username;
    
  con.query('SELECT zone_name from zone where user_name = ?',username_dash, function (err, rsi) {
    
    con.query('SELECT farm_name from farm where user_name = ?',username_dash, function (err, rs) {
      con.query('SELECT role from user_login where username = ?',username_dash, function (error, rsi) {
        var usertype = rsi[0].role;
  
      res.render('pages/newcomponent', {username_dash:username_dash,stream: rs,stream2: rsi,usertype:usertype });
    });      
   });  }); 
} else {
    res.send('Please login to view this page!');
      }
  });

  app.get('/insights',function (req, res, next){
    if (req.session.loggedin) {
        // res.send('Welcome back, ' + req.session.username + '!');
         var username_dash = req.session.username;
         con.query('SELECT * from chamber where user_name = ?',username_dash, function (err, rsj) {
    
         con.query('SELECT * from zone where user_name = ?',username_dash, function (err, rsi) {
    
          con.query('SELECT * from farm where user_name = ?',username_dash, function (err, rs) {

            con.query('SELECT role from user_login where username = ?',username_dash, function (error, rsi) {
              var usertype = rsi[0].role;
        
            res.render('pages/insights', {username_dash:username_dash,stream: rs,stream2: rsi ,stream3: rsj,usertype:usertype });
        });  });           });      });
      } else {
        res.send('Please login to view this page!');
            }
  });
  

  app.get('/maintain',function (req, res, next){
    if (req.session.loggedin) {
         var username_dash = req.session.username;
       con.query('SELECT * from chamber where user_name = ?',username_dash, function (err, rsj) {
    
         con.query('SELECT * from zone where user_name = ?',username_dash, function (err, rsi) {
    
          con.query('SELECT * from farm where user_name = ?',username_dash, function (err, rs) {
            con.query('SELECT role from user_login where username = ?',username_dash, function (error, rss) {
              var usertype = rss[0].role;
            res.render('pages/maintain', {username_dash:username_dash,stream: rs,stream2: rsi ,stream3: rsj,usertype:usertype});
        });});   });   });
    } else {
        res.send('Please login to view this page!');
    }
  });

  app.get('/delete', function(req, res) {
       if (req.session.loggedin) {
      var username_dash = req.session.username;
       let deleteId =  req.query.deleteId;
       console.log(deleteId);
      con.query('Delete from farm where farm_id = ?',deleteId, function (err, rs) {
          res.redirect('/maintain');
      });
    } else {
      res.send('Please login to view this page!');
    }
});
  
app.get('/deletechamber', function(req, res) {
  if (req.session.loggedin) {
 var username_dash = req.session.username;
  let deleteId =  req.query.deleteId;
  console.log(deleteId);
 con.query('Delete from chamber where chamber_id = ?',deleteId, function (err, rs) {
     res.redirect('/maintain');
 });
} else {
 res.send('Please login to view this page!');
}
});

app.get('/deletezone', function(req, res) {
  if (req.session.loggedin) {
 var username_dash = req.session.username;
  let deleteId =  req.query.deleteId;
  console.log(deleteId);
 con.query('Delete from zone where zone_id = ?',deleteId, function (err, rs) {
     res.redirect('/maintain');
 });
} else {
 res.send('Please login to view this page!');
}
});
/////////////////////////////////////////////////////////////////////////////////////////////
var credentials = { 
  host: "localhost",
  user: "tecozk_root",
  password: "dbase_fc",
  database: "tecozk_agritech2"
}
//////////////////////////////
app.post('/loginauth',function (req, res) {

  var username = req.body.username;
 	var password = req.body.password;
  var username_dash = username;
   
  var pool = mysql.createPool(credentials);
  var query1 = "SELECT * FROM user_login WHERE username = ? AND password = ?";
  var query2 = "SELECT * from stream_chamber ORDER BY stream_id DESC LIMIT 5";
  var query3 = "SELECT harvestdate from " // yahan pe kaam karna he harvest date lagani he or wo change hogi har chamber k hisaab se dropdown wapas
  // lagayenge dashboard pe chart wali table pe
  var stream = {};
  var countDownDate = new Date("Aug 5, 2021 15:00:00").getTime();
  var rdate;
  // Update the count down every 1 second
    // Get today's date and time
    var now = new Date().getTime();
    // Find the distance between now and the count down date
    var distance = countDownDate - now;
    // Time calculations for days, hours, minutes and seconds
    var days = Math.floor(distance / (1000 * 60 * 60 * 24));
    // Display the result in the element with id="demo"
    rdate = days 
    // If the count down is finished, write some text
    if (distance < 0) {
      clearInterval(x);
      rdate = "Harvest is ready";
    }
    console.log(rdate);
  if (username && password) {
    pool.getConnection(function(err, connection) {
      if (err) throw err; // not connected!
      console.log('connected');
    // Use the connection
    connection.query(query1,[username,password], function (error, results) {
      // connection.release();
                     if (results.length > 0) {
                      req.session.loggedin = true;
                              req.session.username = username;
                              var date = new Date().toLocaleString();
                              connection.query('UPDATE user_login set lastlogin = ? where username = ?',[date,username]);
                              } 
                     else{
                      res.send('invalid name or password')
                     }
      // When done with the connection, release it.
      // Handle error after the release.
      if (error) throw error;
    });
  });
  pool.getConnection(function(err, connection) {
    if (err) throw err; // not connected!
    console.log('connected');
    connection.query(query2, function (error, rs) {
      connection.query('SELECT role from user_login where username = ?',[username], function (error, rsi) {
        var usertype = rsi[0].role;
       
        res.render('pages/dashboarduser',{username_dash:username_dash,stream: rs,rdate :rdate,usertype:usertype });
        
      });
      
       
      connection.release();
    });
      // Don't use the connection here, it has been returned to the pool.
    });
  } 
    else{
      res.send('invalid name or password')
    }
  });
 
app.post('/insertuser' , function(req,res,next){
  
      let fname = req.body.fname;
      let lname = req.body.lname;
      let username = req.body.username;
      let password = req.body.password;
      let email = req.body.email;
      let phone = req.body.phone;
      
      var form_data = {
          username: username,
          password: password,
          email:email,
          phone:phone
      }
      con.query('INSERT INTO user_login SET ?', form_data, function (err, result) {
          res.render('pages/login');
  });     });

app.post('/createfarm' , function(req,res,next){
  let farm_name     = req.body.farm_name;
  let farm_size_len = req.body.farm_size_len;
  let farm_size_wid = req.body.farm_size_wid;
  let farm_location = req.body.farm_location;
  var now = new Date().getTime();
  let farm_create_date = now;
  var username_dash = req.session.username;
  var usertype_dash = req.session.userId;
  var form_data = {
      farm_name: farm_name,
      farm_size_len:farm_size_len,
      farm_size_wid:farm_size_wid,
      farm_location:farm_location,
      user_name:username_dash
    }
  con.query('INSERT INTO farm SET ?', form_data, function (err, result) {
    if (err) throw err;

    con.query('SELECT farm_name from farm where user_name = ?',username_dash, function (err, rs) {
      con.query('SELECT role from user_login where username = ?',username_dash, function (error, rsi) {
        var usertype = rsi[0].role;
  res.render('pages/newchamber', {username_dash:username_dash,stream: rs,usertype:usertype });
  });  });});
});

app.post('/createchamber' , function(req,res,next){
  let chamber_name      = req.body.chamber_name;
  let chamber_disp_name = req.body.chamber_disp_name;
  let farm_name         = req.body.farm_name;
  var username_dash     = req.session.username;
  var usertype          = req.session.usertype;
  
  var form_data = {
      chamber_name: chamber_name,
      chamber_disp_name:chamber_disp_name,
      farm_name : farm_name,
      user_name:username_dash
    }
  con.query('INSERT INTO chamber SET ?', form_data, function (err, result) {
    if (err) throw err;
      con.query('SELECT chamber_name from chamber where user_name = ?',username_dash, function (err, rsi) {
      
        con.query('SELECT farm_name from farm where user_name = ?',username_dash, function (err, rs) {
          con.query('SELECT role from user_login where username = ?',username_dash, function (error, rss) {
            var usertype = rsi[0].role;
          res.render('pages/newzone', {username_dash:username_dash,stream: rs,stream2: rsi,usertype:usertype });
      });  });  });
 
});});

app.post('/createcomponent' , function(req,res,next){
  let component_name = req.body.component_name;
  let component_disp_name = req.body.component_disp_name;
  let component_master_type = req.body.component_master_type;
  let component_type = req.body.component_type;
  var username_dash = req.session.username;
  
  var form_data = {
      component_name: component_name,
      component_disp_name:component_disp_name,
      component_master_type:component_master_type,
      component_type:component_type
    }
  con.query('INSERT INTO component SET ?', form_data, function (err, result) {
    if (err) throw err;
    con.query('SELECT role from user_login where username = ?',username_dash, function (error, rsi) {
      var usertype = rsi[0].role;

    res.render('pages/dashboarduser',{username_dash:username_dash,usertype:usertype});
});   });
});


app.post('/tocomponent' , function(req,res,next){
  let zone_name = req.body.zone_name;
  let chamber_name = req.body.chamber_name;
  let farm_name = req.body.farm_name;
  var username_dash = req.session.username;
  
  var form_data = {
      zone_name: zone_name,
      chamber_name:chamber_name,
      farm_name:farm_name,
      user_name:username_dash
      }
  con.query('INSERT INTO zone SET ?', form_data, function (err, result) {
    if (err) throw err;
    con.query('SELECT zone_name from zone where user_name = ?',username_dash, function (err, rsi) {
    
      con.query('SELECT farm_name from farm where user_name = ?',username_dash, function (err, rs) {
        con.query('SELECT role from user_login where username = ?',username_dash, function (error, rss) {
          var usertype = rss[0].role;
    
        res.render('pages/newcomponent', {username_dash:username_dash,stream: rs,stream2: rsi,usertype:usertype });
    });  });  });
});
});

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
app.listen(port, () => console.log(`Agritech app Started on port ${port}!`));
