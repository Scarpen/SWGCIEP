class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.text :description
      t.integer :menu_id

      t.timestamps
    end
  end
end
