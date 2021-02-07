class BooksController < ApplicationController

  def top
  end

  def index
    @books=Book.all
    @book=Book.new
    @user=current_user
  end

  def show
    @book=Book.find(params[:id])
    @user=current_user
    @book_new=Book.new

  end

  def create
    @book=Book.new(book_params)
    @book.user_id = current_user.id
    @user=current_user
    @books=Book.all
    if @book.save
    redirect_to book_path(@book.id), notice: 'You have created book successfully.'
    else
      render 'index'
    end
  end


  def edit
    @book=Book.find(params[:id])
  end

  def update
    book=Book.find(params[:id])
    book.update(book_params)
    redirect_to books_path
  end

  def destroy
    book=Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :opinion)
  end


end
