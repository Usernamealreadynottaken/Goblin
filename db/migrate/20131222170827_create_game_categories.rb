class CreateGameCategories < ActiveRecord::Migration
  def change
    create_table :game_categories do |t|
      t.string :name, limit: 100
      t.integer :game_id

      t.timestamps
    end
  end
end
