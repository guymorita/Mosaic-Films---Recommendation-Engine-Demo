class window.TopRatedView extends Backbone.View

  template: '
      <div>
      <h2>Most Similar to / Least Similar to</h2>
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
    res.bestScores # array of id's and ratings

  reRender: (res) ->
    console.log(res)
    @$('#toprated').isotope( 'shuffle')
    topRatedToAdd = _.difference(res.bestRated, @oldRated)
    topRatedToRemove = _.difference(@oldRated, res.bestRated)
    @oldRated = res.bestRated
    for index, userid of topRatedToAdd
      @name = @model.userObj.userLookup[userid] || 'newUser'
      newUser = $('<div class="element metalloid '+@name.replace(/\s+/g, '').toLowerCase()+'">'+@name+'</div>')
      @$('#toprated').isotope('insert', newUser)
    for index, userid of topRatedToRemove
      @nameRemove = @model.userObj.userLookup[userid] || 'newUser'
      removeUser = @$('.'+@nameRemove.replace(/\s+/g, '').toLowerCase())
      @$('#toprated').isotope('remove', removeUser)
    # topMoviesToAdd = _.difference(res.recommendations, @oldTopMovies)
    # topMoviesToRemove = _.difference(@oldTopMovies, res.recommendations)
    # @oldTopMovies = res.recommendations
    @$('#toprated').isotope( 'shuffle')

