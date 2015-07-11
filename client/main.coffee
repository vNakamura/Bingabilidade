T9n.setLanguage 'pt'

Meteor.subscribe 'users'

Template.registerHelper 'headerTitle', ()->
  if Router.current().route.options.headerTitle
    Router.current().route.options.headerTitle
  else
    Router.current().route.options.subTitle

Template.registerHelper 'GS', ()->
  GlobalSettings.findOne()

Template.registerHelper '_', ()->
  _

Template.defaultLayout.events
  "click [data-action=home]": ()->
    Router.go '/'

Template.mainMenu.events
  "click [data-action=admin]": ()->
    Router.go '/admin'
  "click [data-action=sign-out]": ()->
    Router.go '/sign-out'

Template.userList.helpers
  onlineUsers: () ->
    Meteor.users.find()
