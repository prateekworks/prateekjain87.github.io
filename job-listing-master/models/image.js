var mongoose=require('mongoose');
const confiq=require('../config/config').get(process.env.NODE_ENV);

var imageSchema = new mongoose.Schema({
    name: String,
    desc: String,
    img:
    {
        data: Buffer,
        contentType: String
    }
});
  
//Image is a model which has a schema imageSchema
  
module.exports=mongoose.model('Image', imageSchema);