app.controller('contactShowCtrl', ['$scope', '$routeParams', '$http', '$location', 'Auth',
function($scope, $routeParams, $http, $location, Auth) {
	Auth.currentUser().then(function(user) {
		console.log(user);
	}, function(error) {
		console.log("Not Authenticated");
	});
	$http({
		method : 'GET',
		url : '/contacts/' + $routeParams.id + '.json',
	}).success(function(response) {
		console.log(response);
		$scope.contact = response;
	}).error(function(data, status, headers, config) {
		console.log(data);
	});
}]);

app.controller('contactEditCtrl', ['$scope', '$routeParams', '$http', '$location', 'Auth', 'Contact',
function($scope, $routeParams, $http, $location, Auth, Contact) {

	$scope.contact = Contact.get({
		id : $routeParams.id
	});

	//	$scope.contact = new Contact();
	//updateContact = this.contact;

	$scope.submitContact = function() {
		/*
		 $http({
		 method : 'PUT',
		 url : '/contacts/' + $routeParams.id + '.json',
		 data : {
		 contact : {"mobile_num" : $scope.contact.mobile_num}
		 }
		 }).success(function(response) {
		 console.log(response);
		 $location.path("/contacts/" + $routeParams.id);
		 }).error(function(data, status, headers, config) {
		 console.log(data);
		 });
		 */
		Contact.update({
			id : $routeParams.id
		}, $scope.contact, function(response) {
			console.log(response);
			$location.path("/contacts/" + $routeParams.id);
		});

	};
}]);

app.controller('newContactCtrl', ['$scope', '$routeParams', '$http', '$location', 'Auth', 'Contact',
function($scope, $routeParams, $http, $location, Auth, Contact) {
	console.log("newContactCtrl");
	Auth.currentUser().then(function(user) {
		console.log(user);
	}, function(error) {
		console.log("/");
	});

	$scope.contact = new Contact();

	$scope.submitContact = function() {
		newContact = this.contact;
		console.log(newContact);
		Contact.save(newContact, function(response) {
			$location.path("/");
		});
	};

}]);

app.controller('navigationCtrl', ['$scope', '$routeParams', '$http', '$location',
function($scope, $routeParams, $http, $location) {
	console.log("navigationCtrl");
}]);

app.controller('contactHomeCtrl', ['$scope', '$http', '$resource', 'Auth',
function($scope, $http, $resource, Auth) {
	Auth.currentUser().then(function(user) {
		console.log(user);
	}, function(error) {
		console.log("Not Authenticated");
	});

	if ($.fn.DataTable.fnIsDataTable($("#contactsTable"))) {
		$("#contactsTable").dataTable().api().destroy();
	}
	$('#contactsTable').DataTable({
		"lengthMenu" : [[10, 25, 40], [10, 25, 40]],
		dom : "lf<t>p",
		jqueryUi : true,
		pagination : "full_numbers",
		"processing" : true,
		"ajax" : "/contacts/get_all_contacts.json",
		"columns" : [{
			"data" : "name"
		}, {
			"data" : "mobile_num"
		}, {
			"data" : "status"
		}, {
			"data" : "city"
		}, {
			"data" : "membership"
		}, {
			render : function(data, type, row) {
				return '<a href="/contacts/' + row.id + '">Show</a>'
			}
		}, {
			render : function(data, type, row) {
				return '<a href="/contacts/' + row.id + '/edit">Edit</a>'
			}
		}, {
			render : function(data, type, row) {
				return '<a  data-method="delete" data-confirm="Are you sure?" href="/contacts/' + row.id + '">Destroy</a>'
			}
		}]

	});
}]);
