class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :name
      t.integer :father_id
      t.integer :tipo
      t.integer :page_id

      t.timestamps
    end
  end
end
