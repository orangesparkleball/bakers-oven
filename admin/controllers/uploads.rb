Admin.controllers :uploads do

  get :index do
    @uploads = Upload.all
    render 'uploads/index'
  end

  get :new do
    @upload = Upload.new
    render 'uploads/new'
  end

  post :create do
    params[:upload]['book'] = Book.get(params[:upload]['book'])
    @upload = Upload.new(params[:upload])

    if @upload.save
      flash[:notice] = 'Upload was successfully created.'
      redirect url(:uploads, :edit, :id => @upload.id)
    else
      render 'uploads/new'
    end
  end

  get :edit, :with => :id do
    @upload = Upload.get(params[:id])
    render 'uploads/edit'
  end

  put :update, :with => :id do
    @upload = Upload.get(params[:id])
    params[:upload]['book'] = Book.get(params[:upload]['book'])
    if @upload.update(params[:upload])
      flash[:notice] = 'Upload was successfully updated.'
      redirect url(:uploads, :edit, :id => @upload.id)
    else
      render 'uploads/edit'
    end
  end

  delete :destroy, :with => :id do
    upload = Upload.get(params[:id])
    if upload.destroy
      flash[:notice] = 'Upload was successfully destroyed.'
    else
      flash[:error] = 'Impossible destroy Upload!'
    end
    redirect url(:uploads, :index)
  end
end
