class ReviewsController < ApplicationController
  def index
  end

  def show
  end

  def destroy
  end

  def new
  end

  def create
    @place = Place.find(params[:place_id])
    @user=current_user
    @review = @place.reviews.build(params[:review])
    @review.user=@user
    @review.save
    redirect_to place_path(@place)
  end
end
