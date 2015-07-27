Meteor.methods
  'become-admin': ()->
    unless @userId
      throw new Meteor.Error "not-logged-in", "Precisa estar logado."
    Roles.addUsersToRoles @userId, 'admin'
    GlobalSettings.update {},
      $set:
        setupStep: 1

  'enableNumber' : (number_id, value)->
    check number_id, String
    check value, Boolean
    loggedInUser = Meteor.user()

    if (!loggedInUser || !Roles.userIsInRole(loggedInUser, 'admin'))
      throw new Meteor.Error(403, "Access denied")
    Numbers.update
      _id: number_id
    ,
      $set:
        enabled: value

  'editNumber' : (number_id, title, description)->
    check number_id, String
    check title, String
    check description, String
    loggedInUser = Meteor.user()

    if (!loggedInUser || !Roles.userIsInRole(loggedInUser, 'admin'))
      throw new Meteor.Error(403, "Access denied")
    Numbers.update
      _id: number_id
    ,
      $set:
        title: title
        description: description
