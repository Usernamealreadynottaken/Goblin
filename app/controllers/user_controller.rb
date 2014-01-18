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
    render :json => { 
      :update => update_flag,
      :projects => render_to_string( 
        :partial => 'layouts/friends',
        :locals => { 
          :user => user,
          :friends => user.get_active_friends,
          :pending => user.get_pending_friends,
          :invited => user.get_invited_friends }) }, 
        :status => :ok
    user.update_attribute(:update_flag, false)
  end
  
  def create_friendship
    user = User.find(params[:id])
    friend = User.find(:first, :conditions => [
      'name = ?', params[:friend_name]
    ])
    if friend != nil
      friendship = Friendship.find(:first, :conditions => [
        '(user_id = ? AND friend_id = ?) OR (user_id = ? AND friend_id = ?)',
        user.id, friend.id, friend.id, user.id
      ])
      result = (true if (friendship == nil)) || "You have already befriended that Nerd."
    else
      result = "Can't invite ghosts!"
    end
    
    if (result == true)
      Friendship.create(user_id: user.id, friend_id: friend.id, request: "pending")
      set_friendship_flags(user, friend)
    end
    
    render :json => {
      :result => result
    }
  end
  
  def remove_friendship
    render :nothing => true
    friendship = Friendship.find(:all, :conditions => [
      '(user_id = ? AND friend_id = ?) OR (user_id = ? AND friend_id = ?)',
      params[:id], params[:friend_id], params[:friend_id], params[:id]
    ]).first
    friendship.destroy
    user = User.find(params[:id])
    friend = User.find(params[:friend_id])
    set_friendship_flags(user, friend)
  end
  
  protected
  def set_friendship_flags(user, friend)
    user.update_attribute(:update_flag, true)
    friend.update_attribute(:update_flag, true)
  end
  
end
