class PetsController < ApplicationController
  before_filter :signed_in_user
  # check if the user is allowed to delete a post
  before_filter :correct_user, only: [:destroy, :edit, :update]


  def index
    @pets=@user.pets
  end

  def show
    @pet=Pet.find(params[:id])
  end

  def new
    @pet=Pet.new
  end

  def create
    #@user =User.find(current_user)
    @pet=current_user.pets.build(params[:pet])
    if @pet.save
      # handle a successful save
      flash[:success] = 'Pet profilo created'
      redirect_to @pet
    else
      @feed_items = []
      render 'new'
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    @pet = Pet.find(params[:id])
    if @pet.update_attributes(params[:pet])
      # handle a successful update
      flash[:success] = 'Profile updated'
      # go to the user profile
      redirect_to @pet
    else
      render 'edit'
    end
  end

  def destroy
    @pet.destroy
    redirect_to root_url
  end

  def followers
    @title = "Followers"
    @pet = Pet.find(params[:id])
    @users = @pet.follower_users
    render 'show_follow'
  end

  def search
    @pets = Pet.search(params[:search])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def pet_params
    params.require(:pet).permit(:namePet, :breed, :description)
  end

  # Take the current user information (id) and redirect her to the home page if she is not the 'right' user
  def correct_user
    @pet = current_user.pet.find_by(id: params[:id])
    redirect_to root_url if @pet.nil?
  end

  # Redirect the user to the home page is she is not an admin (e.g., if the user cannot perform an admin-only operation)
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
