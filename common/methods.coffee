@methodRules =
  isLoggedIn: ->
    unless Meteor.user()
      throw new Meteor.Error "not-logged-in", "Precisa estar logado."
  adminOnly: ->
    loggedInUser = Meteor.user()
    if (not loggedInUser or not Roles.userIsInRole(loggedInUser, 'admin'))
      throw new Meteor.Error(403, "Accesso negado")

Meteor.methods
  'become-admin': ()->
    methodRules.isLoggedIn()
    Roles.addUsersToRoles @userId, 'admin'
    GlobalSettings.update {},
      $set:
        setupStep: 1

  'editSquare' : (square_id, title, description)->
    check square_id, String
    check title, String
    check description, String

    methodRules.adminOnly()

    Squares.update
      _id: square_id
    ,
      $set:
        title: title
        description: description

  'newRound': (name)->
    check name, String

    methodRules.adminOnly()

    round = new Round()
    round.name = name
    if round.validate()
      Rounds.update
        finished: no
      ,
        $set:
          finished: yes
          updatedAt: new Date()
      round.save()
      return
    else
      round.getValidationErrors()
