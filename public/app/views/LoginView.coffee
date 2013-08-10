class window.LoginView extends Backbone.View

  template:
    '<div class="row" style="margin-top:100px;">
      <div class="col-lg-4"></div>
      <div class="col-lg-4">
        <h1 class="coverheader">Mosaic Films</h1>
        <blockquote style="font-size: 1.5em;"><em>instant</em> movie recommendations from people like you!</blockquote>
        <h1></h1>
        <div class="well">
          <div class="input-group">
            <input type="text" class="form-control" placeholder="enter a new or existing username">
            <span class="input-group-btn">
              <button id="submitButton" class="btn btn-default" type="button">Go</button>
              </a>
            </span>
          </div>
        </div>
        <div class="col-lg-4"></div>
      </div>
    </div>
    <div class="row" style="margin-top:50px;">
      <div class="col-lg-2"></div>
      <div class="col-lg-8">
        <div class="row">
          <div class="col-lg-3">
            <div class="coversprites fimage cover1">
              <div class="coverlayer">
              <p class="covertext ct1">
                <i class="icon-edit"></i> Enter a Username
                </p>
                </div>
              </div>
          </div>
          <div class="col-lg-3">
            <div class="coversprites fimage cover2">
              <div class="coverlayer">
              <p class="covertext ct2">
                <i class="icon-check-sign"></i> Rate some movies!
              </p>
              </div>
            </div>
          </div>
          <div class="col-lg-3">
            <div class="coversprites fimage cover4">
              <div class="coverlayer">
              <p class="covertext ct3">
              <i class="icon-group"></i> See similar users
              </p>
              </div>
              </div>
          </div>
          <div class="col-lg-3">
            <div class="coversprites fimage cover3">
              <div class="coverlayer">
              <p class="covertext ct4">
                <i class="icon-film"></i> Get movie recommendations from similar users
              </p>
              </div>
              </div>
          </div>
        </div>
      </div>
      <div class="col-lg-2"></div>
    </div>'

  initialize: ->
    @render()
    $(document).ready ->
      mosimg = new Image()
      mosimg.src = "/img/moviecollage2.png"

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
