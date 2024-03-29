class UsersController < ApplicationController
  
  before_action :move_to_user, only: [:edit]

  def move_to_user
    user = User.find(params[:id])
    if user.id != current_user.id
      redirect_to user_path(current_user)
    end
  end
  
  def show
    @book = Book.new
    @user = User.find_by(id: current_user.id)
    @books = Book.where(user_id: params[:id])
  end

  def index
    @users = User.all
    @book = Book.new
    @user = User.find_by(id: current_user.id)
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render "users/edit"
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end
end
