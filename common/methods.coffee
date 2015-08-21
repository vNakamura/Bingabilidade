Meteor.methods
  'become-admin': ()->
    unless @userId
      throw new Meteor.Error "not-logged-in", "Precisa estar logado."
    Roles.addUsersToRoles @userId, 'admin'
    GlobalSettings.update {},
      $set:
        setupStep: 1

  'editSquare' : (square_id, title, description)->
    check square_id, String
    check title, String
    check description, String
    loggedInUser = Meteor.user()

    if (!loggedInUser || !Roles.userIsInRole(loggedInUser, 'admin'))
      throw new Meteor.Error(403, "Access denied")
    Squares.update
      _id: square_id
    ,
      $set:
        title: title
        description: description
