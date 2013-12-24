class Item < ActiveRecord::Base
  
  # FIELD ACEESS
  attr_accessible :name, :magic_name, :properties, :description, :identified,
                  :user_id, :game_category_id
  
  # RELATIONSHIPS
  belongs_to :game_category
  belongs_to :user
  
end