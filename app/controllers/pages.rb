AboutUs.controllers :pages do
  get :index, :map => "/" do
    redirect url(:pages, :cover, :format => :html)
  end

  get :cover, :map => "/00", :provides => [:html], :layout => :cover do
    page_nums!
    render 'pages/cover'
  end

  get :page, :map => '/:page', :provides => [:html], :layout => :laker do 
    page_nums!
    render "pages/#{params[:page]}"
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
