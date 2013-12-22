class Game < ActiveRecord::Base

  # FIELD ACCESS
  attr_accessible :description, :name
  validates :name, presence: true, length: { maximum: 64 }
  
  # Many to many relationship with users
  has_many :games_relationships
  has_many :users, :through => :games_relationships
  
end
