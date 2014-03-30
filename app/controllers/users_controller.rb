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
      elsif valid_phone?
        redirect_to root_path, notice: "Welcome #{@user.username}, a text has been sent to your phone</br> &nbsp;&nbsp;&nbsp; * Please verify you received the text before logging out".html_safe
      else
        render :new
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
        redirect_to user_path(@user), notice: "#{@user.username}, your profile was successfully updated"
      elsif valid_phone?
        redirect_to user_path(@user), notice: "#{@user.username}, a text has been sent to your phone</br>&nbsp;&nbsp;&nbsp; * Please verify you received the text before logging out".html_safe
      else
        render :edit
      end

    else
      render :edit
    end

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

  def valid_phone?
    errors = @user.send_msg_to_phone "Hello #{@user.username}, if you received this text your phone number is verified."
    if errors.any?
      @user.phone = nil
      flash[:error] = "Something is wrong with your phone number"
    end
    !errors.any?
  end

end
