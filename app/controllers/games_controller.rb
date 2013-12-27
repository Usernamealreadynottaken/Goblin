class GamesController < ApplicationController
  before_filter do
    if !signed_in?
      redirect_to root_url
    end
  end
  
  before_filter only: :show do
    if !Game.find(params[:id]).users.include? current_user
      redirect_to profile_path, flash: { error: "You can't view games you do not participate in." }
    end
  end
  
  def show
    @game = Game.find(params[:id])
  end
  
  def update_category_in_item
    render :nothing => true
    item = Item.find(params[:item_id])
    item.update_attribute(:game_category_id, params[:category_id])
  end
  
end