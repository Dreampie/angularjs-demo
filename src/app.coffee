'use strict'

NProgress = require 'nprogress'
NProgress.configure trickle: false
NProgress.start()

$ = require 'jquery'
require './app'

#angular
require 'angular'
require 'angular-route'
require './layout'
require './view/home'
require './view/error'

angular.module 'app', ['ngRoute']

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
    template: require './view/home/template'
    controller: 'HomeCtrl'
  .when '/errors/:code',
    template: require './view/error/template'
    controller: 'ErrorCtrl'
  .otherwise
      redirectTo: '/'

.run ($rootScope, $location, $templateCache) ->
  $rootScope.path = $location.path()

  $rootScope.$on '$routeChangeStart', (e, target) ->
    console.log '$routeChangeStart'

  $rootScope.$on '$routeChangeSuccess', (e, target) ->
    $('html, body').animate({scrollTop: '0px'}, 400, 'linear')
    $rootScope.path = $location.path()

  $rootScope.$on '$routeChangeError', (e, target) ->
    console.log '$routeChangeError'

  $templateCache.put 'header.tpl.html', require './layout/header.tpl.html'
  $templateCache.put 'footer.tpl.html', require './layout/footer.tpl.html'
  $templateCache.put 'sidebar.tpl.html', require './layout/sidebar.tpl.html'

#bootstrap
angular.element(document).ready ->
  angular.bootstrap(document, ['app', 'layout', 'view'])

$ ->
#scrollup
  $("#back-top").click ->
    $('html,body').animate scrollTop: '0px', 400, 'linear'

  $(window).scroll ->
    if $(window).scrollTop() > 200
      $('#back-top').fadeIn 200
    else
      $('#back-top').fadeOut 200

NProgress.done()