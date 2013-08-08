class window.LoginView extends Backbone.View

  template:
    '<div class="row">
      <div class="col-lg-4"></div>
      <div class="col-lg-4">
        <h1>Mosaic Films</h1>
        <div class="well">
          <div class="input-group">
            <input type="text" class="form-control" placeholder="enter a new or existing username">
            <span class="input-group-btn">
              <button id="submitButton" class="btn btn-default" type="button">Go</button>
            </span>
          </div>
        </div>
        <div class="col-lg-4"></div>
      </div>
    </div>
    <div class="row">
      <div class="col-lg-2"></div>
      <div class="col-lg-8">
        <div class="fimagecontainer">
          <div class="coversprites fimage oldboyy"></div>
          <div class="coversprites fimage timessquare"></div>
          <div class="coversprites fimage dogs"></div>
          <div class="coversprites fimage space"></div>
        </div>
      </div>
      <div class="col-lg-2"></div>
    </div>'

  initialize: ->
    @render()

  events:
    "click #submitButton": 'getUser'
    "keyup :input": 'checkEnter'

  checkEnter: (e) ->
    console.log(e)
    if e.which is 13
      @getUser()

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
