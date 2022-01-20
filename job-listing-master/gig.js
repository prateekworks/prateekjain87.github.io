const express=require('express');
const router = express.Router();
const session = require("express-session");
const MongoDBStore = require("connect-mongodb-session")(session);
const mongoose= require('mongoose');
const bodyparser=require('body-parser');
const cookieParser=require('cookie-parser');
const Gig = require('./models/gig');
const Employee = require('./models/employee');
//const imgModel = require('./models/image.js');
const {auth} =require('./middlewares/auth');
const db=require('./config/config').get(process.env.NODE_ENV);
const path=require('path');
const async = require('async');

const app=express();
app.engine('html', require('ejs').renderFile);
app.set('view engine', 'ejs');
//app.set('views', __dirname);

// app use
//app.set('views', path.join(__dirname, 'views')); 

app.use(bodyparser.urlencoded({extended : false}));
app.use(bodyparser.json());
app.use(cookieParser());
app.use(express.json());  
app.use(express.static(__dirname));

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

router.use(
    session({
      secret: db.SECRET,
      resave: false,
      saveUninitialized: true,
      store: store,
    })
  );

/*const isAuth = (req, res, next) => {
    if(req.session.isAuth){
        next()
    } else {
        res.redirect('http://localhost:8000/signup.html')
    }
  }*/

  const isAuth = (req, res, next) => {
    if(req.session.isAuth){
        next()
    } else {
        res.redirect('http://localhost:8000/signup.html')
    }
  }

router.post("/api/addGig", (req, res) => {
    const { gigid, title, lister, description, nature, category, payscale, street, district, state, country, requirements, datePosted, landmark, dateExpiry, overview } = req.body;
    var myData = new Gig({gigid:gigid, title:title, lister:lister, description:description, nature:nature, category:category, payscale:payscale, requirements:requirements, datePosted:datePosted, dateExpiry:dateExpiry, address : [{country:country, state:state, district:district, landmark:landmark, street:street}] , overview:overview, dateExpiry:dateExpiry});
    myData.save()
      .then(
        res.send("item saved to database")
      )
      .catch(err => {
        console.log(err)
        res.status(400).send("unable to save to database");
      });
  });

/*router.get("/:gigid", (req, res) => {
    Gig.find({
      gigid: req.params.gigid
    },
    function(err, result) {
        if (err) throw err;
        result = JSON.parse(JSON.stringify(result))
        res.render('category', {result});
    });
  });*/

/*router.get("/myGigs", isAuth, (req, res) => {
  obj = [];
  Employee.find({email: "akijain058@gmail.com"},
  function(err,result) {
  result[0].category.forEach(function(cat){
    Gig.find({category: cat},
    function(err,table) {
        if (err) throw err;
        table = JSON.parse(JSON.stringify(table))
        obj.push(table[0]);
        if (result[0].category.length === obj.length) {
          console.log(obj)
          res.render('category1', {obj});
        }
    });
    })

//      result = JSON.parse(JSON.stringify(result))
//      res.render('category1', {table});
    })
});*/

router.post("/api/getGigs", (req, res) => {
  obj = [];
  data = JSON.parse(JSON.stringify(req.body));
  console.log(data)
  Gig.find(data,
    function(err,table) {
        if (err) throw err;
        table = JSON.parse(JSON.stringify(table))
        console.log(table)
        res.render('category1', {table});
        }
    );
});
module.exports = router;