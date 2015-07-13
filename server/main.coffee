Meteor.publish null, ()->
  Meteor.users.find(
    "status.online":true
  ,
    fields:
      profile: 1
      "services.google.picture": 1
  )

Meteor.publish null, () ->
  GlobalSettings.find()

unless GlobalSettings.findOne()
  GlobalSettings.insert
    setupStep: 0
    gameRunning: false

Meteor.methods
  'become-admin': ()->
    unless @userId
      throw new Meteor.Error "not-logged-in", "Precisa estar logado."
    Roles.addUsersToRoles @userId, 'admin'
    GlobalSettings.update {},
      $set:
        'setupStep': 1

Meteor.startup ()->
  Inject.rawModHtml 'addUnresolved', (html) ->
    html = html.replace '<body>', '<body unresolved class="fullbleed layout vertical">'
  Inject.rawBody 'addNoScript', '<noscript>Este site requer javascript.</noscript>'
