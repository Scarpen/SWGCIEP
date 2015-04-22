class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.string :description
      t.integer :menu_id

      t.timestamps
    end
  end
end
