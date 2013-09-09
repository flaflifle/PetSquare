class PlacesController < ApplicationController
  def index
    @places = Place.all
    @json = Place.all.to_gmaps4rails
  end

  def show
    @place= Place.find(params[:id])
    @json = @place.to_gmaps4rails
  end

  def search
    if params[:search_name].empty? && params[:search_cat].empty?
      flash.now[:pippo] = "almeno uno dei campi deve essere pieno"
      #@places = Place.scoped
      render 'places/search_form'
    else
    @places = Place.search(params[:search_name], params[:search_cat])
    end
  end
end
