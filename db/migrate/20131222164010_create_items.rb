class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name, limit: 100
      t.string :magic_name, limit: 100
      t.text :properties, limit: 2000
      t.text :description, limit: 2000
      t.boolean :identified, default: false
      t.integer :user_id
      t.integer :game_id

      t.timestamps
    end
  end
end