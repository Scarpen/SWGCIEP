class MenusController < ApplicationController
  def index
    @menus = Menu.order("created_at DESC")
  end

  def show
    @menu = Menu.find(params[:id])
    if @menu.page != nil
      @page = @menu.page 
    else
      @page = @menu.father.page
    end
    @voted == false
    if cookies[:VoteInstitute]

      cookies[:VoteInstitute].split("&").each do |vote|
        if vote == @page.id.to_s
          @voted = true
        end
      end

      @comments = @page.comments
      @comment = Comment.new
    end

  end

  def comments_respond
    @comment = Comment.new
    @menu = params[:menu_id]
    @father = params[:father_id]
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

    if @menu.text == nil
      @menu.build_text
    end
    
  end

  def update
    @menu = Menu.find(params[:id])
    if @menu.update_attributes(menu_params)
      redirect_to conteudo_pages_path, notice: "The menu has been successfully updated."
    else
      render action: "edit"
    end
  end

private

  def menu_params
    params.require(:menu).permit(:name, :father_id, :tipo, :page_id, 
      submenus_attributes: [:id, :name, :father_id, :tipo, :page_id, :_destroy], 
      text_attributes: [:id, :menu_id, :description, :_destroy], 
      photos_attributes: [:id, :menu_id, :image, :description, :_destroy])
  end
end
