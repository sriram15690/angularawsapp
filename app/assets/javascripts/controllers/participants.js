app.controller('participantsHomeCtrl', ['$scope', '$http', '$resource','Auth','$timeout',
function($scope, $http, $resource,Auth,$timeout) {
	Auth.currentUser().then(function(user) {
		console.log(user);
	}, function(error) {
		console.log("Not Authenticated");
	});
	
	
	$http({
		method : 'GET',
		url : '/participants.json',
		}).success(function(response) {
			$("#participantsGrid").DataTable({
		"processing" : true,
		"serverSide" : false,
		"bFilter" : true,
		"tabIndex" : -1,
		"info" : false,
		"dom" : "lf<t>p",
		"scrollX": true,
		"scrollY": 400,
		"scrollCollapse" : true,
		jqueryUi : true,
		"lengthMenu": [[10, 25, 40], [10, 25, 40]],
		"data" : response.results,
		"columns" :[{
			data : "roll_num",
			title : "Roll No",
			width : "30px"
		},{
			data : "sankalpam_name",
			title : "Sankalpam Name",
			width : "200px"
		}, {
			data : "address1",
			title : "Address 1",
			width : "200px"
		},  {
			data : "address2",
			title : "Address 2",
			width : "200px"
		},  {
			data : "city",
			title : "City",
			width : "200px"
		}, {
			data : "pincode",
			title : "Pincode",
			width : "200px"
		},  {
			data : "telephone",
			title : "Telephone",
			width : "200px"
		},
		{
			data : "state",
			title : "State",
			width : "200px"
		},{
			data : "gothram",
			title : "Gothram",
			width : "200px"
		},{
			data : "rasi",
			title : "rasi",
			width : "200px"
		},{
			data : "nakshatram",
			title : "nakshatram",
			width : "200px"
		},
		{
			data : "receipt_num",
			title : "receipt_num",
			width : "200px"
		},
		{
			data : "receipt_date",
			title : "receipt_date",
			width : "200px"
		},
		{
			data : "renewal_date",
			title : "Renewal Date",
			width : "200px"
		},
		{
			data : null,
			title : "Actions",
			width : "200px",
			render: function(data, type, full, meta ){
				return '<a class="m_l_10p" href="/participants/' + full.id + '">Show</a><a class="m_l_10p" href="/participants/' + full.id + '/edit">Edit</a><a class="m_l_10p" data-method="delete" data-confirm="Are you sure?" href="/participants/' + full.id + '">Destroy</a>';
			}
		}]
    });
		}).error(function(data, status, headers, config) {
			console.log(status);
		});
		
		
	
    
}]);

app.controller('participantsNewCtrl', ['$scope', '$routeParams', '$http', '$location', '$resource','Auth',
function($scope, $routeParams, $http, $location, $resource,Auth) {
	console.log("new Participant Ctrl");
	Auth.currentUser().then(function(user) {
	}, function(error) {
		console.log("/");
	});
	
	console.log(111);
	$scope.submitParticipantForm = function(participant){
		console.log(participant);
		$scope.participant = participant;
		console.log($scope.participant);
		$http({
		method : 'POST',
		data: {participant: $scope.participant},
		url : '/participants.json',
		}).success(function(response) {
			console.log(response);
			$location.path("/participants/" + response.id);
		}).error(function(data, status, headers, config) {
			console.log(status);
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

app.controller('participantshowCtrl', ['$scope', '$routeParams', '$http', '$location', 'Auth',
function($scope, $routeParams, $http, $location, Auth) {
	Auth.currentUser().then(function(user) {
		console.log(user);
	}, function(error) {
		console.log("Not Authenticated");
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

