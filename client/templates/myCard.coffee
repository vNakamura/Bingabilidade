Template.myCard.helpers
  'currentCard': ->
    Cards.findOne()
  'currentRound': ->
    Rounds.findOne
      finished: no
    ,
      sort:
        createdAt: -1
  'currentCardRound': ->
    card = Cards.findOne()
    card.round
  'currentCardIsOk': ->
    card = Cards.findOne {},
      fields:
        round_id: 1
    round = Rounds.findOne
      finished: no
    ,
      fields:
        _id: 1
      sort:
        createdAt: -1
    card and round and (card?.round_id is round?._id)

Template.cardView.helpers
  'currentCard': ->
    Cards.findOne()

Template.cardTable.helpers
  'cardSquaresTable': (square_ids)->
    if square_ids
      rows = []
      row = []
      for sq, i in square_ids
        if (i isnt 0) and (i%5 is 0)
          rows.push row
          row = []
        sq.index = i
        row.push sq
      rows.push row
      return rows
  'square': (_id)->
    Squares.findOne
      _id: _id
  'squareClass': ->
    if @._id
      c = "checkable "
      if @.checked
        c += "checked"
    else
      c = "centerSquare"
    c

Template.myCard.events
  'click .generateCard': ->
    round = Rounds.findOne
      finished: no
    ,
      fields:
        _id: 1
      sort:
        createdAt: -1
    Meteor.call 'generateCard', round._id, (err, card_id)->
      throw err if(err)

      if card_id
        Session.setPersistent 'currentAnonymousCard', card_id

  'click table.clickable td.checkable': ()->
    c = !@.checked
    modifier = {}
    modifier["square_ids.#{@index}.checked"] = c
    Cards.update
      _id: Cards.findOne()._id
    ,
      $set: modifier
