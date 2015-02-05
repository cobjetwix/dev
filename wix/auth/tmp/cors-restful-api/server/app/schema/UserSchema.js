exports = module.exports = function(app, mongoose) {

	var UserSchema = new mongoose.Schema({
		username: { type: String, required: true },
		name: { type: String },
		password: { type: String },
		profile: {
			id: { type: Number }
			// ...
		}
	});

	UserSchema.statics.encryptPassword = function(password) {
		return require('crypto').createHmac('sha512', app.get('crypto-key')).update(password).digest('hex');
	};


	mongoose.model('User', UserSchema);
}