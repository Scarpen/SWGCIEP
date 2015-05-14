class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :comment
      t.string :author
      t.integer :father_id
      t.integer :page_id

      t.timestamps
    end
  end
end
