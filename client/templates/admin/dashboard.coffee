Template.AdminDashboard.events
  "click [data-action]": (event)->
    Router.go "/#{$(event.currentTarget).data('action')}"
