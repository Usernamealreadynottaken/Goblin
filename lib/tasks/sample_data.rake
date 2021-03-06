namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    
    # USERS WITH FRIENDSHIPS
    user = User.create!(name: "user",
                 email: "user@gmail.com",
                 password: "password",
                 password_confirmation: "password",
                 update_flag: false)
                 
    friend = User.create!(name: "friend",
                 email: "friend@gmail.com",
                 password: "friend",
                 password_confirmation: "friend",
                 update_flag: false)   
                 
    friendship = Friendship.create(user_id: user.id,
                                   friend_id: friend.id,
                                   request: "active")  
                                   
    friend = User.create!(name: "Marco",
                 email: "marco@gmail.com",
                 password: "marcopass",
                 password_confirmation: "marcopass",
                 update_flag: false)
                 
    friendship = Friendship.create(user_id: user.id,
                                   friend_id: friend.id,
                                   request: "active")  
    
    friend = User.create!(name: "Bartolomeo",
                 email: "bart@gmail.com",
                 password: "bartpass",
                 password_confirmation: "bartpass",
                 update_flag: false)
                 
    friendship = Friendship.create(user_id: user.id,
                                   friend_id: friend.id,
                                   request: "pending")
                                   
    friend = User.create!(name: "reverse",
                 email: "reverse@gmail.com",
                 password: "reverse",
                 password_confirmation: "reverse",
                 update_flag: false)
                 
    friendship = Friendship.create(user_id: friend.id,
                                   friend_id: user.id,
                                   request: "pending")

    # Careful when deleting!
    # This user is assigned to a game!                                   
    friend = User.create!(name: "Beatrice",
                 email: "beatrice@gmail.com",
                 password: "beatrice",
                 password_confirmation: "beatrice",
                 update_flag: false)
                 
    friendship = Friendship.create(user_id: friend.id,
                                   friend_id: user.id,
                                   request: "active")
    
    # Careful when deleting!
    # This user is assigned to a game!                               
    friend = User.create!(name: "nofriend",
                 email: "nofriend@gmail.com",
                 password: "nofriend",
                 password_confirmation: "nofriend",
                 update_flag: false)
                 
    # ADVENTURES    
    game = Game.create(name: "Into the Dragon's Lair",
                       description: "Just a single module, not a full campaign; two players are clerics.")
    GamesRelationship.create(user_id: user.id, game_id: game.id, role: "GM")
    
    game = Game.create(name: "Shadows of the Last War",
                       description: "We were arguing whether to play in FR or Eberron, and finally decided on Eberron." )
    GamesRelationship.create(user_id: user.id, game_id: game.id, role: "GM")
    
    game = Game.create(name: "Sons of Gruumsh",
                       description: "All players are elves on a campaign to avenge destruction of their village by
                                     the clerics of Gruumsh")
    GamesRelationship.create(user_id: user.id, game_id: game.id, role: "Player")
    
    # Add some players to the first adventure
    game = Game.first
    
    GamesRelationship.create(user_id: User.find_by_name("Beatrice").id, game_id: game.id, role: "Player")
    GamesRelationship.create(user_id: User.find_by_name("nofriend").id, game_id: game.id, role: "Player") 
    
    # Create some categories for first adventure
    
    cat1 = GameCategory.create(name: "Lair entrance", game_id: game.id)
    cat2 = GameCategory.create(name: "The Lair", game_id: game.id)
    cat3 = GameCategory.create(name: "Pool inside lair", game_id: game.id)
    
    GameCategory.create(name: "Rock besides pool", game_id: game.id)
    
    # Create some items for the first adventure
    
    # Category 1 
    Item.create(name: "Masterwork Longsword",
                properties: "Masterwork",
                description: "A longsword with beautiful handle shaped like two intertwining snakes.",
                identified: true,
                game_category_id: cat1.id,
                user_id: user.id)

    Item.create(name: "Potion (blue)",
                magic_name: "Cure light wounds potion",
                properties: "Cure Light Wounds (level 3)",
                description: "A blue potion.",
                game_category_id: cat1.id,
                user_id: user.id)
                
    # Category 2                
    Item.create(name: "Dragonscale amulet",
                properties: "Absorbs magic missiles (magic missile spell has no effect on wearer)\n" +
                             "+2 AC (enhancement bonus)\n" +
                             "Scales appear on your hands, feet, and neck",
                description: "It's a small dragonscale with a rune carved on it's face, on a silver chain.",
                game_category_id: cat2.id,
                user_id: user.id)

    Item.create(name: "Bone wand",
                magic_name: "Obscuring Mist wand",
                properties: "Obscuring Mist (24 charges)",
                description: "A radius bone of small humanoid with strange marks made with ink.",
                game_category_id: cat2.id,
                user_id: user.id)
                
    Item.create(name: "Dragontooth Dagger",
                properties: "-2 hit\n" +
                            "+3\n" +
                            "+1k6 fire damage\n" +
                            "+1k6 acid damage\n" +
                            "+2 hit if the wearer is of dragon descent (i.e. sorcerer with dragon bloodline," +
                               "or of drgon-descent race)",
                description: "This dagger seems to be crudely fashioned from a handle from another dagger and a dragons tooth. " +
                             "If you look closely you can see that the tooth is covered with a very thin layer of slime of " +
                             "kind. When you hold it you notice that the handle is warm.",
                game_category_id: cat2.id,
                user_id: user.id)
                
    # Category 3
    Item.create(name: "Scarlet Breastplate",
                properties: "+2\n" +
                            "When covered with blood (GM decision, typically when receiving slashing or piercing damage) " +
                            "armors enhancement bonus is increased to +3 until the blood is cleaned or dries (GM decision)",
                description: "A scarlet colored breastplate with white painted tear or drop of some kind on the back.",
                identified: true,
                game_category_id: cat3.id,
                user_id: user.id)                                                                                   
    
  end
end