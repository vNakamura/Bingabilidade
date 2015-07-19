unless GlobalSettings.findOne()
  GlobalSettings.insert
    setupStep: 0
    gameRunning: false

unless Numbers.findOne()
  currentNumber = 1
  for l in ['b', 'i', 'l', 'i', 'd']
    do (l)->
      column =
        letter: l
        numbers: []
      for [0..14]
        do ()->
          column.numbers.push {
            number: currentNumber
          }
          currentNumber++
      Numbers.insert column
