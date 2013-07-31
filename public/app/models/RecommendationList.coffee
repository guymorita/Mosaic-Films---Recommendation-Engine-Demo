class window.RecommendationList extends Backbone.Model

  url: ->
    "/recommend/?:name=" + @name

  initialize: ->

  render: ->
