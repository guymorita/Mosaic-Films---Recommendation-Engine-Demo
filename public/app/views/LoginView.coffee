class window.LoginView extends Backbone.View

  template:
    '<div class="row" style="margin-top:100px;">
      <div class="col-lg-4"></div>
      <div class="col-lg-4">
        <h1>Mosaic Films</h1>
        <blockquote>instant movie recommendations from people like you!</blockquote>
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
            <div class="coversprites fimage oldboyy"></div>
          </div>
          <div class="col-lg-3">
            <div class="coversprites fimage timessquare"></div>
          </div>
          <div class="col-lg-3">
            <div class="coversprites fimage dogs"></div>
          </div>
          <div class="col-lg-3">
            <div class="coversprites fimage space"></div>
          </div>
        </div>
      </div>
      <div class="col-lg-2"></div>
    </div>'

  initialize: ->
    @render()
    setTimeout ->
      @$('.tip').tooltip({placement: 'right', html:true}).tooltip('show')
    , 1000
    @$('.tip').on('click', ->
      @$('.tip').tooltip('destroy')
    )
    # setTimeout( ->
    #   @$('.tip').tooltip('hide')
    # , 20000)

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
