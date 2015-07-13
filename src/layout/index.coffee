require './style'

angular.module 'layout', []
#LayoutController
.controller 'HeaderCtrl', ($scope)->
  $scope.name = 'This is header'

.controller 'SidebarCtrl', ($scope)->
  $scope.name = 'This is sidebar'

.controller 'FooterCtrl', ($scope)->
  $scope.name = 'This is footer'