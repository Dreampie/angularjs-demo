require './style'

module.exports =
  template: require './template'
  ready: ->
    this.$dispatch 'init-view',
      tabs: [
        {'name': '热词', 'icon': 'glyphicon glyphicon-header', 'url': '#xx'},
        {'name': '热词', 'icon': 'glyphicon glyphicon-header', 'url': '#xx'}
      ]
