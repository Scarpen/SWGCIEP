class PhotosController < ApplicationController
  def index
    @photos = Photo.order("created_at DESC")
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      redirect_to photos_path, notice: "The photo has been successfully created."
    else
      render action: "new"
    end
  end

  def edit
    @photo = Photo.find(e)
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(photo_params)
      redirect_to photos_path, notice: "The photo has been successfully updated."
    else
      render action: "edit"
    end
  end

private

  def photo_params
    params.require(:photo).permit(:menu_id, :image, :description)
  end
end
