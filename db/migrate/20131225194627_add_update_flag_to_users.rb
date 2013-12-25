class AddUpdateFlagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :update_flag, :boolean
  end
end
