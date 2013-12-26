class Game < ActiveRecord::Base

  # FIELD ACCESS
  attr_accessible :description, :name
  validates :name, presence: true, length: { maximum: 64 }
  
  # Many to many relationship with users
  has_many :games_relationships
  has_many :users, :through => :games_relationships
  
  has_many :game_categories
  
  # Note for methods: gm and players
  # These methods check whether GM in game exists or not. This should not be possible
  # in the final version (because game can only exist if it's created by GM in the first place),
  # but as of now when creating games from console I left some without GM and it's causing
  # problems.
  
  def gm
    gr = games_relationships.find { |g| g.role == "GM" }
    if gr
      User.find { |u| u.id == gr.user_id }
    else
      nil
    end
  end
  
  def players
    if gm
      users_cpy = users.dup
      users_cpy.delete(gm)
      users_cpy
    else
      users
    end
  end
  
end