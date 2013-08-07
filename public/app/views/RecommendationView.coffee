class window.RecommendationView extends Backbone.View

  template: '
      <div>
      <h2>Your Recommendations</h2>
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

  initialize: ->
    @oldMovies
    @$el.append @template
    @initialRender()
    @$('#container').isotope({
      itemSelector : '.element',
      animationEngine: 'jquery'
    })
    setTimeout( ->
      @$('#container').isotope('reLayout')
    , 100 )

  handleRating: (ratingObject) ->
    _(@model).extend({idFetch: ratingObject.id, likeFetch: ratingObject.like})
    @model.fetch(
      error: (model, response) =>
        console.log('error model', model)
      success: (model, response) =>
        console.log('success model', model)
        console.log('success res', response)
        @render(response)
    )
  initialRender: ->
    @$el.append @topUsersTemplate
    @topUsersView = new TopUsersView(model: @model)
    @$('.topUsers').html @topUsersView.el
    @$el.append @topRatedTemplate
    @topRatedView = new TopRatedView(model: @model)
    @$('.topRated').html @topRatedView.el

  render: (res) ->
    console.log(res)
    @topUsersView.reRender(res)
    @topRatedView.translateRes(res)
    moviesToAdd = _.difference(res.recommendations, @oldMovies)
    moviesToRemove = _.difference(@oldMovies, res.recommendations)
    @oldMovies = res.recommendations
    @$('#container').isotope( 'shuffle')
    for index, movieid of moviesToAdd
      newMovie = $('<div class="element sprites '+(@model.userObj.movieLookup[movieid]).replace(/\s+/g, '').toLowerCase()+'">'+@model.userObj.movieLookup[movieid]+'</div>')
      @$('#container').isotope('insert', newMovie)
    for index, movieid of moviesToRemove
      removeMovie = @$('.'+(@model.userObj.movieLookup[movieid]).replace(/\s+/g, '').toLowerCase())
      @$('#container').isotope('remove', removeMovie)
    # topMoviesToAdd = _.difference(res.recommendations, @oldTopMovies)
    # topMoviesToRemove = _.difference(@oldTopMovies, res.recommendations)
    # @oldTopMovies = res.recommendations
    @$('#container').isotope( 'shuffle')
