var userView = require('./UserView'),
	passport = require('passport');

exports = module.exports = function(app) {

	// Authentication
	app.post('/api/auth/signin', require('./SignInView').init);
	app.post('/api/auth/signup', require('./SignUpView').init);
	app.get('/api/auth/signout', require('./SignOutView').init);

	app.get('/api/auth/signup/facebook', require('./SignUpView').facebookSignUp);
	app.get('/api/auth/signup/facebook/callback', require('./SignUpView').facebookSignUpCallback);
	
	app.get('/api/auth/signin/facebook', require('./SignInView').facebookSignIn);
	app.get('/api/auth/signin/facebook/callback', require('./SignInView').facebookSignInCallback);

	// Methods
	app.get('/api/user', userView.get);

};