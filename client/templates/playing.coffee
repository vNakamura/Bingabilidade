Template.playing.helpers
  'currentRound': ->
    Rounds.findOne()
  'roundCards': ->
    Cards.find()

Template.playing.events
  'click paper-button': ->
    Router.go "/card/#{@._id}"
