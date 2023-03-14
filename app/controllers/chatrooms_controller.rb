class ChatroomsController < ApplicationController

  def create
    @chatroom = Chatroom.new(params[:chatroom])
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end

  def index
    @chatrooms = Chatroom.all
  end

  def destroy
    @chatroom.destroy
  end

end
