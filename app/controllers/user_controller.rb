class UserController < ApplicationController
  before_filter do
    if !signed_in?
      redirect_to root_url
    end
  end
  
  def show
    @games = @user.games_relationships.paginate(page: params[:page], :per_page => 10)
  end
  
  def get_update_flag
    user = User.find(params[:id])
    update_flag = user.update_flag
    render json: { update: update_flag }
    user.update_attribute(:update_flag, false)
  end
  
end