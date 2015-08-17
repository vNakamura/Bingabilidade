Template.myCard.helpers
  'myCard': ->
    Session.get 'myCard'
  'number': (id)->
    Numbers.find({_id:id})
  'numberClass': ->
    if @.number_id
      c = "checkable "
      if @.checked
        c += "checked"
    else
      c = "centerSquare"
    c

Template.myCard.events
  'click td.checkable': (event)->
    @.checked = !@.checked
    card = Session.get 'myCard'
    for r, i in card.rows
      for n, j in r
        if n.number_id is @.number_id
          card.rows[i][j].checked = @.checked
          break
    Session.setPersistent 'myCard', card
