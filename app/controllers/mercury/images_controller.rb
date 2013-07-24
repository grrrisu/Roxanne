class Mercury::ImagesController < MercuryController

  # POST /images.json
  def create
    @image = Mercury::Image.new(params[:image])
    @image.save
    render json: @image, status: :created
  end

  # DELETE /images/1.json
  def destroy
    @image = Mercury::Image.find(params[:id])
    @image.destroy
    head :ok
  end

end
