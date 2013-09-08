class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index, :destroy]
  # check if the current user is the correct user (e.g., for editing only his information)
  before_filter :correct_user, only: [:edit, :update]
  # check if the current user is also an admin
  before_filter :admin_user, only: :destroy


  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @pets= @user.pets
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      # handle a successful save
      flash[:success] = 'Welcome to PetSquare!'
      # automatically sign in
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
   @user = User.find(params[:id])
   if @user.update_attributes(user_params)
     flash[:success] = "Profile updated"
     sign_in @user
     redirect_to @user
   else
     render 'edit'
   end
  end


  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      # handle a successful update
      flash[:success] = 'Profile updated'
      # re-login the user
      sign_in @user
      # go to the user profile
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted!'
    redirect_to users_url
  end

  def pets
    @user = User.find(params[:id])
    @pets = Pet.find_all_by_user_id(@user.id)
    render 'pets/index'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Before filters

  # Redirect the user to the Sign in page if she is not logged in
  def signed_in_user
    redirect_to signin_url, notice: 'Please sign in' unless signed_in?
    # notice: 'Please sign in' is the same of flash[:notice] = 'Please sign in'

  end

  # Take the current user information (id) and redirect her to the home page if she is not the 'right' user
  def correct_user
    # init the user object to be used in the edit and update actions
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user) # the current_user?(user) method is defined in the SessionsHelper
  end

  # Redirect the user to the home page is she is not an admin (e.g., if the user cannot perform an admin-only operation)
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end



end
