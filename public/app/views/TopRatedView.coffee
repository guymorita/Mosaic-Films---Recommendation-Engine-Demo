class window.TopRatedView extends Backbone.View

  template: '
      <div>
      <h2>Top Rated</h2>
      <div id="toprated">
      </div>
      </div>
      '

  initialize: ->
    @oldRated
    @$el.append @template
    @$('#toprated').isotope({
      itemSelector : '.element',
      animationEngine: 'jquery'
    })
    setTimeout( ->
      @$('#toprated').isotope('reLayout')
    , 100 )

  translateRes: (res) ->
    @scoreImport = res.bestScores
    @movieArray = []
    @scoreArray = []
    @scoreLength = @scoreImport.length
    for index, value of @scoreImport
      if index%2 is 0
        @movieArray.push(value)
      else
        @scoreArray.push(value)
    @reRender()


  reRender: ->
    topRatedToAdd = _.difference(@movieArray, @oldRated)
    topRatedToRemove = _.difference(@oldRated, @movieArray)
    @oldRated = @movieArray
    for index, movieid of topRatedToAdd
      @movie = @model.userObj.movieLookup[movieid] || 'newMovie'
      newMovie = $('<div class="element sprites '+@movie.replace(/\s+/g, '').toLowerCase()+'">'+@movie+'</br><div class="rating">'+@scoreArray[index].substring(0,4)+'</div></div>')
      @$('#toprated').isotope('insert', newMovie)
    for index, movieid of topRatedToRemove
      @movieRemove = @model.userObj.movieLookup[movieid] || 'newMovie'
      removeMovie = @$('.'+@movieRemove.replace(/\s+/g, '').toLowerCase())
      @$('#toprated').isotope('remove', removeMovie)
    @$('#toprated').isotope({ sortBy : 'rating' });

