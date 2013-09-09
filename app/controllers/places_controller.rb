class PlacesController < ApplicationController
  def index
    @places = Place.all
    @json = Place.all.to_gmaps4rails
  end

  def show
    @place= Place.find(params[:id])
    @json = @place.to_gmaps4rails
  end

  def new
    @place = Place.new
    @json = @place.to_gmaps4rails
  end

  def create
    @place = Place.create(params[:place])
    @json = @place.to_gmaps4rails
    if @place.save
      # handle a successful save
      flash[:success] = 'Posto aggiunto con successo!'
      # automatically sign in
      redirect_to @place
    else
      render 'new'
    end

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
