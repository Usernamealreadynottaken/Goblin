class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  # Because header (and therefore some user data) is visible on every page
  # make these variables available throughout entire application (provided you're
  # signed in!)
  before_filter do
    if signed_in?
      @user = current_user
      @friends = @user.get_active_friends
      @pending = @user.get_pending_friends
      @invited = @user.get_invited_friends
    end
  end
end