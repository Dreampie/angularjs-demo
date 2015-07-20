require './style'

angular.module 'layout', []
#LayoutController
.controller 'HeaderCtrl', ($scope)->
  $scope.name = 'This is header'

.controller 'SidebarCtrl', ($scope)->
  $scope.menus = [
    {icon: 'dashboard', name: '控制台', url: ''},
    {
      icon: 'edit', name: '表单',
      submenus: [
        {name: '控制台', url: ''}
      ]
    },
    {
      icon: 'desktop', name: '界面',
      submenus: [
        {name: '控制台', url: ''}
      ]
    }
  ]

  console.log angular.element('.nav-list .dropdown-toggle').length
  angular.element('.nav-list .dropdown-toggle').click ->
    angular.element(this).siblings('.submenu').slideToggle('slow')

.controller 'FooterCtrl', ($scope)->
  $scope.name = 'This is footer'