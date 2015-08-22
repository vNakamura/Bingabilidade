Migrations.add
  # Popula collection Squares com elementos da antiga collection Numbers
  version: 1
  up: ->
    numbers = Numbers.find
      enabled:true
    ,
      title: 1
      description: 1
      _id: 0

    numbers.forEach (doc)->
      square = new Square()
      square.title = doc.title
      square.description = doc.description
      square.save()

  down: ->
    Numbers.remove {}

Migrations.add
  # Adiciona campos de softremove à collection Squares
  version: 2
  up: ->
    Squares.update {},
      $set:
        removed: no
        removedAt: null
    ,
      multi: yes

  down: ->
    Squares.update {},
      $unset:
        removed: ""
        removedAt: ""
    ,
      multi: yes

Migrations.migrateTo 'latest'
