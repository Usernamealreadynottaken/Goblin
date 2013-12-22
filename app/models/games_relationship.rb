class GamesRelationship < ActiveRecord::Base

  # FIELD ACCESS
  attr_accessible :game_id, :role, :user_id
  
  PLAYER_ROLE = %w(GM Player)
  validates :role, :inclusion => {:in => PLAYER_ROLE}
  
  # Relationship between games and users
  belongs_to :user
  belongs_to :game
  
  # FIELD VALIDATION
  validates :game_id, presence: true
  validates :user_id, presence: true
  validates :role, presence: true
  
end
