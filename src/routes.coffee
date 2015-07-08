'use strict'

module.exports =
  '/hotwords':
    component: require './view/hotword'
  '*':
    component: require './view/notfound'