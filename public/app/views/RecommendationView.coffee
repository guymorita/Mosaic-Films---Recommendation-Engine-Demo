class window.RecommendationView extends Backbone.View

  template: '
      <div>
      <a class="tip" data-toggle="tooltip" data-placement="right" title="Rate some movies and we&#39;ll provide you with recommendations from similar users!">
      <h2>Your Recommendations</h2>
      </a>
      <div id="container">
      </div>
      </div>
      '
  topUsersTemplate:
    '<div class="topUsers">
    </div>'

  topRatedTemplate:
    '<div class="topRated">
    </div>'

  loadingTemplate:
    '<div class="loading">
      <i class="icon-spinner icon-spin icon-large"></i> please enter more ratings...
    </div>'

  initialize: ->
    setTimeout ->
      @$('.tip').tooltip({placement: 'left'}).tooltip('show')
    , 1000
    @oldMovies
    @initial = false
    @$el.append @template
    @$el.append @loadingTemplate
    @$('#container').isotope({
      itemSelector : '.element',
      animationEngine: 'jquery'
    })
    setTimeout( ->
      @$('#container').isotope('reLayout')
    , 100 )

  events:
    "click .element": (e) ->
      # if e.currentTarget.classList[1] is "user"
      # console.log('e', e)
      # console.log('e.currenttarget', e.currentTarget)
      # _(@model.get('movieModal')).extend({movieId: e.currentTarget.id, userObj: @userObj})
      # @movieModal = new MovieModalView(model: @model.get('movieModal'))
      # console.log('movie modal', @model.get('movieModal'))
      # debugger
      # $('body').append @movieModal.el
      # console.log('recommendation element clicked')

  handleRating: (ratingObject) ->
    _(@model).extend({idFetch: ratingObject.id, likeFetch: ratingObject.like})
    @model.fetch(
      error: (model, response) =>
        console.log('error model', model)
      success: (model, response) =>
        if @initial is false
          @handleFirstRating()
          @initial = true
        console.log('success res', response)
        @render(response)
    )

  handleFirstRating: ->
    @initialRender()
    @$('.loading').hide('slow')
    setTimeout( ->
      @$('.tip').tooltip('hide')
    , 1000)

  initialRender: ->
    @$el.append @topUsersTemplate
    @topUsersView = new TopUsersView(model: @model)
    @$('.topUsers').html @topUsersView.el
    @$el.append @topRatedTemplate
    @topRatedView = new TopRatedView(model: @model)
    @$('.topRated').html @topRatedView.el

  render: (res) ->
    @topUsersView.reRender(res)
    @topRatedView.translateRes(res)
    moviesToAdd = _.difference(res.recommendations, @oldMovies)
    moviesToRemove = _.difference(@oldMovies, res.recommendations)
    @oldMovies = res.recommendations
    @$('#container').isotope( 'shuffle')
    for index, movieid of moviesToAdd
      newMovie = $('<div id="'+movieid+'" class="element sprites '+(@model.userObj.movieLookup[movieid]).replace(/\s+/g, '').toLowerCase()+'">'+@model.userObj.movieLookup[movieid]+'</div>')
      @$('#container').isotope('insert', newMovie)
    for index, movieid of moviesToRemove
      removeMovie = @$('.'+(@model.userObj.movieLookup[movieid]).replace(/\s+/g, '').toLowerCase())
      @$('#container').isotope('remove', removeMovie)
    @$('#container').isotope( 'shuffle')
