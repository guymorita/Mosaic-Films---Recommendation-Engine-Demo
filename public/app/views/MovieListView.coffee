class window.MovieListView extends Backbone.View

  template:
    '<div>
    <h2>Mosaic Films</h2>
    <tbody>
      <table class="table table-hover">
      </table>
    </tbody></div>'

  initialize: ->
    @render()

  events:
    "click .btn": (e) ->
      @newRating(e.currentTarget.id, e.currentTarget.classList[0])
      @$('#'+e.currentTarget.id).hide('slow')

  newRating: (id, like) ->
    @trigger 'newRating', {id: id, like:like}

  render: ->
    @$el.append @template
    for index, movie of _.shuffle(@model.userObj.allMovies)
      @$('.table').append '<tr id="'+movie._id+'"><td>
        '+movie.name+'</td>
        <td>
        <button type="button" class="liked btn btn-success btn-mini" id="'+movie._id+'">Like</button>
        <button type="button" class="disliked btn btn-danger btn-mini" id="'+movie._id+'">Dislike</button>
        </td>
        </tr>'
