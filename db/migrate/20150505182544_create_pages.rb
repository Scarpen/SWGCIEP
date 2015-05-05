class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :layout_id
      t.integer :user_id
      t.string :header
      t.string :logo
      t.integer :recommends

      t.timestamps
    end
  end
end
