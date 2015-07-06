T9n.setLanguage 'pt'

Meteor.subscribe 'users'

Template.registerHelper 'headerTitle', ()->
  if Router.current().route.options.headerTitle
    Router.current().route.options.headerTitle
  else
    Router.current().route.options.subTitle


Template.defaultLayout.events
  "click #logo": ()->
    Router.go '/'

Template.mainMenu.events
  "click #toAdmin": ()->
    Router.go '/admin'
  "click #toSignOut": ()->
    Router.go '/sign-out'

Template.userList.helpers
  onlineUsers: () ->
    Meteor.users.find()

Template.AdminSetup.helpers
  adminExists: () ->
    # console.log @GlobalSettings.find().fetch()
    # .setupStep == 0
    true
