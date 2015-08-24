Migrations.add
  # Popula collection Squares com elementos da antiga collection Numbers
  version: 1
  up: ->
    Numbers = new Mongo.Collection "numbers"
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

Migrations.add
  # Limpa conteúdo das collection Columns e Numbers que foram substituidas pela collection Squares
  version: 3
  up: ->
    Columns = new Mongo.Collection "columns"
    Numbers = new Mongo.Collection "numbers"
    Columns.remove {}
    Numbers.remove {}

  down: ->
    console.log 'Não é possível retornar o conteúdo das collections excluídas'
    return

Migrations.migrateTo 'latest'
