Meteor.subscribe 'numbers'
Template.Numbers.helpers
  'columns' : ()->
    Numbers.find()
