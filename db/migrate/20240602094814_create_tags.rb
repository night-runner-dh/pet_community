class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.integer :post_id, null: false

      t.timestamps
    end
  end
end
