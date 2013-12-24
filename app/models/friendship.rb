class Friendship < ActiveRecord::Base
  
  # FIELD ACCESS
  attr_accessible :friend_id, :user_id, :request
  
  # Relationship between users (friends)
  belongs_to :user, class_name: "User"
  belongs_to :friend, class_name: "User"
  
  # FIELD VALIDATION
  validates :user_id, presence: true
  validates :friend_id, presence: true
  
  REQUEST = %w(active pending)
  validates :request, :inclusion => {:in => REQUEST}
  
end
