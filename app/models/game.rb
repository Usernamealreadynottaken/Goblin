class Game < ActiveRecord::Base

  # FIELD ACCESS
  attr_accessible :description, :name
  validates :name, presence: true, length: { maximum: 64 }
  
  # Many to many relationship with users
  has_many :games_relationships
  has_many :users, :through => :games_relationships
  
  has_many :game_categories
  
  def gm
    User.find { |u| u.id == games_relationships.find { |g| g.role == "GM" }.user_id }
  end
  
  def players
    users.delete { |u| u.id == gm.id }
  end
  
end