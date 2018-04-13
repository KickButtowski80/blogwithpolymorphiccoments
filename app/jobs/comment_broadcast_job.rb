class CommentBroadcastJob < ApplicationJob
  queue_as :default
  
  def perform(message)
    ActionCable.server.broadcast 'page_channel', message: render_message(message)
  end
  
  private 
    def render_message(message)
      # you can check all the vairalabes values in the console
      # binding.pry 
      # message.commentable  
      ApplicationController.render(partial: 'comments/comment', locals: {commentable: message.commentable, message:message})
      
    end
end
