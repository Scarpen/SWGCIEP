module ApplicationHelper
  def link_to_menu_pai(name, f)
    link_to_function(name, "menu_pai(this)")
  end

  def verify_value(value)
    if value == "1"
      return true
    else
      return false
    end
  end

end

