class TextsController < ApplicationController
  def index
    @texts = Text.order("created_at DESC")
  end

  def show
    @text = Text.find(params[:id])
  end

  def new
    @text = Text.new
  end

  def create
    @text = Text.new(text_params)
    if @text.save
      redirect_to texts_path, notice: "The text has been successfully created."
    else
      render action: "new"
    end
  end

  def edit
    @text = Text.find(params[:id])
  end

  def update
    @text = Text.find(params[:id])
    if @text.update_attributes(text_params)
      redirect_to @text.menu, notice: "The text has been successfully updated."
    else
      render action: "edit"
    end
  end

private

  def text_params
    params.require(:text).permit(:menu_id, :description)
  end
end
