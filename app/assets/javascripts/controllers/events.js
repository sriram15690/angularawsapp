// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

app.controller('MainHomeCtrl', ['$scope', '$routeParams', '$http', '$location','Auth',
function($scope, $routeParams, $http, $location,Auth) {
	$scope.newContactLnk = function() {
		console.log("csame in ng click");
		$location.path('contactsNew');
	};
	Auth.currentUser().then(function(user) {
		// User was logged in, or Devise returned
		// previously authenticated session.
		console.log(user);
		// => {id: 1, ect: '...'}
	}, function(error) {
		// unauthenticated error
		console.log("Not Authenticated");
	});
}]); 

app.controller('updateEventPrasadamCtrl', ['$scope', '$routeParams', '$http', '$location','Auth',
function($scope, $routeParams, $http, $location,Auth) {
	Auth.currentUser().then(function(user) {
	}, function(error) {
		console.log("Not Authenticated");
		$location.path('/');
	});
	
	$(".datePickerInp").datepicker({
		changeMonth: true,
      	changeYear: true,
      	dateFormat: "dd/mm/yy"
	});
	
	$http({
		url: "/events/getExistingEvents.json"
	}).success(function(response){
		$scope.getExistingEvents = response;
		$scope.eventName = "";
	}).error(function(response){
		
	});
	
	$("#generate_prasadam_report").submit(function(e){
		e.preventDefault();
		window.location.href = "/events/generate_letters.pdf?"+$("#generate_prasadam_report").serialize();
	});
	
	
	
	
}]); 