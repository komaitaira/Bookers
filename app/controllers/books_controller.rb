class BooksController < ApplicationController
  def top
  end
# topはhomes_controllerを作ってそこで定義すればいいのか？遷移自体はうまく行っているから機能には問題なし

  def index
  	@books = Book.all
  	@book = Book.new
  end

  def create
  	book = Book.new(book_params)
  	if book.save
  	   flash[:notice] = "Book was successfully created."
  	   redirect_to book_path(book.id)
  	else
       @books = Book.all
  	   redirect_to books_path
       # renderだとうまくいかない？indexの繰り返し処理の@booksがnilになっている？復習する
       # redirect_toにするとindexに遷移するようになったが、error_messageが表示されない
  	end
  end

  def show
  	@book = Book.find(params[:id])
  end

  def edit
  	@book = Book.find(params[:id])
  end

  def update
  	book = Book.find(params[:id])
  	if book.update(book_params)
  	   flash[:notice] = "Book was successfully updated."
  	   redirect_to book_path(book.id)
  	else
  		render :show
      # ここもredirect_toで指定して遷移させればいいのか？
  	end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
  	flash[:notice] = "Book was successfully destroyed."
  	redirect_to books_path
  end

  private
  def book_params
  	params.require(:book).permit(:title, :body)
  end
end
