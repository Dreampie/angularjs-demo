require './style'

angular.module 'layouts', []
#LayoutController
.controller 'HeaderCtrl', ($scope)->
  $scope.name = 'This is header'

.controller 'SidebarCtrl', ($scope, $route, $location)->
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


    siblings.find('.submenu').stop().slideUp('slow', 'linear')
    siblings.removeClass('open')
    siblings.find('.submenu>li.active').removeClass('active')
    # 有子菜单
    if target.siblings('.submenu').length > 0
      parent.addClass('open')
      target.siblings('.submenu').stop().slideDown('slow', 'linear')
    else
      siblings.removeClass('active open')
      parent.addClass('active')

    false

  $scope.activeSubmenus = ($event)->
    target = angular.element($event.target)
    parent = target.parent()
    siblings = parent.siblings('li')

    siblings.removeClass('active')
    pparent = parent.parents('ul.nav-list>li')
    pparent.siblings().removeClass('active open')
    pparent.siblings().find('.submenu>li.active').removeClass('active')
    parent.addClass('active')
    pparent.addClass('active open')

    false
.controller 'FooterCtrl', ($scope)->
  $scope.name = 'This is footer'