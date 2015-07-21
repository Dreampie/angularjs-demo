require './style'

angular.module 'components'

.directive 'alertBar', ()->
  restrict: 'E'
  template: require './template'
  replace: true
  link: (scope, element, attrs) ->
    element.on 'click', (evt) ->
      angular.element(element).animate left: '-' + angular.element(element).width(), 1000, 'linear'
      false