class window.MovieListView extends Backbone.View

  template: '
      <div class="input-group">
        <input type="text" class="form-control" placeholder="name">
      </div>
      <tbody>
      <table class="table table-hover">
      </table>
      </tbody>
      <button id="submitButton" type="submit" class="btn btn-primary">See Recommendations</button>
      '

  initialize: ->
    @model.fetch({
      success: (collection, response, options) =>
        @render(response)
      })

  events:
    "click #submitButton": 'newUser'

  toggle: ->
    if @$el.is(':visible')
      @$el.hide()
      this.trigger('collapse')
    else
      @$el.show()
      this.trigger('expand')

  newUser: ->
    newRatings = {}
    @$('select').each (value, key) ->
      newRatings[key.id] = key.value
    user = new newUser({
      name: @$('input').val(),
      movies: newRatings
      })
    user.save({}, {
      wait: true
      error: (model, response) =>
        console.log('error model', model)
      success: (model, response) =>
        console.log('success model', model)
        @toggle()
        @userCreated()
    })

  userCreated: ->
    @trigger 'userCreated'

  render: (res) ->
    @$el.append @template
    for index, movie of res
      @$('.table').append '<tr><td>
        '+movie+'</td>
        <td>
        <select class="form-control input-small" id="'+index+'">
          <option></option>
          <option>1</option>
          <option>2</option>
          <option>3</option>
          <option>4</option>
          <option>5</option>
        </select>
        </td>
        </tr>'
