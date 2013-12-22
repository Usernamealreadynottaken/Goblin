class FixItemGameId < ActiveRecord::Migration
  def change
    rename_column :items, :game_id, :game_category_id
  end
end
