class PagesController < ApplicationController
  def index
    @pages = Page.order("created_at DESC")
  end

  def show
    @page = Page.find(params[:id])
  end
  def registration
    @user = User.new
  end

  def edit_user 
    @user = User.find(params[:id])
  end

  def update_user 
    @user = User.find(params[:id])
        if @user.update_attributes(user_params)
          if @user.user
            redirect_to list_institutes_path, notice: "O usuario foi atualizado com sucesso"
          end
        else
            render action: "edit_user"
        end
  end

  def new_user
    @user = User.new(user_params)
    if @user.save
      page = Page.new
        page.user_id = @user.id
        menu = page.menus.build
        menu.name = "Menu Inicial"
        menu.tipo = 1
        sub = menu.submenus.build
        sub.name = "Submenu 1"
        sub.tipo = 2
        page.menus.each do |menu|
          if menu.submenus.size > 0
            menu.tipo = 1
          else
            menu.tipo = 2
          end
        end
        page.save
        redirect_to root_path
      end
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
    if cookies[:Vo1teInstitute]
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

  def list_institutes
    @institutes = User.where("role_id = 2")
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
       @page.menus.each do |menu|
        if menu.submenus.size > 0
          menu.tipo = 1
        end
      end
      if @page.save
        redirect_to menus_pages_path, notice: "O menu foi atualizado com sucesso"
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
  def user_params
    params.require(:user).permit(:id, :email, :password, :password_confirmation, :name_institute, :name_responsible,:phone, :role_id)
  end
end
