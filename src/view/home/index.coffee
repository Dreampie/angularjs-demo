require './style'

angular.module 'view', []

#RootController
.controller 'HomeCtrl', ($scope)->
  $scope.name = 'Home'