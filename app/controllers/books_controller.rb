class BooksController < ApplicationController

  before_action :authenticate_user!
  before_action :baria_books, only: [:update, :edit]

  def index
      @b = Book.new
    @books = Book.all.order(created_at: :desc)
  end

  def create
    @b = Book.new(book_params)
    @b.user_id = current_user.id
    @books = Book.all.order(created_at: :desc)
  if @b.save
  flash[:notice] = "successfully"
  redirect_to book_path(@b.id)
  else
  render :index
  end
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user_id
    end

  def edit
  	@book = Book.find(params[:id])
  end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
      flash[:notice] = "successfully"
  	  redirect_to book_path(@book.id)
    else
      render :index
    end
  end

  def destroy
  	book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end

  def baria_books
    book = Book.find(params[:id])
      if book.user != current_user
         redirect_to books_path
      end
  end

end
