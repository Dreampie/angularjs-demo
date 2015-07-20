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
#component
require './components/back-top'

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
  .otherwise
      redirectTo: '/'

.run ($rootScope, $location, $templateCache) ->
  $rootScope.path = $location.path()

  $rootScope.$on '$routeChangeStart', (e, target) ->
    console.log '$routeChangeStart'

  $rootScope.$on '$routeChangeSuccess', (e, target) ->
    angular.element('body,html').animate scrollTop: 0, 800, 'linear'
    $rootScope.path = $location.path()

  $rootScope.$on '$routeChangeError', (e, target) ->
    console.log '$routeChangeError'

  $templateCache.put 'header.tpl.html', require './layouts/header.tpl.html'
  $templateCache.put 'footer.tpl.html', require './layouts/footer.tpl.html'
  $templateCache.put 'sidebar.tpl.html', require './layouts/sidebar.tpl.html'

#bootstrap
angular.element(document).ready ->
  angular.bootstrap(document, ['app', 'layout', 'view', 'component'])

NProgress.done()