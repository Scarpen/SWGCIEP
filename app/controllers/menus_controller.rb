class MenusController < ApplicationController
  def index
    @texts = Menu.order("created_at DESC")
  end

  def show
    @menu = Menu.find(params[:id])
  end

  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.new(menu_params)
    if @menu.save
      redirect_to menus_path, notice: "The menu has been successfully created."
    else
      render action: "new"
    end
  end

  def edit
    @menu = Menu.find(params[:id])
  end

  def update
    @menu = Menu.find(params[:id])
    if @menu.update_attributes(menu_params)
      redirect_to menus_path, notice: "The menu has been successfully updated."
    else
      render action: "edit"
    end
  end

private

  def menu_params
    params.require(:menu).permit(:name, :father_id, :tipo, :page_id)
  end
end
