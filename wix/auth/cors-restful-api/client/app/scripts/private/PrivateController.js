'use strict';

app.controller('PrivateCtrl', function ($scope,  AuthenticationModel, PrivateModel) {

	$scope.AuthenticationModel = AuthenticationModel;
	$scope.PrivateModel = PrivateModel;

	$scope.getUserCollection = function () {
		PrivateModel.getUserCollection();
	};

});