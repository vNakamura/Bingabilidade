Meteor.subscribe 'columns'
Meteor.subscribe 'numbers'

Template.Numbers.helpers
  'columns': ()->
    Columns.find()
  'numbers': (columnId)->
    Numbers.find({column_id: columnId}, {sort:{number:1}})

Template.Numbers.events
  'change paper-checkbox': (event)->
    Meteor.call 'enableNumber', @._id, event.target.checked, (err, result)->
      if err
        Alert.error err.message
        event.target.checked = @.enabled
  'click .edit-btn': ()->
    Session.set 'currentNumber', @
    # $('#number-edit-title').val(@.title)
    # $('#number-edit-description').val(@.description)
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
