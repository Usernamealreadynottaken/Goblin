class User < ActiveRecord::Base
  
  # FIELD ACCESS
  attr_accessible :name, :email, :password, :password_confirmation
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

  # Method has_secure_password automatically validates for :password presence and :password_digest,
  # and confirms if :password_confirmation = :password                     
  validates :password, length: { minimum: 6 }                    
                    
  # Add entire password handling/validation using one command because Rails                      
  has_secure_password
  
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
  
  private
  
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
  
end