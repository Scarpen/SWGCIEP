class RegistrationsController < Devise::RegistrationsController
  def create
    super
      page = Page.new
      page.user_id = resource.id
      menu = page.menus.build
      menu.name = "Menu Inicial"
      menu.tipo = 1
      menu.submenus.build
      page.menus.each do |menu|
        if menu.submenus.size > 0
          menu.tipo = 1
        else
          menu.tipo = 2
        end
      end
      page.save
      resource.save
  end

end