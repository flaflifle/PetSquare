class PlacesController < ApplicationController
  def index
    @places = Place.all
    @json = Place.all.to_gmaps4rails
  end

  def show
  end
end
