class ChatroomsController < ApplicationController

  def create
    @chatroom = Chatroom.new(user_one: current_user, user_two:User.find(params[:user_two]))
    @chatroom.save
    redirect_to chatrooms_path(chatroom_id: @chatroom)
  end

  def index
    @my_chatrooms = current_user.chatrooms
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @user = current_user
    @other_user =  @chatroom.user_two == current_user ? @chatroom.user_one : @chatroom.user_two
    @message = Message.new
  end

  def destroy
    @chatroom.destroy
  end

end
