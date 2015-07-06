Meteor.publish 'users', () ->
  Meteor.users.find
    "status.online":true
  ,
    fields:
      profile: 1

unless GlobalSettings.findOne()
  GlobalSettings.insert
    setupStep: 0
    gameRunning: false

Meteor.publish null, () ->
  GlobalSettings.find()

Meteor.startup ()->
  Inject.rawModHtml 'addUnresolved', (html) ->
    html = html.replace '<body>', '<body unresolved class="fullbleed layout vertical">'
