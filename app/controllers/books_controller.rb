class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.all
    @user = current_user
    if @book.save
    flash[:notice] = "You have successfully posted"
    redirect_to book_path(@book)
    else
    render :index
    end
  end

  def index

    @books = Book.all
    @book = Book.new
    
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @cat = Book.new
    @user = current_user
  end

  def edit
    @book = Book.find(params[:id])
    user = @book.user
    unless user.id == current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    user = @book.user
    unless user.id == current_user.id
      redirect_to books_path
    end
    if @book.update(book_params)
    flash[:notice] = "You have successfully updated the post"
    redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.delete
    redirect_to '/books'
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
