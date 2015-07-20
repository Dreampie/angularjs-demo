require './style'

angular.module 'components', ['ngAnimate']

.directive 'backTop', ($window)->
  restrict: 'E'
  template: require './template'
  replace: true
  link: (scope, element, attrs) ->
    #scroll event
    angular.element($window).bind 'scroll', ->
      if angular.element($window).scrollTop() > 100
        angular.element(element).fadeIn 200
      else
        angular.element(element).fadeOut 200

    #click event
    element.on 'click', (evt) ->
      angular.element('body,html').animate scrollTop: 0, 800,'linear'
