// Load required packages
var mongoose = require('mongoose');
var bcrypt = require('bcrypt-nodejs');

// Define our avatar schema
var avatarSchema = new mongoose.Schema({
  avatarname: {
    type: String,
    unique: true,
    required: true
  },
  password: {
    type: String,
    required: true
  }
});

// Execute before each avatar.save() call
avatarSchema.pre('save', function(callback) {
  var avatar = this;

  // Break out if the password hasn't changed
  if (!avatar.isModified('password')) return callback();

  // Password changed so we need to hash it
  bcrypt.genSalt(5, function(err, salt) {
    if (err) return callback(err);

    bcrypt.hash(avatar.password, salt, null, function(err, hash) {
      if (err) return callback(err);
      avatar.password = hash;
      callback();
    });
  });
});

avatarSchema.methods.verifyPassword = function(password, cb) {
  bcrypt.compare(password, this.password, function(err, isMatch) {
    if (err) return cb(err);
    cb(null, isMatch);
  });
};

// Export the Mongoose model
module.exports = mongoose.model('Avatar', avatarSchema);