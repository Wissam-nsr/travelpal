class ChatroomsController < ApplicationController

  def create
    @chatroom = Chatroom.new(user_one: current_user, user_two:User.find(params[:user_two]))
    @chatroom.save
    redirect_to chatroom_path(@chatroom)
    # redirect_to chatrooms_path(chatroom_id: @chatroom)
  end

  def show
    if params[:id].present?
      @chatroom = Chatroom.find(params[:id])
    elsif Chatroom.last.any?
      @chatroom = Chatroom.last
    end
    @all_chatrooms = Chatroom.all
    @my_chatrooms = []
    @all_chatrooms.each do |chatroom|
      if (chatroom.user_one == current_user || chatroom.user_two == current_user) && chatroom != @chatroom
        @my_chatrooms << chatroom
      end
    end
    @message = Message.new
  end

  def destroy
    @chatroom.destroy
  end

end