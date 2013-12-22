namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    
    # Create 1 user and 3 adventures
    user = User.create!(name: "user",
                 email: "user@gmail.com",
                 password: "password",
                 password_confirmation: "password")
    
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
    
  end
end