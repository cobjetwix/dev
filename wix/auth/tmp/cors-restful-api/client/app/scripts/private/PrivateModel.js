'use strict';

app.factory('PrivateModel', function ($http, ServerUrl) {

	this.collection = null;

	this.getUserCollection = function () {
		//return $http.get('http://localhost:3000/api/user')
		//http://corsnection-server.herokuapp.com
		return $http.get(ServerUrl + '/api/user')
			.success(angular.bind(this, function (data) {
				this.collection = data;
			}))
			.error(angular.bind(this, function (data) {
				this.collection = null;
			}));
	};

	return this;

});