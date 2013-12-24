class AddRequestToFriendships < ActiveRecord::Migration
  def change
    add_column :friendships, :request, :string
  end
end
