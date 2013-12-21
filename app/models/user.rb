class User < ActiveRecord::Base
  
  # FIELD ACCESS
  attr_accessible :name, :email, :password, :password_confirmation
  before_save { self.email = email.downcase }

  # FIELD VALIDATION
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  # Method has_secure_password automatically validates for :password presence and :password_digest,
  # and confirms if :password_confirmation = :password                     
  validates :password, length: { minimum: 6 }                    
                    
  # Add entire password handling/validation using one command because Rails                      
  has_secure_password
  
end
