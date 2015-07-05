Meteor.publish 'users', () ->
  Meteor.users.find
    "status.online":true
  ,
    fields:
      profile: 1

@GlobalSettings = new Mongo.Collection "GlobalSettings"
unless GlobalSettings.findOne()
  GlobalSettings.insert
    setupStep: 0
    gameRunning: false

Meteor.publish "globalSettings", () ->
  GlobalSettings.find()

Meteor.startup ()->
  Inject.rawModHtml 'addUnresolved', (html) ->
    html = html.replace '<body>', '<body unresolved class="fullbleed layout vertical">'
