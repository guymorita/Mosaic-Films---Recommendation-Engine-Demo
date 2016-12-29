class window.AppView extends Backbone.View

  loginTemplate:
    '<div class="loginpage">
    </div>'

  recommendationTemplate:
    '<div class="container-fluid">
      <div class="row">
        <div id="sidebar" class="col-6 col-lg-4">
          sidebar
          testing
        </div>
        <div id="main" class="col-6 col-lg-8">
        body
        testing
        </div>
      </div>
      <div class="rlink" id="powered"><a href="https://github.com/guymorita/recommendationRaccoon" target="_blank">Powered by recommendationRaccoon (Node.js Module)</a></div>
    </div>'

  initialize: ->
    @render()
    @loginView.on 'userInfoReceived', (userObject) =>
      @$el.html ''
      movieHash = {}
      for index, movie of userObject.allMovies
        movieHash[movie.id] = movie.name
      userHash = {}
      for index, user of userObject.allUsers
        userHash[user.id] = user.name
      userObject['movieLookup'] = movieHash
      userObject['userLookup'] = userHash
      _(@model.get('movieList')).extend({userObj: userObject})
      _(@model.get('recommendationList')).extend({userObj: userObject})
      @$el.append @recommendationTemplate
      @movieView = new MovieListView(model: @model.get 'movieList')
      @$('#sidebar').html @movieView.el
      @recommendationView = new RecommendationView(model: @model.get 'recommendationList')
      @$('#main').html @recommendationView.el
      @movieView.on 'newRating', (ratingObject) =>
        @recommendationView.handleRating(ratingObject)

  render: ->
    @$el.append @loginTemplate
    @loginView = new LoginView(model: @model.get 'loginInfo')
    @$('.loginpage').html @loginView.el
