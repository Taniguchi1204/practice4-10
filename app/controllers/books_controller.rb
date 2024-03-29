class BooksController < ApplicationController

  before_action :move_to_index, only:[:edit]

  def move_to_index
    book = Book.find(params[:id])
    if book.user_id != current_user.id
      redirect_to books_path
    end
  end
  
  def show
    @book_detail = Book.find(params[:id])
    @book = Book.new
    @user = User.find_by(id: current_user.id)
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = User.find_by(id: current_user.id)
  end

  def create
    @books = Book.all
    @user = User.find_by(id: current_user.id)
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to books_path
    else
      render "books/index"
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
        redirect_to book_path(@book.id)
    else
      render "books/edit"
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title,:body)
  end
end
