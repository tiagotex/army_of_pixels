class SessionsController < ApplicationController
  skip_before_filter :authenticate!

  def new
    if params['user_token']
      session[:converting] = true
      session[:user_token] = params['user_token']
    end

    redirect_to :root if signed_in?
  end

  def create
    authenticate!
    redirect_to :root
  end

  def destroy
    warden.logout
    redirect_to :root
  end
end
