Meteor.subscribe 'columns'
Meteor.subscribe 'numbers'

Template.Numbers.helpers
  'columns' : ()->
    Columns.find()
  'numbers' : (columnId)->
    Numbers.find({column_id: columnId})
