class SessionsController < ApplicationController
  before_filter only: :new do
    if signed_in?
      redirect_to profile_path
    end
  end
 
  def new
  end
  
  def create
    user = User.find_by_email(params[:session][:user].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to profile_path
    else
      flash.now[:error] = 'Invalid email/password combination.'
      render 'new'
    end
  end
  
  def destroy
    sign_out
    redirect_to root_url
  end
  
end