var mongoose=require('mongoose');
const jwt=require('jsonwebtoken');
const bcrypt=require('bcrypt');
const confiq=require('../config/config').get(process.env.NODE_ENV);
const salt=10;

const employeeSchema=new mongoose.Schema({
    firstname:{
        type: String,
        required: true,
        maxlength: 100
    },                    
    lastname:{
        type: String,
        required: true,
        maxlength: 100
    },
    email:{
        type: String,
        required: true,
        trim: true,
        unique: 1
    },
    dob:{
        type: Date,
        required: true
    },
    userid:{
        type: String,
    },
    category: [String],
    intro:{
        type: String,
        maxlength: 100
    },
    joiningdate:{
        type: Date,
        required: true
    },
    img:{
        data: Buffer,
        contentType: String
    }

});

//const Employee = mongoose.model('employee', employeeSchema)


module.exports=mongoose.model('Employee',employeeSchema);
