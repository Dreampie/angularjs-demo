'use strict'

NProgress = require 'nprogress'
NProgress.configure trickle: false
NProgress.start()

require './app'

#angular
require 'angular'
require 'angular-route'
require 'angular-resource'
require 'angular-animate'

#component
require './components/back-top'
require './components/breadcrumb'
require './components/alert-bar'
require './components/permission'
#view
require './layouts'
require './views/home'
require './views/error'

angular.module 'app', ['ngRoute', 'ngAnimate']

#config
.config ($routeProvider, $locationProvider, $httpProvider) ->
#use the HTML5 History API
  $locationProvider.html5Mode(true)
  $httpProvider.defaults.timeout = 500
  #异常过滤
  $httpProvider.interceptors.push ($rootScope, $q, $location,Alert) ->
    request: (config)->
      NProgress.start()
      config

    requestError: (request)->
      NProgress.done()
      Alert.add type:'danger',msg:'网络错误'
      $q.reject(request)

    response: (response)->
      NProgress.done()
      response

    responseError: (response) ->
      NProgress.done()
      Alert.add type:'danger',msg:'网络错误'
      #      switch response.status
      #        when 401 then $location.path '/'
      #        when 404 then $location.path '/errors/404'
      #        when 500 then $location.path '/errors/500'
      $q.reject(response)

  $routeProvider
  .when '/',
    template: require './views/home/template'
    controller: 'HomeCtrl'
  .when '/errors/:code',
    template: require './views/error/template'
    controller: 'ErrorCtrl'
  .otherwise
      redirectTo: '/'

.run ($rootScope, $location, $templateCache, Alert, Permission) ->
  $rootScope.path = $location.path()

  $rootScope.$on '$routeChangeStart', (event, next, current) ->
    if !Permission.match('GET', next.originalPath)
      if Permission.authed()
        Alert.add type: 'danger', msg: '您没有权限访问该路径'
        $location.path('/errors/403')
      else
        Alert.add type: 'danger', msg: '您还没有登录'
        $location.path('/')

  $rootScope.$on '$routeChangeSuccess', (event, next) ->
    angular.element('body,html').animate scrollTop: 0, 1000, 'linear'
    $rootScope.path = $location.path()
  #    Alert.add type: 'info', msg: '路由跳转成功'

  $rootScope.$on '$routeChangeError', (event, next) ->
    console.log '$routeChangeError'
    Alert.add type: 'danger', msg: '路由跳转错误'

  $templateCache.put 'header.tpl.html', require './layouts/header.tpl.html'
  $templateCache.put 'footer.tpl.html', require './layouts/footer.tpl.html'
  $templateCache.put 'sidebar.tpl.html', require './layouts/sidebar.tpl.html'

#bootstrap
angular.element(document).ready ->
  angular.bootstrap(document, ['app', 'layouts', 'views', 'components'])
  NProgress.done()