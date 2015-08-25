Template.playing.helpers
  'currentRound': ->
    Rounds.findOne()
  'roundCards': ->
    Cards.find()

Template.avatarAndName.helpers
  'getUser': (_id)->
    Meteor.users.findOne
      _id: _id

Template.playing.events
  'click paper-button': ->
    Router.go "/!#{@._id}"
