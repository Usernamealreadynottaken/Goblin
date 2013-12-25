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
  
end