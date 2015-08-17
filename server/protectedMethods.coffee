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

Meteor.methods
  "generateCard": ->
    card =
      headers: []
      rows: []
    columns = Columns.find({}, {sort:{order:1}}).fetch()
    numbersVertical = []
    for c, i in columns
      card.headers.push c.letter
      columnNumbers = Numbers.find
        column_id: c._id
        enabled: true
      ,
        _id:1
      .fetch()
      if columnNumbers
        if i is 2
          temp = shuffle columnNumbers, 4
          temp.splice 2, 0, {_id:null}
          numbersVertical.push temp
        else
          numbersVertical.push shuffle(columnNumbers, 5)

    for i in [0..4]
      row = []
      for n in numbersVertical
        obj =
          number_id: n[i]._id
          checked: false
        row.push obj
      card.rows.push row

    card
