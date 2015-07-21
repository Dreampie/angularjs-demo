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

#view
require './layouts'
require './views/home'
require './views/error'
require './views/forceversion'
#component
require './components/back-top'
require './components/breadcrumb'
require './components/alert-bar'

angular.module 'app', ['ngRoute', 'ngAnimate']

#config
.config ($routeProvider, $locationProvider, $httpProvider) ->
#use the HTML5 History API
  $locationProvider.html5Mode(true)
  #异常过滤
  $httpProvider.interceptors.push ($rootScope, $q, $location) ->
    request: (config)->
      NProgress.start()
      config

    response: (response)->
      NProgress.done()
      response

  #    responseError: (response) ->
  #      switch response.status
  #        when 401 then $location.path '/'
  #        when 404 then $location.path '/errors/404'
  #        when 500 then $location.path '/errors/500'
  #      $q.reject(response)

  $routeProvider
  .when '/',
    template: require './views/home/template'
    controller: 'HomeCtrl'
  .when '/errors/:code',
    template: require './views/error/template'
    controller: 'ErrorCtrl'
  .when '/version',
      template: require './views/forceversion/forceVersionList'
      controller: 'ErrorCtrl'
  .otherwise
      redirectTo: '/'

.run ($rootScope, $location, $templateCache,Alert) ->
  $rootScope.path = $location.path()

  $rootScope.$on '$routeChangeStart', (e, target) ->
    console.log '$routeChangeStart'

  $rootScope.$on '$routeChangeSuccess', (e, target) ->
    angular.element('body,html').animate scrollTop: 0, 1000, 'linear'
    $rootScope.path = $location.path()
    Alert.add  type: 'warning', msg: '测试', keep: false

  $rootScope.$on '$routeChangeError', (e, target) ->
    console.log '$routeChangeError'

  $templateCache.put 'header.tpl.html', require './layouts/header.tpl.html'
  $templateCache.put 'footer.tpl.html', require './layouts/footer.tpl.html'
  $templateCache.put 'sidebar.tpl.html', require './layouts/sidebar.tpl.html'

#bootstrap
angular.element(document).ready ->
  angular.bootstrap(document, ['app', 'layouts', 'views', 'components'])
  NProgress.done()