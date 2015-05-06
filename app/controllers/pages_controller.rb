class PagesController < ApplicationController
  def index
    @pages = Page.order("created_at DESC")
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new
    menu = @page.menus.build
    menu.name = "Menu Inicial"
    menu.tipo = 1
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      redirect_to pages_path, notice: "The page has been successfully created."
    else
      render action: "new"
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      redirect_to pages_path, notice: "The page has been successfully updated."
    else
      render action: "edit"
    end
  end

private

  def page_params
    params.require(:page).permit(:layout_id, :user_id, :header, :logo, :recommends, menus_attributes: [:id, :name, :father_id, :tipo, :page_id, :_destroy])
  end
end
