class UserController < ApplicationController
  before_filter do
    if !signed_in?
      redirect_to root_url
    end
  end
  
  def show
    @user = current_user
    @games = @user.games_relationships.paginate(page: params[:page], :per_page => 10)
    @friends = (@user.users + @user.friends).sort! { |a, b| a.name.downcase <=> b.name.downcase };
    # TODO
  end
  
end