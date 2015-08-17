Template.Numbers.helpers
  'columns': ->
    Columns.find {}, {sort:{order:1}}
  'numbers': (columnId)->
    Numbers.find {column_id: columnId}, {sort:{number:1}}

Template.Numbers.events
  'change paper-checkbox': (event)->
    Meteor.call 'enableNumber', @._id, event.target.checked, (err, result)->
      if err
        Alert.error err.message
        event.target.checked = @.enabled
  'click .edit-btn': ()->
    Session.set 'currentNumber', @
    $('#edit-dialog').get(0).open()

Template.NumberEdit.helpers
  'selected': ()->
    Session.get 'currentNumber'

Template.NumberEdit.events
  'click paper-button[dialog-confirm]': ()->
    Meteor.call 'editNumber', Session.get('currentNumber')._id, $('#number-edit-title').val(), $('#number-edit-description').val(), (err, result)->
      if err
        Alert.error err.message
        event.target.checked = @.enabled
    Session.set "currentNumber", null
