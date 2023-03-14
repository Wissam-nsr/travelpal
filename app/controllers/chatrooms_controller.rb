class ChatroomsController < ApplicationController

  def create
    @chatroom = Chatroom.new(params[:chatroom])
    @chatroom.save
  end

  def show
    @chatrooms = Chatroom.all
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end

  def destroy
    @chatroom.destroy
  end

end
