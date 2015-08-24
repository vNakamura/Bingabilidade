rules =
  adminOnly: (user_id)->
    Roles.userIsInRole(user_id, 'admin')

@GlobalSettings = new Mongo.Collection "GlobalSettings"

@User = Astro.Class
  name: 'User'
  collection: Meteor.users
  transform: false
  fields:
    profile: 'object'
    roles: 'array'

@Squares = new Mongo.Collection "squares"
@Square = Astro.Class
  name: "Square"
  collection: Squares
  behaviors: ['timestamp', 'softremove']
  fields:
    title: 'string'
    description: 'string'
  validators:
    title: Validators.required()
    description: Validators.required()
Squares.allow
  insert: rules.adminOnly
  update: rules.adminOnly
  remove: rules.adminOnly

@Rounds = new Mongo.Collection 'rounds'
@Round = Astro.Class
  name: 'Round'
  collection: Rounds
  behaviors: ['timestamp']
  fields:
    name: 'string'
    finished:
      type: 'boolean'
      default: false
  validators:
    name: Validators.required()
Rounds.allow
  update: rules.adminOnly

@Cards = new Mongo.Collection 'cards'
@Card = Astro.Class
  name: 'Card'
  collection: Cards
  behaviors: ['timestamp']
  fields:
    owner_id: 'string'
    round_id: 'string'
    square_ids: 'array'
  relations:
    owner:
      type: 'one'
      class: 'User'
      local: 'owner_id'
      foreign: '_id'
    round:
      type: 'one'
      class: 'Round'
      local: 'round_id'
      foreign: '_id'
  methods:
    squares: ->
      Squares.find
        _id:
          $in:
            this.square_ids
Cards.allow
  update: (user_id, doc)->
    doc.owner_id == user_id
