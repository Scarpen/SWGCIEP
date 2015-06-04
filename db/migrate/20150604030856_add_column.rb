class AddColumn < ActiveRecord::Migration
  def change
  	add_column :pages, :header_config, :integer
  	add_column :pages, :menu_config, :integer
  	add_column :pages, :logo_config, :integer
  end
end
