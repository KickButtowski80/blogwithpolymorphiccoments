App.page = App.cable.subscriptions.create "PageChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    alert data['message']

  show_comment: (message) ->
    @perform 'show_comment', message: message

$(document).on 'click', '[data-behavior~=page_show_comment"]', (event) ->
  # if event.keyCode is 13 # return = send
  #   App.room.speak event.target.value
  #   event.target.value=''
  #   event.preventDefault()
  alert("I am clicked")