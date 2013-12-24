class GameCategory < ActiveRecord::Base
  
  # FIELD ACCESS
  attr_accessible :name, :game_id
  
  # RELATIONSHIPS
  belongs_to :game
  
  has_many :items
  
  def gm_items
    items.select { |i| i.user_id == game.gm.id }
  end  
  
end