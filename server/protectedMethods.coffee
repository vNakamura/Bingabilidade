Meteor.methods
  "generateCard": ->
    columns = Columns.find({}, {sort:{order:1}}).fetch()
    row = []
    for c in columns
      row.push c.letter
    {headers: row}
