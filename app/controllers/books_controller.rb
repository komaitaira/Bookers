class BooksController < ApplicationController
  def top
  end

  def index
  	@books = Book.all
  	@book = Book.new
  end

  def create
  	@book = Book.new(book_params)
  	if @book.save
  	   flash[:notice] = "Book was successfully created."
  	   redirect_to book_path(@book.id)
  	else
       @books = Book.all
       render :index
       # renderだとうまくいかない？indexの繰り返し処理の@booksがnilになっている？
       # redirect_toにするとindexに遷移するようになったが、error_messageが表示されない
       # 【解決】インスタンス変数には@をつけないといけなかった → index.html.erbで表示するには@をつけないといけないから。
       # elseの下で再度@booksのデータを取得しなければ、index.html.erbのeach文のところが表示できない。だからundefined method `each' for nil:NilClassとエラーが表示された。
  	end
  end

  def show
  	@book = Book.find(params[:id])
  end

  def edit
  	@book = Book.find(params[:id])
  end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  	   flash[:notice] = "Book was successfully updated."
  	   redirect_to book_path(@book.id)
  	else
  		render :edit
      # ここもredirect_toで指定して遷移させればいいのか？
      # 【解決】インスタンス変数には@をつけないといけなかった → edit.html.erbで表示するには@をつけないといけないから。
      # @book = Book.find(params[:id])で保存失敗前に既にデータをインスタンス変数@bookに代入しているので、createアクションと違いelseの下でわざわざ再度データを取り出す必要はなく、renderのみでよい。
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
