Template.AdminRounds.helpers
  'currentRound': ->
    Rounds.findOne
      finished: no
    ,
      sort:
        createdAt: -1
  'roundHistory': ->
    Rounds.find
      finished: yes
    ,
      sort:
        createdAt: -1
  'canStart': ->
    Counts.get('squaresTotal') >= 24

Template.AdminRounds.events
  'keyup paper-input, click #newRoundStart': (event)->
    if event.type is 'keyup' and event.keyCode isnt 13 # Enter Key
      return
    inp = $('#newRoundName')
    Meteor.call 'newRound', inp.val(), (err)->
      if err
        console.error err
      else
        inp.blur().val("")

  'click #currentRoundEnd': ->
    @.finished = yes
    @.save()
