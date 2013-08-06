class window.App extends Backbone.Model

  initialize: ->
    @set 'loginInfo', loginInfo = new LoginInfo()
    @set 'movieList', movieList = new MovieList()
    @set 'recommendationList', recommendationList = new RecommendationList()