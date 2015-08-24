# Global Subscriptions
Meteor.publish null, ->
  GlobalSettings.find()



# Page Specific Subscriptions
Meteor.publish 'onlineUsers', ->
  Meteor.users.find
    "status.online":true
  ,
    fields:
      profile: 1
      "services.google.picture": 1
      "services.twitch.logo": 1

Meteor.publish 'currentRound', ->
  Rounds.find
    finished: no
  ,
    sort:
      createdAt: -1
    limit: 1

Meteor.publish 'myLastCard', (anonCard)->
  if @userId
    return Cards.find
      owner_id: @userId
    ,
      sort:
        createdAt: -1
      limit: 1
  else if anonCard
    return Cards.find
      _id: anonCard
    ,
      sort:
        createdAt: -1
      limit: 1
  else
    return null


Meteor.publishComposite 'card', (card_id)->
  {
    find: ->
      Cards.find
        _id: card_id
      ,
        limit: 1
    children: [
      find: (card)->
        Rounds.find
          _id: card.round_id
        ,
          limit: 1
    ]
  }



# Admin Subscriptions
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
