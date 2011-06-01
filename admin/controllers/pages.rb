Admin.controllers :pages do

  get :index do
    
    if(@current_book)
      @pages = @current_book.pages.all(:order => :page_number)
    else
      @pages = Page.all
    end
    render 'pages/index'
  end

  get :new do
    @page = Page.new
    render 'pages/new'
  end

  post :create do
    params[:page]['cover_image'] = Upload.get(params[:page]['cover_image'])
    params[:page]['book'] = Book.get(params[:page]['book'])
    @page = Page.new(params[:page])
    if @page.save
      flash[:notice] = 'Page was successfully created.'
      redirect url(:pages, :edit, :id => @page.id)
    else
      render 'pages/new'
    end
  end

  get :edit, :with => :id do
    @page = Page.get(params[:id])
    render 'pages/edit'
  end

  put :update, :with => :id do
    @page = Page.get(params[:id])
    params[:page]['cover_image'] = Upload.get(params[:page]['cover_image'])
    params[:page]['book'] = Book.get(params[:page]['book'])
    if @page.update(params[:page])
      flash[:notice] = 'Page was successfully updated.'
      redirect url(:pages, :edit, :id => @page.id)
    else
      render 'pages/edit'
    end
  end

  delete :destroy, :with => :id do
    page = Page.get(params[:id])
    if page.destroy
      flash[:notice] = 'Page was successfully destroyed.'
    else
      flash[:error] = 'Impossible destroy Page!'
    end
    redirect url(:pages, :index)
  end
end
