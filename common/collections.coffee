@GlobalSettings = new Mongo.Collection "GlobalSettings"

@Columns = new Mongo.Collection "columns"
@Numbers = new Mongo.Collection "numbers"

@Squares = new Mongo.Collection "squares"
@Square = Astro.Class
  name: "Square"
  collection: Squares
  behaviors: ['timestamp']
  fields:
    title: 'string'
    description: 'string'
  validators:
    title: Validators.required()
    description: Validators.required()

rules =
  adminOnly: (user_id, context)->
    Roles.userIsInRole(user_id, 'admin')

Squares.allow
  insert: rules.adminOnly
  update: rules.adminOnly
  remove: rules.adminOnly
