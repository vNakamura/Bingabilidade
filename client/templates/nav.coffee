Template.mainMenu.helpers
  profileUser: () ->
    Meteor.users.findOne(
      Meteor.userId()
    )

Template.mainMenu.events
  "click [data-action=admin]": ()->
    Router.go '/admin'
  "click [data-action=sign-out]": ()->
    Router.go '/sign-out'
  "click [data-action=wtf]": ()->
    Router.go '/wtf'
