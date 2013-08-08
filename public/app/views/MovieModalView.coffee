class window.MovieModalView extends Backbone.View

  template:
    '<div>
    <h1>appended<h2>
    </div>'

  initialize: ->
    @$el.append @template
    # @modal.fetch(
    #   error: (model, response) ->
    #   success: (model, response) ->
    #     console.log('model', model)
    #     console.log('response', response)
    #     @render(response)
    # )

  render: (res) ->
    # for index, likes of res.likedBy

    # res.dislikedBy