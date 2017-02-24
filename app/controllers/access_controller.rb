class AccessController < ApplicationController

  layout 'admin'

  before_action :confirm_logged_in,
    :except => [:login, :attempt_login, :logout]

  def index
    # Display text & links
  end

  def login
    # login form
  end

  def attempt_login
    if params[:username].present? && params[:password].present?
      user_found = AdminUser.where(
        username: params[:username]
      ).first

      if user_found
        authorized_user = user_found.authenticate(
        params[:password])
      end
    end
    if authorized_user
      # Mark user as logged in
      session[:user_id] = authorized_user.id
      session[:user_name] = authorized_user.username

      flash[:notice] = "You are now logged in."
      redirect_to(action: 'index')
    else
      flash[:notice] = "Invalid username/password."
      redirect_to(action: 'login')
    end
  end

  def logout
    # Mark user as logged out
    session[:user_id] = nil
    session[:user_name] = nil

    flash[:notice] = "Logged out"
    redirect_to(action: 'login')
  end
  
end
