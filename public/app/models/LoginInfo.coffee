class window.LoginInfo extends Backbone.Model

  url: ->
    "/login/?:username=" + @name

  initialize: ->

  render: ->
