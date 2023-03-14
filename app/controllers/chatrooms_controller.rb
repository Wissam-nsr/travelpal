class ChatroomsController < ApplicationController

  def create
    @chatroom = Chatroom.new(user_one: current_user, user_two:User.find(params[:user_two]))
    @chatroom.save
    redirect_to chatrooms_path(chatroom_id: @chatroom)
  end

  def index
    @all_chatrooms = Chatroom.all
    @my_chatrooms = []
    @all_chatrooms.each do |chatroom|
      if (chatroom.user_one == current_user || chatroom.user_two == current_user)
        @my_chatrooms << chatroom
      end
    end
      if params[:chatroom].present?
      @chatroom = Chatroom.find(params[:id])
    end
    @message = Message.new
    raise
  end

  def destroy
    @chatroom.destroy
  end

end
