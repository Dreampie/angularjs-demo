require './style'

module.exports =
  template: require './template.html'
  ready: ->
    this.$dispatch 'init-view', menus: [
      {'name': '热词', 'icon': 'glyphicon glyphicon-header', 'url': '/hotwords'},
      {'name': '热词', 'icon': 'glyphicon glyphicon-header', 'url': '/a'}
    ],
    tabs: [
      {'name': '热词', 'icon': 'glyphicon glyphicon-header', 'url': '#xx'},
      {'name': '热词', 'icon': 'glyphicon glyphicon-header', 'url': '#xx'}
    ]
