exports = module.exports = function(app, mongoose) {
	require('./UserSchema')(app, mongoose);
}