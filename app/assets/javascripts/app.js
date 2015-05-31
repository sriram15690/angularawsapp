var app;
app = angular.module('app', ["ui.router","ngRoute", "ngResource", "Devise","app.services","ui.grid"]);

app.config(['$routeProvider', '$locationProvider', '$stateProvider','AuthInterceptProvider',
function($routeProvider, $locationProvider, $stateProvider,AuthInterceptProvider) {
	$locationProvider.html5Mode(true);

	$routeProvider.when('/contacts/new', {
		templateUrl : 'templates/contacts/new.html',
		controller : 'newContactCtrl'
	}).when('/', {
		templateUrl : 'templates/events/index.html',
		controller : 'MainHomeCtrl'
	}).when('/contacts/:id', {
		templateUrl : 'templates/contacts/show.html',
		controller : 'contactShowCtrl'
	}).when('/contacts/', {
		templateUrl : 'templates/contacts/index.html',
		controller : 'contactHomeCtrl'
	}).when('/contacts/:id/edit', {
		templateUrl : 'templates/contacts/edit.html',
		controller : 'contactEditCtrl'
	}).when('/users/sign_in', {
		templateUrl : 'templates/auth/login.html',
		controller : 'AuthCtrl',
	}).when('/login', {
		templateUrl : 'templates/auth/login.html',
		controller : 'AuthCtrl',
	}).when('/register', {
		templateUrl : 'templates/auth/register.html',
		controller : 'AuthCtrl',
	}).when('/uploadfiles', {
		templateUrl : 'templates/paricipants/upload.html',
		controller : 'AuthCtrl',
	}).when('/participants/', {
		templateUrl : 'templates/participants/index.html',
		controller : 'participantsHomeCtrl',
	}).when('/participants/new', {
		templateUrl : 'templates/participants/new.html',
		controller : 'participantsNewCtrl',
	}).when('/participants/:id/edit', {
		templateUrl : 'templates/participants/edit.html',
		controller : 'participantsEditCtrl',
	}).when('/participants/:id', {
		templateUrl : 'templates/participants/show.html',
		controller : 'participantshowCtrl',
	}).when('/events/update_prasadam', {
		templateUrl : 'templates/events/update_prasadam.html',
		controller : 'updateEventPrasadamCtrl',
	}).when('/generate_rudram_report', {
		templateUrl : 'templates/participants/new.html',
		controller : 'participantsReportCtrl',
	}).when('/blogs/', {
		templateUrl : 'templates/blogs/index.html',
		controller : 'blogsHomeCtrl',
	}).when('/blogs/new', {
		templateUrl : 'templates/blogs/new.html',
		controller : 'blogsNewCtrl',
	}).when('/blogs/:id/edit', {
		templateUrl : 'templates/blogs/edit.html',
		controller : 'blogsEditCtrl',
	}).when('/blogs/:id', {
		templateUrl : 'templates/blogs/show.html',
		controller : 'blogShowCtrl',
	});
	$routeProvider.otherwise({ redirectTo: '/' });
	
	 // Intercept 401 Unauthorized everywhere
     AuthInterceptProvider.interceptAuth(true);
     
}]);

$(document).on('focus',".datePickerInp", function(){
    $(this).datepicker({
		changeMonth: true,
      	changeYear: true,
      	dateFormat: "dd/mm/yy"
	});
});

/*
 app.state('login', {
 url : '/login',
 templateUrl : 'auth/_login.html',
 controller : 'AuthCtrl'
 }).state('register', {
 url : '/register',
 templateUrl : 'auth/_register.html',
 controller : 'AuthCtrl'
 });

 window.AppCtrl = ['$scope','security', function($scope, security) {
 console.log('In AppCtrl');
 $scope.debug = false;
 $scope.isAuthenticated = security.isAuthenticated;
 }];
 */
