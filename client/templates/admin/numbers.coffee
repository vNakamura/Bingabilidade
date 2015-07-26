Meteor.subscribe 'columns'
Meteor.subscribe 'numbers'

Template.Numbers.helpers
  'columns' : ()->
    Columns.find()
  'numbers' : (columnId)->
    Numbers.find({column_id: columnId})

Template.Numbers.events
  'change paper-checkbox': (event)->
    Meteor.call 'enableNumber', @._id, event.target.checked, (err, result)->
      if err
        Alert.error err.message
        event.target.checked = @.enabled
