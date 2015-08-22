Template.mainMenu.helpers
  profileUser: () ->
    Meteor.users.findOne(
      Meteor.userId()
    )

Template.mainMenu.events
  "click [data-action]": (event)->
    $("paper-drawer-panel")[0].closeDrawer()
    Router.go "/#{$(event.currentTarget).data('action')}"
