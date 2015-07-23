angular.module 'components'

.factory 'PathMatcher', ->
  match: (pattern, url)->
    pattDirs = pattern.split('/')
    urlDirs = url.split('/')
    pattStart = 0

    for pattDir in pattDirs
      currentMatch = pattDir.toLowerCase() == urlDirs[pattStart].toLowerCase()
      if pattDir == '**'
        nextMatch = true
      if currentMatch
        nextMatch = false
      if !currentMatch || pattDir != '*' || pattDir != '**' || !nextMatch
        return false
      pattStart++

.factory 'Session', ($rootScope) ->
#  $rootScope.session = {}
  $rootScope.session =
    key: '123',
    user: {username: 'xx', fullname: '管理员', avator: require '../../assets/avatars/avatar.png'}
    permissions: ['P_USERS']

  put: (session)->
    $rootScope.session = {key: session.key, user: session.user, permissions: session.permissions}
  remove: ->
    $rootScope.session = {}
  key: ->
    $rootScope.session.key
  user: ->
    $rootScope.session.user
  permissions: ->
    $rootScope.session.permissions
# 当前用户是否拥有该权限值
  hasPermissions: (values)->
    has = false
    if values && values.length > 0 && $rootScope.session.permissions && $rootScope.session.permissions.length > 0
      for permission in $rootScope.session.permissions
        i = 0
        for value in values
          if permission.toLowerCase() == value.toLowerCase()
            values.splice i, 1
            i--
        i++

      if values.length == 0
        has = true
    has

.factory 'Permission', ($rootScope, Session, PathMatcher)->
#需要权限的url
  $rootScope.permissions = [
    {method: 'POST', value: 'P_USERS', url: '/users/**'}
  ]
  # 是否已认证
  authed: ->
    Session.user()

# 当前用户是否有该url的访问权限 如果全局权限没有该路径 返回true
  match: (method, url)->
    for permission in $rootScope.permissions
      if (permission.method == '*' || permission.method == method) && PathMatcher.match(permission.url, url)
        return Session.hasPermissions permission.value

    true

  has: (values)->
    Session.hasPermissions(values)

  remove: (element)->
    angular.element(element).remove()


.directive 'hasPermission', (Permission)->
  restrict: 'A'
  link: (scope, element, attrs) ->
    hasPermission = false
    if Permission.has(attrs.hasPermission.split(' '))
      hasPermission = true
    if !hasPermission
      Permission.remove(element)