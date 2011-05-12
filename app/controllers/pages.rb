BakersOven.controllers :pages do
  get :root, :map => "/" do
    redirect url(:pages, :cover, :format => :html)
  end
  get :cover, :map => "/00", :provides => [:html], :layout => :cover do
    page_nums!
    render 'pages/cover'
  end

  get :index, :map => "/index", :provides => [:html], :layout => nil do
    render 'pages/index'
  end

  
  get :page, :map => '/:page', :provides => [:html], :layout => :laker do 
    if(params[:page] == 'index')
      render 'pages/index', :layout => false
    else
      page_nums!
      @title = settings.pages.select{|p| p["num"] == params[:page]}.first["title"]
      render "pages/#{params[:page]}"
    end
  end
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

  
end
