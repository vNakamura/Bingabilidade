shuffle = (arr, required=arr.length) ->
  randInt = (n) -> Math.floor n * Math.random()
  required = arr.length if required > arr.length
  return arr[randInt(arr.length)] if required <= 1

  for i in [arr.length - 1 .. arr.length - required]
    index = randInt(i+1)
    # Exchange the last unshuffled element with the
    # selected element; reduces algorithm to O(n) time
    [arr[index], arr[i]] = [arr[i], arr[index]]

  # returns only the slice that we shuffled
  arr[arr.length - required ..]

@generateNewCard = (round_id)->

  return card


Meteor.methods
  "generateCard": (round_id, callback)->
    check round_id, String

    card = new Card()
    card._id = ShortId.generate()
    card.round_id = round_id
    allSquares = Squares.find
      removed: no
    ,
      fields:
        _id: yes
      transform: (square)->
        square.checked = no
        square
    shuffledSquares = shuffle allSquares.fetch(), 24
    shuffledSquares.splice 12, 0,
      _id: null
      checked: yes
    card.square_ids = shuffledSquares

    if Meteor.user()
      card.owner_id = Meteor.userId()
      card.save()
      return null
    else
      card.save()
      return card._id
