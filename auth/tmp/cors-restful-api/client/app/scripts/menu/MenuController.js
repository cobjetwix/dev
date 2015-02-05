'use strict';

app.controller('MenuCtrl', function ($scope, $location, $http, ServerUrl, AuthenticationModel) {

	$scope.AuthenticationModel = AuthenticationModel;

	$scope.signOut = function () {
		AuthenticationModel.removeUser();
		$location.path('/');
		return $http.get(ServerUrl + '/api/auth/signout');
	};

});