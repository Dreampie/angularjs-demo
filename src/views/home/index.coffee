require './style'

angular.module 'views', ['ngResource']

#RootController
.controller 'HomeCtrl', ($scope, $resource)->
  $scope.name = 'Home'
  Test = $resource 'http://localhost:9000'
  Test.get null, (data)->
    $scope.name = data
  Test.get()
