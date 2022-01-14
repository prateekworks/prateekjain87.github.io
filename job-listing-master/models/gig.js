var mongoose=require('mongoose');
const jwt=require('jsonwebtoken');
const bcrypt=require('bcrypt');
const confiq=require('../config/config').get(process.env.NODE_ENV);
const salt=10;

var gigSchema = new mongoose.Schema({
    gigid: {
      type: String,
      required: true,
      unique: 1,
    },
    title: {
      type: String,
      length: 25,
      required: true,
    },
    lister: {
      type: String,
      length: 50,
      required: true,
    },
    description: {
      type: String,
      length: 150,
      required: true,
    },
    nature: {
      type: String,
      length: 50,
      required: true,
    },
    category: {
      type: String,
      length: 50,
      required: true,
    },
    payscale: {
      type: String,
      length: 250,
      required: true,
    },
    requirements: {
      type: String,
      trim: true,
      length: 250,
      required: true,
    },
    datePosted: {
      type: String,
      trim: true,
      length: 250,
      required: true,
    },
    dateExpiry: {
      type: String,
      trim: true,
      length: 250,
      required: true,
    },
    overview: {
      type: String,
      trim: true,
      length: 250,
      required: true,
    },
    address: {
      required: true,
      type: [
        {
          street: {
            type: String,
            length: 25,
            required: true,
          },
          landmark: {
            type: String,
            length: 25,
            required: true,
          },
          district: {
            type: String,
            length: 25,
            required: true,
          },
          state: {
            type: String,
            length: 25,
            required: true,
          },
          country: {
            type: String,
            length: 25,
            required: true,
          },
        },
      ],
    },
  });

module.exports=mongoose.model("Gig", gigSchema);
