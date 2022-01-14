const express=require('express');
const session = require("express-session");
const MongoDBStore = require("connect-mongodb-session")(session);
const mongoose= require('mongoose');
const bodyparser=require('body-parser');
const cookieParser=require('cookie-parser');
const User = require('./models/user');
var router = require('./gig.js');
const Employee = require('./models/employee.js');
//const imgModel = require('./models/image.js');
const {auth} =require('./middlewares/auth');
const db=require('./config/config').get(process.env.NODE_ENV);
const nodemailer=require('nodemailer');
const path=require('path');
const hbs = require('hbs');
const async = require('async');
const multer=require('multer');
var fs = require('fs');
var _ = require('underscore');
const sharp = require('sharp');




const {OAuth2Client} = require('google-auth-library');
const CLIENT_ID = '8872141679-ui896l2ljd03ik9ihmmulfi0gdf8lla5.apps.googleusercontent.com'
const cliente = new OAuth2Client(CLIENT_ID);


const redis = require("redis");
const { request } = require('http');
const { isBuffer, callbackify } = require('util');
const { assert } = require('console');
const client = redis.createClient({
    host: 'localhost',
    port: 6379
});

client.on("connect", ()=> {
    console.log("connected bro");
  });

client.on("error", function(error) {
    console.error(error);
  });

const app=express();
app.set('view engine','ejs');
//app.set('views', __dirname);

// app use
//app.set('views', path.join(__dirname, 'views')); 

app.use(bodyparser.urlencoded({extended : false}));
app.use(bodyparser.json());
app.use(cookieParser());
app.use(express.json());  
app.use(express.static(__dirname));
app.use('/', router);

// Set up Passport



// database connection
mongoose.Promise=global.Promise;
mongoose.connect(db.DATABASE,{ useNewUrlParser: true,useUnifiedTopology:true },function(err){
    if(err) console.log(err);
    console.log("database is connected");
});
const store = new MongoDBStore({
    uri: process.env.DATABASE,
    collection: "mySessions",
  });

  app.use(
    session({
      secret: db.SECRET,
      resave: false,
      saveUninitialized: true,
      store: store,
    })
  );

  const isAuth = (req, res, next) => {
    if(req.session.isAuth){
        next()
    } else {
        res.redirect('http://localhost:8000/signup.html')
    }
  }

// login user
 app.post('/api/login', function(req,res){
    let token=req.cookies.auth;
    User.findByToken(token,(err,user)=>{
        if(err) return  res(err);
        if(user) return res.status(400).json({
            error :true,
            message:"You are already logged in"
        });
    
        else{
            User.findOne({'email':req.body.email},function(err,user){
                if(!user) return res.json({isAuth : false, message : ' Auth failed ,email not found'});
        
                user.comparepassword(req.body.password,(err,isMatch)=>{
                    if(!isMatch) return res.json({ isAuth : false,message : "password doesn't match"});
        
                user.generateToken((err,user)=>{
                    if(err) return res.status(400).send(err);
                   // res.cookie('auth',user.token).json({
                   //     isAuth : true,
                  //      id : user._id
                   //     ,email : user.email
                        
                  //  });
                    req.session.isAuth = true;
                    //res.render('profile'); 
                    res.redirect('http://localhost:8000/category.html')
                });   
            });
          });
        }
    });
});
/*
app.get("/profile", isAuth, (req,res) => {
    res.render("profile");
}); 




// get logged in user
 app.get('/api/profile',auth,function(req,res){
        res.json({
            isAuth: true,
            id: req.user._id,
            email: req.user.email,
            name: req.user.firstname + req.user.lastname
            
        })
}); */

app.post('/api/logout', (req,res) => {
    req.session.destroy((err) => {
        if(err) throwerr;
        res.redirect('http://localhost:8000/signup.html');
    })
    });



app.get('/',function(req,res){
    console.log(req.session);
    res.status(200).send(`Welcome to login , sign-up api`);
});

app.get('/api/glogin', (req,res)=>{
    res.render('index.html');
});

app.post('/api/glogin', (req,res)=>{
    let token = req.body.token;
    console.log(token);
    async function verify() {
    const ticket = await cliente.verifyIdToken({
        idToken: token,
        audience: CLIENT_ID,  

    });
    const payload = ticket.getPayload();
    const userid = payload['sub'];
    console.log(payload)
  }
  verify()
  .then(()=>{
      res.cookie('session-token', token);
      res.send('success');
  }).
  catch(console.error);
})

/*
app.get('/api/profilee', checkAuthenticated, (req, res)=>{
    let user = req.user;
    res.redirect('http://localhost:8000/category.html')
})  

app.get('/api/protectedRoute', checkAuthenticated, (req,res)=>{
    res.send('This route is protected')
}) */

app.get('/api/glogout', (req, res)=>{
    res.clearCookie('session-token');
    res.redirect('http://localhost:8000/signup.html')

})


function checkAuthenticated(req, res, next){

    let token = req.cookies['session-token'];

    let user = {};
    async function verify() {
        const ticket = await cliente.verifyIdToken({
            idToken: token,
            audience: CLIENT_ID,  // Specify the CLIENT_ID of the app that accesses the backend
        });
        const payload = ticket.getPayload();
        user.name = payload.name;
        user.email = payload.email;
        user.picture = payload.picture;
      }
      verify()
      .then(()=>{
          req.user = user;
          next();
      })
      .catch(err=>{
          res.redirect('/api/glogin')
      })

}

app.get('/api/contact',function(req,res){
    res.render('contact');
});

var email;

let transporter = nodemailer.createTransport({
    host: "smtp.gmail.com",
    port: 465,
    secure: true,
    service : 'Gmail',
    
    auth: {
      user: 'amankr3322@gmail.com',
      pass: 'aucacwnxgdruqsub',
    }
    
});
    
app.post('/api/send',function(req,res){
    email=req.body.email;
    
    // generate the otp
    var otp = Math.random();
    otp = otp * 1000000;
    otp = parseInt(otp);
    console.log(otp);

    // set otp in redis (with email as key) with expiration time(5 mins)
    client.setex(req.body.email, 3000000, otp);    

     // send mail with defined transport object
    var mailOptions={
       to: req.body.email,
       subject: "Otp for registration is: ",
       html: "<h3>OTP for account verification is </h3>"  + "<h1 style='font-weight:bold;'>" + otp +"</h1>" // html body
     };
     
     transporter.sendMail(mailOptions, (error, info) => {
        if (error) {
            return console.log(error);
        }
        console.log('Message sent: %s', info.messageId);   
        console.log('Preview URL: %s', nodemailer.getTestMessageUrl(info));
        
        res.redirect('http://localhost:8000/signupverify.html');
    });
});

app.post('/api/verify', usercreate,function(req,res){

    // check if otp exists in redis (else send message otp expired)
    client.keys('*', (err, keys) => {
        if (err) res.render('otp',{msg : 'An error occurred!'});
        if(keys){
            console.log(keys.length);
            
            let flag = 0;
            for(let i = 0; i<keys.length; i++){
                client.get(keys[i], (err, value) => {

                    if (err) res.render('otp',{msg : 'An error occurred!'});

                    if(value === req.body.otp){
                        flag = 1;
                        next();
                                            
                                      }
                     });
                    
             
            }
            
         

            if(flag === 0)
                res.render('otp',{msg : 'Incorrect OTP!'});

        }else{
            res.render('otp',{msg : 'Error fetchin OTP!'});
        }
    });

});  
function usercreate(req, res, next) {
    const newuser=new User(req.body);
    console.log(newuser);
 
    if(newuser.password!=newuser.password2)return res.status(400).json({message: "password not match"});
    
    User.findOne({email:newuser.email},function(err,user){
        if(user) return res.status(400).json({ auth : false, message :"email exits"});
 
        newuser.save((err,doc)=>{
            if(err) {console.log(err);
                return res.status(400).json({ success : false});}
            /*res.status(200).json({
                succes:true,
                user : doc
            });*/
            res.redirect("http://localhost:8000/signup.html");
        });
       });
       
    }

    app.post('/api/passchangesend',function(req,res){
        email=req.body.email;
        
        // generate the otp
        var otp = Math.random();
        otp = otp * 1000000;
        otp = parseInt(otp);
        console.log(otp);
    
        // set otp in redis (with email as key) with expiration time(5 mins)
        client.setex(req.body.email, 3000000, otp);    
    
         // send mail with defined transport object
        var mailOptions={
           to: req.body.email,
           subject: "Otp for registration is: ",
           html: "<h3>OTP for account verification is </h3>"  + "<h1 style='font-weight:bold;'>" + otp +"</h1>" // html body
         };
         
         transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
                return console.log(error);
            }
            console.log('Message sent: %s', info.messageId);   
            console.log('Preview URL: %s', nodemailer.getTestMessageUrl(info));
            
            res.redirect('http://localhost:8000/passchange-verify.html');
        });
    });   
    
    app.post('/api/passchangeverify', updatepassword,function(req,res){

        // check if otp exists in redis (else send message otp expired)
        client.keys('*', (err, keys) => {
            if (err) res.render('otp',{msg : 'An error occurred!'});
            if(keys){
                console.log(keys.length);
                
                let flag = 0;
                for(let i = 0; i<keys.length; i++){
                    client.get(keys[i], (err, value) => {
    
                        if (err) res.render('otp',{msg : 'An error occurred!'});
    
                        if(value === req.body.otp){
                            flag = 1;
                            next();
                                                
                                          }
                         });
                        
                 
                }
                
             
    
                if(flag === 0)
                    res.render('otp',{msg : 'Incorrect OTP!'});
    
            }else{
                res.render('otp',{msg : 'Error fetchin OTP!'});
            }
        });
    
    });  

    function updatepassword(req, res, next) {
        const newuser=new User(req.body);
     
        if(newuser.password!=newuser.password2)return res.status(400).json({message: "password not match"});
        
        User.findOne({email:newuser.email},function(err,user){
            if(err) {console.log(err);
                return res.status(400).json({ success : false});}
        
            const obj = { 
                password : newuser.password
            }
            user = _.extend(user, obj);
            user.save((err,result) =>{
                if(err) {
                    return res.status(400).json({error: "reset password error"});
                }
                else {
                    return res.status(200).json({message: "Your password has been changed."})
                }
            })

            //return res.status(200).json({ auth : false, message :"email exits"});
            
            /* newuser.save((err,doc)=>{
                if(err) {console.log(err);
                    return res.status(400).json({ success : false});}
                res.redirect("http://localhost:8000/signup.html");
            }); */
           });
        
           
        }
// app.post('/resend',function(req,res){

//     // generate a new otp, save it in redis and then send it

//      // generate the otp
//      var otp = Math.random();
//      otp = otp * 1000000;
//      otp = parseInt(otp);
//      console.log(otp);
 
//      // set otp in redis (with email as key) with expiration time(5 mins)
//      client.setex(req.body.email, 3000000, otp);
 
 
//     var mailOptions={
//         to: email,
//        subject: "Otp for registration is: ",
//        html: "<h3>OTP for account verification is </h3>"  + "<h1 style='font-weight:bold;'>" + otp +"</h1>" // html body
//      };
     
//      transporter.sendMail(mailOptions, (error, info) => {
//         if (error) {
//             return console.log(error);
//         }
//         console.log('Message sent: %s', info.messageId);   
//         console.log('Preview URL: %s', nodemailer.getTestMessageUrl(info));
//         res.render('otp',{msg:"otp has been sent"});
//     });

// });

app.get("/api/:email", isAuth, (req,res) => {
    Employee.find({
        email: req.params.email
    }, 
    function(err,result){
        if(err){
            req.flash("error", "Something went wrong.");
            return res.redirect("/");
        }
        //result = JSON.parse(JSON.stringify(result))
        res.render('profile', {result} );
    })
});


  
var storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, 'uploads')
    },
    filename: (req, file, cb) => {
        cb(null, file.fieldname + '-' + Date.now())
    }
});
  
var upload = multer({ storage: storage });

app.get('/2', (req, res) => {
    Employee.findOne({}, (err, items) => {
        if (err) {
            console.log(err);
            res.status(500).send('An error occurred', err);
        }
        else {
            res.render('createprofile');
        }
    });
});

app.post('/api/addEmployee', upload.single('image'), (req, res, next) => {
    const { firstname, lastname, email, dob, userid, category, intro, joiningdate, img} = req.body;

    var myData = new Employee({firstname:firstname, lastname:lastname, email:email, dob:dob, userid:userid, category:category, joiningdate:joiningdate, img: {
        data: fs.readFileSync(path.join(__dirname + '/uploads/' + req.file.filename)),
        contentType: 'image/png'
    }
});
    myData.save()
      .then(item => {
        res.send("item saved to database");
      })
      .catch(err => {
        console.log(err)
        res.status(400).send("unable to save to database");
      });
  });


// listening port
const PORT=process.env.PORT||3000;
app.listen(PORT,()=>{
    console.log(`app is live at ${PORT}`);
});

