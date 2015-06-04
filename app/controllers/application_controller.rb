class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

before_action :configure_permitted_parameters, if: :devise_controller?
  layout :resolve_layout

  # ...


protected
	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up) << :role_id
		devise_parameter_sanitizer.for(:sign_up) << :name_institute
		devise_parameter_sanitizer.for(:sign_up) << :phone
		devise_parameter_sanitizer.for(:sign_up) << :name_responsible
		devise_parameter_sanitizer.for(:sign_up) << :elementary_school
		devise_parameter_sanitizer.for(:sign_up) << :middle_school
		devise_parameter_sanitizer.for(:sign_up) << :high_school
		devise_parameter_sanitizer.for(:sign_up) << :neighborhood
		devise_parameter_sanitizer.for(:sign_up) << :religion
		devise_parameter_sanitizer.for(:sign_up) << :physical
		devise_parameter_sanitizer.for(:sign_up) << :hearing
		devise_parameter_sanitizer.for(:sign_up) << :mental
		devise_parameter_sanitizer.for(:sign_up) << :view
	end
	private

  def resolve_layout
    case action_name
    when "menus", "conteudo", "edit", "logo", "header", "index_admin", "conlayout"
      "admin_panel"
    when "index"
      "index_layout"
    when "show"
    	"vintage2"
    when "login"
      "login_layout"
    when "list_institutes"
      "list_layout"
    else
      "application"
    end
  end
end