require './style'

angular.module 'components'

.directive 'breadcumb', ($rootScope,$location)->
  restrict: 'E'
  template: require './template'
  replace: true
  link: (scope, element, attrs) ->
    routeDes = [
      {name: '首页', path: '/'},
      {name: '错误', path: '/errors'}
    ]
    # 解析路由和名称
    breadcrumbDes = (path)->
      for des in routeDes
        if des.path == path
          result=des
          break
      result

    data = []
    $rootScope.$on '$routeChangeSuccess', ->
      path = $location.path().trim()
      pathElements = path.split('/') if path != '/'

      result = []
      result.push routeDes[0]
      if pathElements
        # delete first element
        pathElements.shift()
        for i in [0..pathElements.length - 1]
          des = breadcrumbDes '/' + pathElements[i]
          if des
            result.push des

      data = result

    scope.all = ->
      data
    scope.first = ->
      data[0] || {}
