class BooksController < ApplicationController
before_action :ensure_correct_book, only:[:edit, :update]

  def index
    @books=Book.includes(:user)
    @book=Book.new
    @user=current_user
  end

  def show
    @book=Book.find(params[:id])
    @user_select=@book.user
    @book_new=Book.new

  end

  def create
    @book=Book.new(book_params)
    @book.user_id = current_user.id

    if @book.save
      redirect_to book_path(@book.id), notice: 'You have created book successfully.'
    else
      @user=current_user
      @books=Book.includes(:user)
      render 'index'
    end
  end


  def edit
    @book=Book.find(params[:id])
  end

  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: 'You have updated book successfully.'
    else
      render 'edit'
    end
  end

  def destroy
    book=Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body).merge(user_id: current_user.id)
  end

   def ensure_correct_book
    @book = Book.find(params[:id])
     unless @book.user.id == current_user.id
      redirect_to books_path
     end
   end



end
