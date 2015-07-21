require './style'

angular.module 'layout', []
#LayoutController
.controller 'ForceVersionList', ($scope)->
  $scope.items =[
    {id:"1",clientType:"ios正常版",status:"开",destVersion:"3.2.1",sourceVersion:"3.1.1",opration:"修改  版本管理"},
    {id:"2",clientType:"ios越狱版",status:"开",destVersion:"3.2.1",sourceVersion:"3.1.1",opration:"修改  版本管理"},
    {id:"3",clientType:"android正常版",status:"开",destVersion:"3.2.1",sourceVersion:"3.1.1",opration:"修改  版本管理"};
  ]