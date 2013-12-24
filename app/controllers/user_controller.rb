class UserController < ApplicationController
  before_filter do
    if !signed_in?
      redirect_to root_url
    end
  end
  
  def show
    @user = current_user
    @games = @user.games_relationships.paginate(page: params[:page], :per_page => 10)
    @friends = @user.get_active_friends
    @pending = @user.get_pending_friends
    @invited = @user.get_invited_friends
    # TODO
  end
  
end