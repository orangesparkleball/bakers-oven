BakersOven.controllers :book do
  # get :index, :map => "/foo/bar" do
  #   session[:foo] = "bar"
  #   render 'index'
  # end

  # get :sample, :map => "/sample/url", :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get "/example" do
  #   "Hello world!"
  # end

  get :show_page, :map => '/book/:id/page/:page_number' do
    @page = Page.first(:book_id => params[:id], :page_number => params[:page_number])
    unless @page
      @page = Page.first(:book_id => params[:id], :order => :page_number)
      redirect url(:book, :show_page, params[:id], @page.page_number)
    end
    render "book/page"
  end

  get :show, :with => :id do
    @page = Page.first(:book_id => params[:id], :order => :page_number)
    redirect url(:book, :show_page, params[:id], @page.page_number)
  end
  
  get :index, :with => :id do
    @page = Page.first(:book_id => params[:id], :order => :page_number)
    redirect url(:book, :show_page, params[:id], @page.page_number)
  end

  get :list, :map => '/' do
    @books = Book.all
    render "book/list"
  end
end
