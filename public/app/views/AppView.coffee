class window.AppView extends Backbone.View

  template:
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
    @movieView.on 'userCreated', =>
      # remove sidebar
      # add main
      alert('user created')

  render: ->
    @$el.append @template
    @movieView = new MovieListView(model: @model.get 'movieList')
    @$('#sidebar').html @movieView.el