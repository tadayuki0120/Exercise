class UsersController < ApplicationController
before_action :ensure_correct_user, only:[:edit, :update]

  def index
    @users = User.includes(:books)
    @user =current_user
    @book_new = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book_new = Book.new
  end

  def create
    @book=Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    redirect_to user_path(@user.id)
    else
    @user=current_user
    @books=Book.includes(:user)
    render books_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: 'You have updated user successfully.'
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end

   def ensure_correct_user
    @user = User.find(params[:id])
     unless @user.id == current_user.id
      redirect_to current_user
     end
   end

end

