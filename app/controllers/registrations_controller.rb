class ConfirmationsController < Devise::ConfirmationsController
    def after_confirmation_path_for(resource_name, resource)
      if signed_in?(resource_name)
        signed_in_root_path(resource)
      else
        login_pages_path
      end
    end

end