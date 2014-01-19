class ItemsController < ApplicationController
  
  def add
    pitem = params[:item]
    if pitem[:category_id]
      category = GameCategory.find(pitem[:category_id])
      identified_b = true
      identified_b = false if pitem[:identified] == "0"
      item = Item.create(name: pitem[:name],
                         magic_name: pitem[:magic_name],
                         properties: pitem[:properties],
                         description: pitem[:description],
                         identified: identified_b,
                         game_category_id: category.id,
                         user_id: category.game.gm.id)
      pitem[:id] = item.id
      pitem[:mode] = "add"
      render json: pitem
    end
    "fail"
  end
  
  def update
    pitem = params[:item]
    if pitem[:id]
      item = Item.find(pitem[:id])
      identified_b = true
      identified_b = false if pitem[:identified] == "0"
      item.update_attributes(name: pitem[:name],
                             magic_name: pitem[:magic_name],
                             properties: pitem[:properties],
                             description: pitem[:description],
                             identified: identified_b)
      item.save
      pitem[:mode] = "edit"
      render json: pitem
    end
    "fail"
  end
  
  def delete
    begin
      item = Item.find(params[:id])
      item.destroy
      render json: { id: params[:id], deleting: "item" }
    rescue
      "fail"
    end
  end
  
end