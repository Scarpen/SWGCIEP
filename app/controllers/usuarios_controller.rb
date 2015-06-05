class UsuariosController < ApplicationController
  def index
    @users = User.order("created_at DESC")
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.page.destroy
    @user.destroy
    redirect_to list_institutes_pages_path
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to list_institutes_pages_path, notice: "The user has been successfully updated."
    else
      render action: "edit"
    end
  end


private 
  def user_params
    params.require(:user).permit(:id, :email, :password, :password_confirmation, :name_institute, 
      :name_responsible,:phone, :role_id, :middle_school, :elementary_school, :high_school,
      :neighborhood, :religion, :physical, :hearing, :mental, :view)
  end
end
