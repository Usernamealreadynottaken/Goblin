class GameCategoriesController < ApplicationController
  
  def add
    pcat = params[:category]
    if pcat[:game_id]
      game = Game.find(pcat[:game_id])
      cat = GameCategory.create(name: pcat[:name],
                                game_id: game.id)
      pcat[:id] = cat.id
      pcat[:mode] = "add"
      render json: pcat
    end
    "fail"
  end
  
  def update
    pcat = params[:category]
    if pcat[:id]
      cat = GameCategory.find(pcat[:id])
      cat.update_attribute(:name, pcat[:name])
      cat.save
      pcat[:mode] = "edit"
      render json: pcat
    end
    "fail"
  end
  
  def delete
    begin
      cat = GameCategory.find(params[:id])
      cat.destroy
      render json: { id: params[:id], deleting: "category" }
    rescue
      "fail"      
    end
  end
  
end
