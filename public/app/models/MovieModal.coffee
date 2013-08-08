class window.MovieModal extends Backbone.Model

  url: ->
    "/movieLikes/?:movieId=" + @movieId

  initialize: ->

  render: ->
