# Global Subscriptions
Meteor.publish null, ->
  GlobalSettings.find()


# Page Specific Subscriptions
Meteor.publish 'currentRound', ->
  Rounds.find
    finished: no
  ,
    sort:
      createdAt: -1
    limit: 1

Meteor.publishComposite 'myLastCard', (anonCard)->
  {
    find: ->
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
    children: [
      find: (card)->
        Meteor.users.find
          _id: card.owner_id
        ,
          fields:
            profile: 1
            "services.google.picture": 1
            "services.twitch.logo": 1
    ,
      find: (card)->
        Rounds.find
          _id: card.round_id
        ,
          limit: 1
    ]
  }



Meteor.publishComposite 'card', (card_id)->
  {
    find: ->
      Cards.find
        _id: card_id
      ,
        limit: 1
    children: [
      find: (card)->
        Meteor.users.find
          _id: card.owner_id
        ,
          fields:
            profile: 1
            "services.google.picture": 1
            "services.twitch.logo": 1
          limit: 1
    ,
      find: (card)->
        Rounds.find
          _id: card.round_id
        ,
          limit: 1
    ]
  }

Meteor.publishComposite 'playing', ->
  {
    find: ->
      Rounds.find
        finished: no
      ,
        sort:
          createdAt: -1
        limit: 1
    children: [
      find: (round)->
        Cards.find
          round_id: round._id
          owner_id:
            $ne: null
      children: [
        find: (card)->
          Meteor.users.find
            _id: card.owner_id
          ,
            fields:
              profile: 1
              "services.google.picture": 1
              "services.twitch.logo": 1
      ]
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
