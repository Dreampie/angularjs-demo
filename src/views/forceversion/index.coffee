require './style'

angular.module 'layout', []
#LayoutController
.controller 'ForceVersionList', ($scope,$http)->
    $http.get("http://localhost:8080/versions/listAppForceVersion").success((datas)->
      $scope.items=datas.data.list
    )


