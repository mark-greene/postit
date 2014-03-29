class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      session[:user_id] = @user.id
      if @user.phone.blank?
        redirect_to root_path, notice: "Welcome #{@user.username}, you are registered"
      else
        session[:two_factor] = true
        @user.generate_pin!
        errors = @user.send_pin_to_phone
        if !errors.any?
          redirect_to pin_path
        else
          @user.phone = nil
          flash[:error] = "Something is wrong with your phone number"
          render :new
        end
      end
    else
      render :new
    end

  end

  def edit
  end

  def  update
    if @user.update user_params

      if @user.phone.blank?
        redirect_to user_path(@user), notice: "Your profile was successfully updated"
      else
        session[:two_factor] = true
        @user.generate_pin!
        errors = @user.send_pin_to_phone
        if !errors.any?
          redirect_to pin_path
        else
          @user.phone = nil
          flash[:error] = "Something is wrong with your phone number"
          render :edit
        end
      end

    else
      render :edit
    end

  end

  def destroy

  end

private

  def user_params
    params.require(:user).permit(:username, :password, :phone, :timezone)
  end

  def set_user
    @user = User.find_by slug: params[:id]
  end

  def require_same_user
    if current_user != @user
      redirect_to root_path ,alert:  "Access denied for user #{current_user.username}"
    end
  end

end
