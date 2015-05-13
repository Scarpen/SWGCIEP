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
    menu.submenus.build
    
  end

  def vote
    @page = Page.find(params[:page])
    @page.recommends = @page.recommends.to_i + 1
    if cookies[:VoteInstitute]
      cookies.permanent[:VoteInstitute] << @page.id
    else
      cookies.permanent[:VoteInstitute] = Array.new
      cookies.permanent[:VoteInstitute] << 9999999999999999
      cookies.permanent[:VoteInstitute] << @page.id
    end
    @page.save
    redirect_to menus_pages_path
  end

  def conteudo
    @menus = current_user.page.menus
  end

  def menus
    @page = current_user.page

  end

  def create
    @page = Page.new(page_params)
    @page.menus.each do |menu|
      if menu.submenus.size > 0
        menu.tipo = 1
      else
        menu.tipo = 2
      end
    end
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
       @page.menus.each do |menu|
        if menu.submenus.size > 0
          menu.tipo = 1
        else
          menu.tipo = 2
        end
      end
      if @page.save
        redirect_to menus_pages_path, notice: "The page has been successfully created."
      end
    else
      render action: "edit"
    end
    
  end

private

  def page_params
    params.require(:page).permit(:id, :layout_id, :user_id, :header, :logo, :recommends, 
      menus_attributes: [:id, :name, :father_id, :tipo, :page_id, :_destroy, 
        submenus_attributes: [:id, :name, :father_id, :tipo, :page_id, :_destroy]])
  end
end
