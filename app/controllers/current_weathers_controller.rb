class CurrentWeathersController < ApplicationController
  before_action :set_current_weather, only: %i[ show edit update destroy ]

  def dashboard
    if params[:city]
      @current_weather = CurrentWeather.by_city(params[:city])
    elsif params[:latitude] && params[:longitude]
      @current_weather = CurrentWeather.by_location(params[:latitude], params[:longitude])
    end

    respond_to do |format|
      format.html
    end
  end

  def geolocation
    location = Geocoder.search([params[:latitude], params[:longitude]]).first
    render json: location.data
  end

  # GET /current_weathers or /current_weathers.json
  def index
    @current_weathers = CurrentWeather.all
  end

  # GET /current_weathers/1 or /current_weathers/1.json
  def show
  end

  # GET /current_weathers/new
  def new
    @current_weather = CurrentWeather.new
  end

  # GET /current_weathers/1/edit
  def edit
  end

  # POST /current_weathers or /current_weathers.json
  def create
    @current_weather = CurrentWeather.new(current_weather_params)

    respond_to do |format|
      if @current_weather.save
        format.html { redirect_to current_weather_url(@current_weather), notice: "Current weather was successfully created." }
        format.json { render :show, status: :created, location: @current_weather }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @current_weather.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /current_weathers/1 or /current_weathers/1.json
  def update
    respond_to do |format|
      if @current_weather.update(current_weather_params)
        format.html { redirect_to current_weather_url(@current_weather), notice: "Current weather was successfully updated." }
        format.json { render :show, status: :ok, location: @current_weather }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @current_weather.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /current_weathers/1 or /current_weathers/1.json
  def destroy
    @current_weather.destroy!

    respond_to do |format|
      format.html { redirect_to current_weathers_url, notice: "Current weather was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_current_weather
      @current_weather = CurrentWeather.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def current_weather_params
      params.require(:current_weather).permit(:latitude, :longitude)
    end
end
