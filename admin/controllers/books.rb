Admin.controllers :books do

  get :index do
    @books = Book.all
    render 'books/index'
  end

  get :new do
    @book = Book.new
    render 'books/new'
  end

  get :choose, :with => :id do
    @current_book = Book.get(params[:id])
    session[:current_book] = params[:id]
    redirect url(:pages, :index)
  end

  get :unchoose do
    @current_book = nil
    session[:current_book] = nil
    redirect url(:books, :index)
  end

  post :create do
    @book = Book.new(params[:book])
    if @book.save
      flash[:notice] = 'Book was successfully created.'
      redirect url(:books, :edit, :id => @book.id)
    else
      render 'books/new'
    end
  end

  get :edit, :with => :id do
    @book = Book.get(params[:id])
    render 'books/edit'
  end

  put :update, :with => :id do
    @book = Book.get(params[:id])
    if @book.update(params[:book])
      flash[:notice] = 'Book was successfully updated.'
      redirect url(:books, :edit, :id => @book.id)
    else
      render 'books/edit'
    end
  end

  delete :destroy, :with => :id do
    book = Book.get(params[:id])
    if book.destroy
      flash[:notice] = 'Book was successfully destroyed.'
    else
      flash[:error] = 'Impossible destroy Book!'
    end
    redirect url(:books, :index)
  end
end
