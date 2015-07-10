'use strict'

NProgress = require 'nprogress'
NProgress.configure trickle: false
NProgress.start()

require './app'

Vue = require 'vue'
VueRouter = require 'vue-router'

Vue.use VueRouter

router = new VueRouter history: true
#define routes
router.map require './routes'

#VueResource = require 'vue-resource'
#Vue.use VueResource

# global before
# you can perform async rejection here
router.beforeEach (to, from, allow, deny)->
  console.log "before : " + to.path + "," + from.path

# global after
router.afterEach (to, from)->
  console.log "after : " + to.path + "," + from.path


App = Vue.extend
  components:
    'app-header': require './component/header'
    'app-sidebar': require './component/sidebar'
  data: ->
    'menus': [
      {'name': '热词', 'icon': 'glyphicon glyphicon-header', 'url': '/hotwords'},
      {'name': '热词', 'icon': 'glyphicon glyphicon-header', 'url': '/a'}
    ]
    'tabs': []
  events:
    'init-view': (data)->
      this.$set 'tabs', data.tabs

router.start App, '#app'
# just for debugging
window.router = router

$ = require 'jquery'

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