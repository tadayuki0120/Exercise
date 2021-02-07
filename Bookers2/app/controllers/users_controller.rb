class UsersController < ApplicationController
  
  def index
    @books = Book.all
    @users = User.all
    @user =current_user
    @book_new = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book_new = Book.new
  end
  
  def create
    @book=Book.new(book_params)
    @book.user_id = current_user.id
    @user=current_user
    @books=Book.all
    if @book.save
    redirect_to user_path(@user.id)
    else
    render books_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def book_params
    params.require(:book).permit(:title, :opinion)
  end

end

