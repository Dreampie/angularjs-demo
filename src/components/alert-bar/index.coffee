require './style'

angular.module 'components'

.factory 'Alert', ($rootScope, $timeout)->
  $rootScope.alerts = []

  add: (message)->
    alert =
      type: message.type
      msg: message.msg
      keep: message.keep || false
      close: (alert, $event)->
        target = angular.element($event.target)
        if target.parents('.alert-bar').length > 0
          target = target.parents('.alert-bar')
        target.animate left: '-' + target.width() + 'px', 1000, 'linear'
        index = $rootScope.alerts.indexOf(alert)
        if !alert.keep
          $timeout ->
            $rootScope.alerts.splice(index, 1)
          , 1200

    $rootScope.alerts.push(alert)

.directive 'alertBar', ($timeout)->
  restrict: 'E'
  template: require './template'
  replace: true
  scope:
    alert: '=alert'
  link: (scope, element, attrs) ->
    target = angular.element(element)
    target.css left: '-' + target.width() + 'px', display: 'block'
    target.animate left: 0, 1000, 'linear'
    $timeout ->
      scope.alert.close scope.alert, target: element
    , 5000
