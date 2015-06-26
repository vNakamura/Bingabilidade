Meteor.startup ()->

Meteor.publish 'users', () ->
  Meteor.users.find
    "status.online":true
  ,
    fields:
      profile: 1
