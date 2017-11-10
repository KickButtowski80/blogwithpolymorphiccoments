class PageChannel < ApplicationCable::Channel
  def subscribed
    stream_from "page_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def show_comment(data)
    ActionCable.server.broadcast 'page_channel', message: data['message']
  end
end
