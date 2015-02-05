// Load required packages
var Cobjet = require('../models/cobjet');

// Create endpoint /api/cobjets for POST
exports.postcobjets = function(req, res) {
  // Create a new instance of the cobjet model
  var cobjet = new Cobjet();

  // Set the cobjet properties that came from the POST data
  cobjet.name = req.body.name;
  cobjet.type = req.body.type;
  cobjet.quantity = req.body.quantity;
  cobjet.userId = req.user._id;

  // Save the cobjet and check for errors
  cobjet.save(function(err) {
    if (err)
      res.send(err);

    res.json({ message: 'cobjet added to the locker!', data: cobjet });
  });
};

// Create endpoint /api/cobjets for GET
exports.getcobjets = function(req, res) {
  // Use the cobjet model to find all cobjet
  cobjet.find({ userId: req.user._id }, function(err, cobjets) {
    if (err)
      res.send(err);

    res.json(cobjets);
  });
};

// Create endpoint /api/cobjets/:cobjet_id for GET
exports.getcobjet = function(req, res) {
  // Use the cobjet model to find a specific cobjet
  cobjet.find({ userId: req.user._id, _id: req.params.cobjet_id }, function(err, cobjet) {
    if (err)
      res.send(err);

    res.json(cobjet);
  });
};

// Create endpoint /api/cobjets/:cobjet_id for PUT
exports.putcobjet = function(req, res) {
  // Use the cobjet model to find a specific cobjet
  cobjet.update({ userId: req.user._id, _id: req.params.cobjet_id }, { quantity: req.body.quantity }, function(err, num, raw) {
    if (err)
      res.send(err);

    res.json({ message: num + ' updated' });
  });
};

// Create endpoint /api/cobjets/:cobjet_id for DELETE
exports.deletecobjet = function(req, res) {
  // Use the cobjet model to find a specific cobjet and remove it
  cobjet.remove({ userId: req.user._id, _id: req.params.cobjet_id }, function(err) {
    if (err)
      res.send(err);

    res.json({ message: 'cobjet removed from the locker!' });
  });
};