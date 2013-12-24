namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    
    # Create 3 user and 3 adventures
    user = User.create!(name: "user",
                 email: "user@gmail.com",
                 password: "password",
                 password_confirmation: "password")
                 
    friend = User.create!(name: "friend",
                 email: "friend@gmail.com",
                 password: "friend",
                 password_confirmation: "friend")   
                 
    friendship = Friendship.create(user_id: user.id,
                                   friend_id: friend.id,
                                   request: "active")  
                                   
    friend = User.create!(name: "Marco",
                 email: "marco@gmail.com",
                 password: "marcopass",
                 password_confirmation: "marcopass")
                 
    friendship = Friendship.create(user_id: user.id,
                                   friend_id: friend.id,
                                   request: "active")  
    
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
    
    # Create some categories for first adventure
    game = Game.first
    
    cat1 = GameCategory.create(name: "Lair entrance", game_id: game.id)
    cat2 = GameCategory.create(name: "The Lair", game_id: game.id)
    cat3 = GameCategory.create(name: "Pool inside lair", game_id: game.id)
    
    # Create some items for the first adventure
    
    # Category 1 
    Item.create(name: "Masterwork Longsword",
                properties: "Masterwork",
                description: "A longsword with beautiful handle shaped like two intertwining snakes.",
                identified: true,
                game_category_id: cat1.id,
                user_id: user.id)

    Item.create(name: "Potion (blue)",
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
                            "When covered with blood (GM decision, typically when receiving slashing or piercing damage)" +
                            "armors enhancement bonus is increased to +3 until the blood is cleaned or dries (GM decision)",
                description: "A scarlet colored breastplate with white painted tear or drop of some kind on the back.",
                identified: true,
                game_category_id: cat3.id,
                user_id: user.id)                                                                                   
    
  end
end