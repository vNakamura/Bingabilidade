Template.Squares.helpers
  'squares': ->
    Squares.find {removed:no}, {sort:{createdAt:-1}}

Template.Squares.events
  'click .edit-btn': ()->
    Session.set 'currentSquare', @
    $('#edit-dialog').get(0).open()
  'click paper-fab': ()->
    Session.set 'currentSquare', new Square()
    $('#edit-dialog').get(0).open()
  'click .remove-btn': ()->
    if window.confirm "Excluir o item \"#{@.title}\"?"
      @.softRemove()
      showToast 'Item removido.'

Template.SquareEdit.helpers
  'selected': ()->
    Session.get 'currentSquare'

Template.SquareEdit.events
  'click paper-button[dialog-confirm]': ()->
    isNew = @._isNew
    @.title = $('#square-edit-title').val()
    @.description = $('#square-edit-description').val()
    if @.validate()
      @.save()
      if isNew
        showToast 'Novo item adicionado.'
      else
        showToast 'Item atualizado.'
    else
      errors = []
      for key, value of @.getValidationErrors()
        errors.push value
      showToast errors.join('<br>')
    Session.set "currentSquare", null
