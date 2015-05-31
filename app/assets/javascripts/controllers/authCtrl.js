app.controller('NavCtrl', ['$scope', '$routeParams', '$http', 'Auth',
function($scope, $routeParams, $http, Auth) {
	$scope.signedIn = Auth.isAuthenticated;
	$scope.logout = Auth.logout;
	$scope.$on('devise:new-registration', function(e, user) {
		$scope.user = user;
	});

	$scope.$on('devise:login', function(e, user) {
		$scope.user = user;
	});

	$scope.$on('devise:logout', function(e, user) {
		$scope.user = {};
	});

	console.log("in Nav ctrl");

}]);

app.controller('AuthCtrl', ['$scope', '$location', 'Auth',
function($scope, $location, Auth) {
	Auth.currentUser().then(function(user) {
		$scope.user = user;
		$location.path('/');
	});

	/*Auth.currentUser().then(function() {
	 $state.go('home');
	 });*/

	$scope.login = function() {
		Auth.login($scope.user).then(function() {
			$location.path('/');
		});
	};

	$scope.register = function() {
		Auth.register($scope.user).then(function() {
			$location.path('/');
		});
	};
}]);
