class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by username: params[:username]

    if user && user.authenticate(params[:password])
      if user.two_factor_auth?
        session[:two_factor] = true
        user.generate_pin!
        errors = user.send_pin_to_phone
        if errors.any?
          redirect_to login_path, alert: "Something is wrong with your phone number. Your pin was not sent."
        else
          redirect_to pin_path
        end
      else
        login_user!(user)
      end
    else
      redirect_to login_path, alert: "Something is wrong with your username or password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You've logged out"
  end

  def pin
    access_denied if session[:two_factor].nil?

    if request.post?
      user = User.find_by pin: params[:pin]
      if user
        session[:two_factor] = nil
        user.remove_pin!
        login_user!(user)
      else
        flash[:error] = "Something is wrong with your pin"
      end
    end
  end

private

  def login_user!(user)
    session[:user_id] = user.id
    redirect_to root_path, notice: "Welcome, you are logged in"
  end

end
