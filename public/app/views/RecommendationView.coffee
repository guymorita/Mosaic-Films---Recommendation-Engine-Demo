class window.RecommendationView extends Backbone.View

  template: '
      <div>
      <tbody>
      <table class="table table-hover">
      </table>
      </tbody>
      </div>
      '

  initialize: ->
    console.log @model.name
    @model.fetch(
      # {data: ':name': @model.name}
      error: (model, response) =>
        console.log('error model', model)
      success: (model, response) =>
        console.log('success model', model)
        console.log('success res', response)
        @render(response)
    )

  render: (res) ->
    @$el.append @template
    @$el.append '<div>rendering</div>'
    for index, movie of res
      @$('.table').append '<tr><td>
        '+Object.keys(movie)[0]+'</td><td>'+movie[Object.keys(movie)[0]]+'</td>
        </tr>'