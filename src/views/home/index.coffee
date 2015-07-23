require './style'

angular.module 'views', ['ngResource']

#RootController
.controller 'HomeCtrl', ($scope, $resource,Alert)->
  $scope.name = 'Home'
#  Test = $resource 'http://localhost:9000'
#  Test.get null, (data)->
#    $scope.name = data
#  Test.get()
  $scope.users=[
    {name:'1'}
    {name:'2'}
    {name:'3'}
    {name:'4'}
  ]
  $scope.hh = (user)->
    console.log user
    Alert.add type:'danger',msg:'哈哈'