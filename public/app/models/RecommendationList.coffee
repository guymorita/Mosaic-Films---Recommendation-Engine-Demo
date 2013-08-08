class window.RecommendationList extends Backbone.Model

  url: ->
    "/newRating/?:userId=" + @userObj.userId + "&movie[id]=" + @idFetch + "&movie[like]=" + @likeFetch

  initialize: ->
    @set 'movieModal', movieModal = new MovieModal()

  render: ->
