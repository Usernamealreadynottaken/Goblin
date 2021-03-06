class User < ActiveRecord::Base
  
  # FIELD ACCESS
  attr_accessible :name, :email, :password, :password_confirmation, :update_flag
  before_create :create_remember_token
  before_save { self.email = email.downcase }

  # FIELD VALIDATION
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
                    
  # Many to many relationship with games
  has_many :games_relationships
  has_many :games, :through => :games_relationships
  
  # Many to many relationship with friends
  has_many :friendships, foreign_key: "user_id", dependent: :destroy
  has_many :friends, through: :friendships, source: :friend
  has_many :reverse_friendships, foreign_key: "friend_id",
                                   class_name:  "Friendship",
                                   dependent:   :destroy
  has_many :users, through: :reverse_friendships, source: :user
  
  # Relationship with items
  has_many :items

  # Method has_secure_password automatically validates for :password presence and :password_digest,
  # and confirms if :password_confirmation = :password                     
  validates :password, length: { minimum: 6 }                    
                    
  # Add entire password handling/validation using one command because Rails                      
  has_secure_password
  
  def items_in(game)
    items.select { |i| i.game_category.game.id == game.id }    
  end
  
  # METHODS NOT RELATED TO THIS MODEL
  
  # Ok so there are some methods that generate and encrypt tokens. Only user has tokens so
  # it's ok to put them here probably. The thing is that they do not set the users token, just
  # generally generate and encrypt one which means these method could potentially be used
  # anywhere should we implement tokens anywhere else. Because of that I tried putting them
  # in a separate module file but I could not figure out where to put module or how to include it,
  # Rails kept throwing errors. So I just put it here.
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def get_active_friends
    active_friends = []
    
    friendships_active = friendships.select { |friendship| friendship.request == "active" }
    friendships_active.each do |friendship|
      active_friends += friends.select { |friend| friend.id == friendship.friend_id }
    end
    reverse_friendships_active = reverse_friendships.select { |friendship| friendship.request == "active" }
    reverse_friendships_active.each do |friendship|
      active_friends += users.select { |friend| friend.id == friendship.user_id }
    end
    
    active_friends.sort! { |a, b| a.name.downcase <=> b.name.downcase }
  end
  
  def get_invited_friends
    invited_friends = []
    
    friendships_invited = friendships.select { |friendship| friendship.request == "pending" }
    friendships_invited.each do |friendship|
      invited_friends += friends.select { |friend| friend.id == friendship.friend_id }
    end
    
    invited_friends.sort! { |a, b| a.name.downcase <=> b.name.downcase }
  end
  
  def get_pending_friends
    pending_friends = []
    
    reverse_friendships_pending = reverse_friendships.select { |friendship| friendship.request == "pending" }
    reverse_friendships_pending.each do |friendship|
      pending_friends += users.select { |friend| friend.id == friendship.user_id }
    end
    
    pending_friends.sort! { |a, b| a.name.downcase <=> b.name.downcase }
  end
  
  private
  
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
  
end