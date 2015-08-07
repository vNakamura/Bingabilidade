unless GlobalSettings.findOne()
  GlobalSettings.insert
    setupStep: 0
    gameRunning: false

unless Columns.findOne()
  for l, i in ['b', 'i', 'l', 'i', 'd']
    do (l)->
      column =
        letter: l
        order: i
      Columns.insert column

unless Numbers.findOne()
  currentNumber = 1
  Columns.find().forEach (column)->
    for [0..14]
      do ()->
        number =
          column_id: column._id
          number: currentNumber
          enabled: false
        Numbers.insert number
        currentNumber++
