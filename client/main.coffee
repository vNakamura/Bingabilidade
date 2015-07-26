T9n.setLanguage 'pt'

Template.registerHelper 'headerTitle', ()->
  if Router.current().route.options.headerTitle
    Router.current().route.options.headerTitle
  else
    Router.current().route.options.subTitle

Template.registerHelper 'GS', ()->
  GlobalSettings.findOne()

Template.registerHelper '_', ()->
  _

Template.registerHelper 'ifNull', (value, defaultValue)->
  if value == null || value == undefined
    return defaultValue
  value

Template.defaultLayout.events
  "click [data-action=home]": ()->
    Router.go '/'

Template.userList.helpers
  onlineUsers: () ->
    Meteor.users.find()
