class window.RecommendationView extends Backbone.View

  template: '
      <div>
      <div id="container">
      </div>
      <tbody>
      <table class="table table-hover">
      </table>
      </tbody>
      </div>
      '

  initialize: ->
    @oldMovies
    @$el.append @template
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

  render: (res) ->
    console.log(res)
    moviesToAdd = _.difference(res, @oldMovies)
    moviesToRemove = _.difference(@oldMovies, res)
    @oldMovies = res
    for index, movieid of moviesToAdd
      newMovie = $('<div class="element sprites '+(@model.userObj.movieLookup[movieid]).replace(/\s+/g, '').toLowerCase()+'">'+@model.userObj.movieLookup[movieid]+'</div>')
      @$('#container').isotope('insert', newMovie)
    for index, movieid of moviesToRemove
      removeMovie = @$('.'+(@model.userObj.movieLookup[movieid]).replace(/\s+/g, '').toLowerCase())
      @$('#container').isotope('remove', removeMovie)