require './style'

angular.module 'layouts', []
#LayoutController
.controller 'HeaderCtrl', ($scope)->
  $scope.name = 'This is header'

.controller 'SidebarCtrl', ($scope,$route, $location)->
  $scope.url = $location.url()
  $scope.menus = [
    {icon: 'dashboard', name: '控制台', url: '/'},
    {
      icon: 'edit', name: '表单',
      submenus: [
        {name: '控制台', url: '/errors/1'}
      ]
    },
    {
      icon: 'desktop', name: '界面'
      submenus: [
        {name: '控制台', url: '/errors/2'},
        {name: '控制台', url: '/errors/3'}
      ]
    }
  ]

  #解析url
  if $scope.menus && $scope.menus.length > 0
    for menu in $scope.menus
      if menu.url && menu.url == $scope.url
        menu.active = true
        break
      if menu.submenus && menu.submenus.length > 0
        for submenu in menu.submenus
          if submenu.url == $scope.url
            submenu.active = true
            menu.active = true
            break

  $scope.toggleSubmenus = ($event)->
    target = angular.element($event.target)
    parent = target.parent()
    siblings = parent.siblings('li')

    siblings.find('.submenu').slideUp('slow')
    siblings.removeClass('active open')

    parent.addClass('active open')
    target.siblings('.submenu').slideDown('slow')

    false

  $scope.activeSubmenus=($event)->
    target = angular.element($event.target)
    parent = target.parent()
    siblings = parent.siblings('li')

    siblings.removeClass('active')
    parent.parents('ul.nav-list>li').siblings().find('.submenu>li.active').removeClass('active')
    parent.addClass('active')

    false
.controller 'FooterCtrl', ($scope)->
  $scope.name = 'This is footer'