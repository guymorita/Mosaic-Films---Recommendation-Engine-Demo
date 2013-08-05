class window.AppView extends Backbone.View

  loginTemplate:
    '<div class="panel">
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
    </div>'

  initialize: ->
    @render()
    @loginView.on 'userInfoReceived', (userObject) =>
      @$el.html ''

      # send the list of movies and the movies watched to the sidebar
      # send the recs to the right if there are any.
    #   @$el.append @recommendationTemplate
    #   _(@model.get('recommendationList')).extend({name: username})
    #   @recommendationView = new RecommendationView(model: @model.get 'recommendationList')
    #   @$('#main').html @recommendationView.el

  render: ->
    @$el.append @loginTemplate
    @loginView = new LoginView(model: @model.get 'loginInfo')
    @$('.panel').html @loginView.el
    # @$el.append @sidebarTemplate
    # @movieView = new MovieListView(model: @model.get 'movieList')
    # @$('#sidebar').html @movieView.el