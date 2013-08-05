class window.LoginView extends Backbone.View

  template:
    '<div class="panel-heading">
      <h3 class="panel-title">Register or Login</h3>
        <div class="input-group">
          <input type="text" class="form-control" placeholder="name">
          <button id="submitButton" type="submit" class="btn btn-primary">Submit</button>
        </div>
    </div>'

  initialize: ->
    @render()

  events:
    "click #submitButton": 'getUser'

  getUser: ->
    @username = @$('input').val()
    _(@model).extend({name: @username})
    @model.fetch(
      error: (model, response) =>
        console.log('model', model)
      success: (model, response) =>
        # console.log('model', model)
        # console.log('response', response)
        @userInfoReceived(response)
    )

  userInfoReceived: (userObject) ->
    @trigger 'userInfoReceived', userObject

  render: ->
    @$el.append @template