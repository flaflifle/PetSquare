class RelationshipsController < ApplicationController
  #before_filter :signed_in_user
  respond_to :html, :js

  def create
    @user =User.find_by_email(current_user.email)
    @pet = Pet.find(params[:relationship][:followed_id])
    current_user.follow!(@pet)

    respond_with @pet
    # without javascript: redirect_to @user
    #respond_with @pet
    # Rails will look for a create.js.erb file for responding to this action with ajax
  end

  def destroy
    #@user =User.find(current_user)
    @pet = Relationship.find(params[:id]).followed
    current_user.unfollow!(@pet)
=begin
    respond_to do |format|
      format.html { redirect_to @pet }
      format.js
    end
=end
    # without javascript:
    #redirect_to @pet
    respond_with @pet
  end
end
