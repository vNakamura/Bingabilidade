accountsUIBootstrap3.setLanguage('pt-BR');
T9n.setLanguage 'pt'

Meteor.subscribe 'users'

Template.userList.helpers
  onlineUsers: () ->
    Meteor.users.find()

Meteor.subscribe "globalSettings"

Template.AdminSetup.helpers
  adminExists: () ->
    # console.log @GlobalSettings.find().fetch()
    # .setupStep == 0
    true
