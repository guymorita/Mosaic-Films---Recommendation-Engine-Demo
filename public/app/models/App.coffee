class window.App extends Backbone.Model

  initialize: ->
    @set 'movieList', movieList = new MovieList()
