class CheckinsController < ApplicationController

  def index

  end

  def new
    #@checkin=Checkin.new
  end

  def create
    @place = Place.find(params[:place_id])
    @checkin=@place.checkins.build(params[:checkin])
    @checkin.user_id=current_user.id
    if @checkin.save
      # handle a successful save
      flash[:success] = 'Checkin created'
      @pet=Pet.find(@checkin.pet_id)
      redirect_to @pet
    else
      @feed_items = []
      render 'new'
    end
  end

  def show
  end

end
