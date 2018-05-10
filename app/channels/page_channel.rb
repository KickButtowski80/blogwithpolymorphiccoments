class PageChannel < ApplicationCable::Channel
  def subscribed
    stream_from "page_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
  
  def show_comment(data)
    ActionCable.server.broadcast 'page_channel', message: data['message']
    Comment.create! commenter:current_admin.user_name , body: data['message'], commentable_type: "Article",  commentable_id:1
  end
  
end