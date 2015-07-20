require './style'

angular.module 'view'

#RootController
.controller 'ErrorCtrl', ($scope, $routeParams)->
  $scope.name = 'Error' + $routeParams.code
