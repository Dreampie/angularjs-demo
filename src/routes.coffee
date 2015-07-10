'use strict'

module.exports =
  '/hotwords':
    component: require './view/hotwords'
  '/signin':
    component: require './view/sign_in'
  '*':
    component: require './view/not_found'