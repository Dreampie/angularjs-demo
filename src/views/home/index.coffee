require './style'

angular.module 'view', ['ngResource']

#RootController
.controller 'HomeCtrl', ($scope, $resource)->
  $scope.name = 'Home'
  Test = $resource 'http://localhost:9000'
  Test.get null, (data)->
    $scope.name = data
  Test.get()
