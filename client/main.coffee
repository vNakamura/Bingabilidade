accountsUIBootstrap3.setLanguage('pt-BR');

Meteor.subscribe 'users'

Template.userList.helpers
  onlineUsers: () ->
    Meteor.users.find()
