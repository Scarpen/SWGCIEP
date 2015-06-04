class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @comments = Comment.all
    respond_with(@comments)
  end

  def show
    respond_with(@comment)
  end

  def new
    @comment = Comment.new
    respond_with(@comment)
  end

  def edit
  end

  def create
    @comment = Comment.new(comment_params)
    menu = Menu.find(params[:menu_id])
    @comment.save
    
    redirect_to menu
  end
  def update
    @comment.update(comment_params)
    respond_with(@comment)
  end

  def destroy
    if @comment.page.menus.first.submenus.first == nil
     page = @comment.page.menus.first
    else
     page = @comment.page.menus.first.submenus.first
    end
    @comment.destroy
    redirect_to page
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:comment, :author, :father_id, :page_id)
    end
end
