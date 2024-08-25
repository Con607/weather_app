class CurrentWeather < ApplicationRecord
  include Services::OpenWeather

  before_create :fetch_weather_by_location

  validates :latitude, :longitude, presence: true
  validates :latitude, :longitude, numericality: true

  def self.by_location(latitude, longitude)
    record = where(latitude: latitude, longitude: longitude).where('created_at > ?', Time.now.utc - 1.hour).first_or_initialize
    unless record.persisted?
      record.save
    end
    record
  end

  private

  def fetch_weather_by_location
    response = current_weather_by_location(latitude, longitude)
    save_weather(response)
  end

  def save_weather(response)
    self.name = response['name']
    self.country = response['sys']['country']
    self.temperature = response['main']['temp']
    self.feels_like = response['main']['feels_like']
    self.humidity = response['main']['humidity']
    self.wind_speed = response['wind']['speed']
    self.weather_main = response['weather'].first['main']
    self.weather_description = response['weather'].first['description']
    self.full_response = response.to_json
  end
end
