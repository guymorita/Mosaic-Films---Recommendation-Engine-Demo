class window.TopUsersView extends Backbone.View

  template: '
      <div class="row">
      <div class="col-lg-6">
        <h2>Most Similar to
        <a class="tip3" data-toggle="tooltip" data-placement="right" title="These are the users you are most similar to. Many movies they&#39;ve seen and liked will be recommended to you.">
          <i class="icon-info-sign smallicon"></i>
        </a>
      </h2>
        <div id="similarity">
        </div>
      </div>
      <div class="col-lg-6">
        <h2>Least Similar to
        <a class="tip4" data-toggle="tooltip" data-placement="right" title="These are the users who have opposite preferences as you. Movies they don&#39;t like you often like.">
          <i class="icon-info-sign smallicon"></i>
        </a>
        </h2>
        <div id="disSimilarity">
        </div>
      </div>
      </div>
      '

  initialize: ->
    @oldUsers
    @$el.append @template
    @$('.tip3').tooltip('hide')
    @$('.tip4').tooltip('hide')
    @$('#similarity').isotope({
      itemSelector : '.element',
      animationEngine: 'jquery'
    })
    @$('#disSimilarity').isotope({
      itemSelector : '.element',
      animationEngine: 'jquery'
    })
    setTimeout( ->
      @$('#similarity').isotope('reLayout')
      @$('#disSimilarity').isotope('reLayout')
    , 100 )


  reRender: (res) ->
    @$('#similarity').isotope( 'shuffle')
    @$('#disSimilarity').isotope( 'shuffle')
    usersToAdd = _.difference(res.similarUsers.slice(0,5), @oldUsers)
    usersToRemove = _.difference(@oldUsers, res.similarUsers.slice(0,5))
    @oldUsers = res.similarUsers.slice(0,5)
    for index, userid of usersToAdd
      @name = @model.userObj.userLookup[userid] || 'newUser'
      newUser = $('<div id="'+userid+'" class="element user metalloid '+@name.replace(/\s+/g, '').toLowerCase()+'">'+@name+'</div>')
      @$('#similarity').isotope('insert', newUser)
    for index, userid of usersToRemove
      @nameRemove = @model.userObj.userLookup[userid] || 'newUser'
      removeUser = @$('.'+@nameRemove.replace(/\s+/g, '').toLowerCase())
      @$('#similarity').isotope('remove', removeUser)
    @$('#similarity').isotope( 'shuffle')
    if res.similarUsers.length > 5
      disUsersToAdd = _.difference(res.similarUsers.slice(-5), @oldDisUsers)
      disUsersToRemove = _.difference(@oldDisUsers, res.similarUsers.slice(-5))
      @oldDisUsers = res.similarUsers.slice(-5)
      for index, userid of disUsersToAdd
        @disName = @model.userObj.userLookup[userid] || 'newUser'
        disNewUser = $('<div id="'+userid+'" class="element user halogen '+@disName.replace(/\s+/g, '').toLowerCase()+'">'+@disName+'</div>')
        @$('#disSimilarity').isotope('insert', disNewUser)
      for index, userid of disUsersToRemove
        @disNameRemove = @model.userObj.userLookup[userid] || 'newUser'
        disRemoveUser = @$('.'+@disNameRemove.replace(/\s+/g, '').toLowerCase())
        @$('#disSimilarity').isotope('remove', disRemoveUser)
      @$('#disSimilarity').isotope( 'shuffle')
