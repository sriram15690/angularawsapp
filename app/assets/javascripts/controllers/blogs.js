app.controller('blogsHomeCtrl', ['$scope', '$http', '$resource','Auth','$timeout','Blog',
function($scope, $http, $resource,Auth,$timeout,Blog) {
	Auth.currentUser().then(function(user) {
		console.log(user);
	}, function(error) {
		console.log("Not Authenticated");
	});
	
	Blog.index(function(response){
		$scope.blogs = response.blogs;
	});
	/*
	$http({
		method : 'GET',
		url : '/blogs.json',
	}).success(function(response) {
		$scope.blogs = response.blogs;
		console.log(response);
	}).error(function(data, status, headers, config) {
		console.log(data);
	});
	*/
		
	
    
}]);

app.controller('blogsNewCtrl', ['$scope', '$routeParams', '$http', '$location', '$resource','Auth','Blog',
function($scope, $routeParams, $http, $location, $resource,Auth,Blog) {
	console.log("new blog Ctrl");
	Auth.currentUser().then(function(user) {
	}, function(error) {
		console.log("/");
	});
	
	$scope.blog = new Blog();

	$scope.submitBlog = function() {
		newBlog = this.blog;
		console.log(newBlog);
		Blog.save(newBlog, function(response) {
			$location.path("/blogs");
		});
	};
}]);

app.controller('participantsEditCtrl',['$scope', '$routeParams', '$http', '$location', '$resource','Auth',
function($scope, $routeParams, $http, $location, $resource,Auth) {
	console.log("new Participant Ctrl");
	Auth.currentUser().then(function(user) {
	}, function(error) {
		console.log("/");
	});
	$(".datePickerInp").datepicker({
		changeMonth: true,
      	changeYear: true,
      	dateFormat: "dd/mm/yy"
	});
	$http({
	method : 'GET',
	url : '/participants/' + $routeParams.id + '.json',
	}).success(function(response) {
		console.log(response);
		$scope.participant = response;
	}).error(function(data, status, headers, config) {
		console.log(data);
	});
	
	$scope.submitParticipantForm = function(participant){
		console.log(participant);
		$scope.participant = participant;
		console.log($scope.participant);
		$http({
		method : 'PUT',
		data: $scope.participant,
		url : '/participants/'+ $routeParams.id+'.json',
		}).success(function(response) {
			console.log(response);
			$location.path("/participants/" + $routeParams.id);
		}).error(function(data, status, headers, config) {
			console.log(status);
		});
	};

}]);

app.controller('blogShowCtrl', ['$scope', '$routeParams', '$http', '$location', 'Auth','Blog',
function($scope, $routeParams, $http, $location, Auth,Blog) {
	Auth.currentUser().then(function(user) {
		console.log(user);
	}, function(error) {
		console.log("Not Authenticated");
	});
	
	$scope.$on('$viewContentLoaded', function(event){
   	 console.log('content loaded!');
	 $("#addCommentPopup").dialog({
   	 	modal: true,
   	 	autoOpen: false
   	 });
  	});
  
	$http({
		method : 'GET',
		url : '/blogs/' + $routeParams.id + '.json',
	}).success(function(response) {
		console.log(response);
		$scope.blog = response;
	}).error(function(data, status, headers, config) {
		console.log(data);
	});
	
	$scope.addComment = function(){
		console.log("in click event");
		$("#addCommentPopup").dialog("open");
	};
	
	$scope.submitComment = function(){
		console.log("in Submit comment event");
		$("#addCommentPopup").dialog("open");
		$http({
			method : 'GET',
			url : '/blogs/' + $routeParams.id + '.json',
		}).success(function(response) {
			console.log(response);
			$scope.blog = response;
		}).error(function(data, status, headers, config) {
			console.log(data);
		});
	};
	
}]);


app.controller('participantsReportCtrl', ['$scope', '$http', '$resource','Auth',
function($scope, $http, $resource,Auth) {
	console.log("new Participant Ctrl");
	Auth.currentUser().then(function(user) {
	}, function(error) {
		console.log("/");
	});
	$http({
		method : 'get',
		url : '/participants/generate_rudram_report',
		}).success(function(response) {
			console.log(response);
		}).error(function(data, status, headers, config) {
			console.log(status);
		});

}]);

