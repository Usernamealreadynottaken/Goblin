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
    render json: { 
      update: update_flag,
      current_user: user,
      friends: user.get_active_friends,
      pending: user.get_pending_friends,
      invited: user.get_invited_friends
    }
    user.update_attribute(:update_flag, false)
  end
  
  def remove_friendship
    render :nothing => true
    friendship = Friendship.find(:all, :conditions => [
      '(user_id = ? AND friend_id = ?) OR (user_id = ? AND friend_id = ?)',
      params[:id], params[:friend_id], params[:friend_id], params[:id]
    ]).first
    friendship.destroy
    user = User.find(params[:id])
    user.update_attribute(:update_flag, true)
  end
  
end