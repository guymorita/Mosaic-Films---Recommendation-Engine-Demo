class window.AppView extends Backbone.View

  sidebarTemplate:
    '<div class="container-fluid">
      <div class="row">
        <div id="sidebar" class="col-6 col-lg-4">
          sidebar
          testing
        </div>
      </div>
    </div>'

  recommendationTemplate:
    '<div class="container-fluid">
      <div class="row">
        <div id="main" class="col-6 col-lg-8">
        body
        testing
        </div>
      </div>
    </div>'

  initialize: ->
    @render()
    @movieView.on 'userCreated', (username) =>
      @$el.html ''
      @$el.append @recommendationTemplate
      _(@model.get('recommendationList')).extend({name: username})
      @recommendationView = new RecommendationView(model: @model.get 'recommendationList')
      @$('#main').html @recommendationView.el

  render: ->
    @$el.append @sidebarTemplate
    @movieView = new MovieListView(model: @model.get 'movieList')
    @$('#sidebar').html @movieView.el