class window.TopUsersView extends Backbone.View

  template: '
      <div>
      <h2>Most Similar to / Least Similar to</h2>
      <div id="similarity">
      </div>
      </div>
      '

  initialize: ->
    @oldUsers
    @$el.append @template
    @$('#similarity').isotope({
      itemSelector : '.element',
      animationEngine: 'jquery'
    })
    setTimeout( ->
      @$('#similarity').isotope('reLayout')
    , 100 )

  reRender: (res) ->
    console.log(res)
    @$('#similarity').isotope( 'shuffle')
    usersToAdd = _.difference(res.similarUsers.slice(0,3), @oldUsers)
    usersToRemove = _.difference(@oldUsers, res.similarUsers.slice(0,3))
    @oldUsers = res.similarUsers.slice(0,3)
    for index, userid of usersToAdd
      @name = @model.userObj.userLookup[userid] || 'newUser'
      newUser = $('<div class="element user metalloid '+@name.replace(/\s+/g, '').toLowerCase()+'">'+@name+'</div>')
      @$('#similarity').isotope('insert', newUser)
    for index, userid of usersToRemove
      @nameRemove = @model.userObj.userLookup[userid] || 'newUser'
      removeUser = @$('.'+@nameRemove.replace(/\s+/g, '').toLowerCase())
      @$('#similarity').isotope('remove', removeUser)
    disUsersToAdd = _.difference(res.similarUsers.slice(-3), @oldDisUsers)
    disUsersToRemove = _.difference(@oldDisUsers, res.similarUsers.slice(-3))
    @oldDisUsers = res.similarUsers.slice(-3)
    for index, userid of disUsersToAdd
      @disName = @model.userObj.userLookup[userid] || 'newUser'
      disNewUser = $('<div class="element user noble-gas nonmetal '+@disName.replace(/\s+/g, '').toLowerCase()+'">'+@disName+'</div>')
      @$('#similarity').isotope('insert', disNewUser)
    for index, userid of disUsersToRemove
      @disNameRemove = @model.userObj.userLookup[userid] || 'newUser'
      disRemoveUser = @$('.'+@disNameRemove.replace(/\s+/g, '').toLowerCase())
      @$('#similarity').isotope('remove', disRemoveUser)
    @$('#similarity').isotope( 'shuffle')
