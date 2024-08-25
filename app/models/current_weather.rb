class CurrentWeather < ApplicationRecord
  include Services::OpenWeather

  validates :latitude, :longitude, presence: true
  validates :latitude, :longitude, numericality: true

  def self.by_location(latitude, longitude)
    where(latitude: latitude, longitude: longitude).first_or_initialize
  end

  def fetch_weather_by_location
    current_weather_by_location(latitude, longitude)
  end
end
