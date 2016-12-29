class window.MovieListView extends Backbone.View

  template:
    '<div>
    <h2>Mosaic Films</h2>
    <div class="scrollBox">
    <tbody>
      <table class="table">
      </table>
    </tbody>
    </div>
    </div>'

  initialize: ->
    @render()
    # @$('.tip').tooltip()
    # setTimeout ->
    #   @$('.tip').tooltip({placement: 'right'}).tooltip('show')
    # , 1000
    # @$('.tip').on('click', ->
    #   @$('.tip').tooltip('destroy')
    # )
    # setTimeout( ->
    #   @$('.tip').tooltip('hide')
    # , 20000)

  events:
    "click .btn": (e) ->
      if e.currentTarget.classList[0] isnt 'notseen'
        @newRating(e.currentTarget.id, e.currentTarget.classList[0])
      @$('#'+e.currentTarget.id).hide('slow')

  newRating: (id, like) ->
    console.log('id', id, like)
    @trigger 'newRating', {id: id, like:like}

  render: ->
    @$el.append @template
    for index, movie of _.shuffle(@model.userObj.allMovies)
      @$('.table').append '<tr id="'+movie.id+'"><td>
        '+movie.name+'</td>
        <td>
        <button type="button" class="liked btn btn-success btn-xs" id="'+movie.id+'"><i class="icon-thumbs-up"></i></button>
        <button type="button" class="disliked btn btn-danger btn-xs" id="'+movie.id+'"><i class="icon-thumbs-down"></i></button>
        <button type="button" class="notseen btn btn-warning btn-xs" id="'+movie.id+'"><i class="icon-chevron-right"></i></button>
        </td>
        </tr>'
