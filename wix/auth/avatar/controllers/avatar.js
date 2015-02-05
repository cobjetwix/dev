// Load required packages
var Avatar = require('../models/avatar');

// Create endpoint /api/avatars for POST
exports.postavatars = function(req, res) {
  var avatar = new Avatar({
    avatarname: req.body.avatarname,
    password: req.body.password
  });

  avatar.save(function(err) {
    if (err)
      res.send(err);

    res.json({ message: 'New beer drinker added to the locker room!' });
  });
};

// Create endpoint /api/avatars for GET
exports.getavatars = function(req, res) {
  avatar.find(function(err, avatars) {
    if (err)
      res.send(err);

    res.json(avatars);
  });
};