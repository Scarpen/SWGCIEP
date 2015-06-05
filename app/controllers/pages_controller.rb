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
    @menu = Menu.find(params[:menu])
    @page.recommends = @page.recommends.to_i + 1
    if cookies.permanent[:VoteInstitute]
      cookies.permanent[:VoteInstitute] = "#{cookies[:VoteInstitute]}&#{@page.id}"
    else
      cookies.permanent[:VoteInstitute] = "#{@page.id}"
    end
    @page.save
    redirect_to @menu
  end

  def conlayout
    @page = current_user.page
    if @page.header_config == nil
      @page.header_config = 1
    end
    if @page.menu_config == nil
      @page.menu_config = 1
    end
    if @page.logo_config == nil
      @page.logo_config = 1
    end

  end

  def conteudo
    @page = current_user.page
    @menus = @page.menus
  end

  def menus
    @page = current_user.page

  end

  def logo
    @page = current_user.page
  end

  def header
    @page = current_user.page
  end

  def index_admin
    if current_user
      @page = current_user.page
      @count = 0
      @page.comments.each do |comment|
        if comment.father_id == nil
          @count += 1
        end
      end
    else
      redirect_to login_pages_path
    end

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
    @neighborhoods = User.pluck("DISTINCT neighborhood")
    @filters = params[:list_institutes]
    if @filters 
      @institutes = @institutes.search("neighborhood",
        @filters[:neighborhood]) if @filters[:neighborhood] != "Todos" if @filters[:neighborhood].present? 
      @institutes = @institutes.search("elementary_school",
        @filters[:elementary_school]) if @filters[:elementary_school] == "1" if @filters[:elementary_school].present?
      @institutes = @institutes.search("middle_school",
        @filters[:middle_school]) if @filters[:middle_school] == "1" if @filters[:middle_school].present?
      @institutes = @institutes.search("high_school",
        @filters[:high_school]) if @filters[:high_school] == "1" if @filters[:high_school].present?
      @institutes = @institutes.search("name_institute", @filters[:search]) if @filters[:search].present?
      @institutes = @institutes.search("religion",
        @filters[:religion]) if @filters[:religion] != "0" if @filters[:religion].present?
      @institutes = @institutes.search("physical",
        @filters[:physical]) if @filters[:physical] == "1" if @filters[:physical].present?
      @institutes = @institutes.search("hearing",
        @filters[:hearing]) if @filters[:hearing] == "1" if @filters[:hearing].present?
      @institutes = @institutes.search("mental",
        @filters[:mental]) if @filters[:mental] == "1" if @filters[:mental].present?
      @institutes = @institutes.search("view",
        @filters[:view]) if @filters[:view] == "1" if @filters[:view].present?
    else
      @filters = Hash.new
      @filters[:neighborhood] = "Todos"
      @filters[:search] = ""
      @filters[:elementary_school] = "0"
      @filters[:middle_school] = "0"
      @filters[:high_school] = "0"
      @filters[:religion] = 0
      @filters[:physical] = "0"
      @filters[:hearing] = "0"
      @filters[:mental] = "0"
      @filters[:view] = "0"
    end
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
        redirect_to index_admin_pages_path, notice: "As informacoes foram atualizadas com sucesso"
      end
    else
      redirect_to index_admin_pages_path, notice: "Nao foi possivel atualizar as informacoes "
    end
    
  end

private

  def page_params
    params.require(:page).permit(:id, :layout_id, :user_id, :header,:header_config, :menu_config, :logo_config, :logo, :recommends, 
      menus_attributes: [:id, :name, :father_id, :tipo, :page_id, :_destroy, 
        submenus_attributes: [:id, :name, :father_id, :tipo, :page_id, :_destroy]])
  end
  def user_params
    params.require(:user).permit(:id, :email, :password, :password_confirmation, :name_institute, 
      :name_responsible,:phone, :role_id, :middle_school, :elementary_school, :high_school,
      :neighborhood, :religion, :physical, :hearing, :mental, :view)
  end
end
