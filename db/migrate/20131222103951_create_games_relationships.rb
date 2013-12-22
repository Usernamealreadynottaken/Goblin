class CreateGamesRelationships < ActiveRecord::Migration
  def change
    create_table :games_relationships do |t|
      t.integer :user_id
      t.integer :game_id
      t.string :role

      t.timestamps
    end
    add_index :games_relationships, :user_id
    add_index :games_relationships, :game_id
    add_index :games_relationships, [:user_id, :game_id], uniqueness: true
  end
end
