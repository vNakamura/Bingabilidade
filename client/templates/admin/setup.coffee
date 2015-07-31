Template.AdminSetup.events
  "click [data-action=become-admin]": ()->
    Meteor.call 'become-admin'
Template.LoginButton.replaces '_loginButtonsLoggedOutSingleLoginButton'
