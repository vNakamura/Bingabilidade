Meteor.publish null, ()->
  Meteor.users.find(
    "status.online":true
  ,
    fields:
      profile: 1
      "services.google.picture": 1
      "services.twitch.logo": 1
  )

Meteor.publish null, ()->
  GlobalSettings.find()

Meteor.publish 'columns', ()->
  Columns.find()
Meteor.publish 'numbers', ()->
  Numbers.find()
Meteor.publish 'squares', ->
  Squares.find()
Meteor.publish 'rounds', ->
  Counts.publish @,
  'squaresTotal',
  Squares.find({removed:no}),
    noReady: true
  Rounds.find()

Meteor.startup ()->
  Inject.rawModHtml 'addUnresolved', (html) ->
    html = html.replace '<body>', '<body unresolved class="fullbleed layout vertical">'
  Inject.rawBody 'addNoScript', '<noscript>Este site requer javascript.</noscript>'
