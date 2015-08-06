require './style'

angular.module 'components'

.factory 'Alert', ($rootScope, $timeout)->
  $rootScope.alerts = []
  $rootScope.alert_timers = []

  add: (message)->
    alert =
      type: message.type
      msg: message.msg
      keep: message.keep || false
      index: $rootScope.alerts.length
      close: (alert, $event)->
        target = angular.element($event.target)
        if target.parents('.alert-bar').length > 0
          target = target.parents('.alert-bar')
        target.animate left: '-' + target.width() + 'px', 1000, 'linear'
        if !alert.keep
          #取消自动关闭事件
          $timeout.cancel($rootScope.alert_timers[alert.index])
          $timeout ->
            $rootScope.alerts.splice(alert.index, 1)
          , 1000

    $rootScope.alerts.push(alert)

.directive 'alertBar', ($rootScope, $timeout)->
  restrict: 'E'
  template: require './template'
  replace: true
  scope:
    alert: '=alert'
  link: (scope, element, attrs) ->
    target = angular.element(element)
    target.css left: '-' + target.width() + 'px', display: 'block'
    target.animate left: 0, 1000, 'linear'

    $rootScope.alert_timers[alert.index] =
      $timeout ->
        scope.alert.close scope.alert, target: element
      , 3000

#    $rootScope.alert_timers[alert.index].then ->
#      console.log 'resolve'
#    ,->
#      console.log 'rejected'