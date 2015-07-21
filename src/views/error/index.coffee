require './style'

angular.module 'views'

#RootController
.controller 'ErrorCtrl', ($scope, $routeParams)->
  $scope.name = 'Error' + $routeParams.code
