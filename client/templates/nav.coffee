Template.mainMenu.helpers
  profileUser: () ->
    Meteor.users.findOne(
      Meteor.userId()
    )

Template.mainMenu.events
  "click [data-action]": (event)->
    Router.go "/#{$(event.target).data('action')}"
