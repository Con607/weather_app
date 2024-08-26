class CurrentWeather < ApplicationRecord
  include Services::OpenWeather

  validates :latitude, :longitude, presence: true
  validates :latitude, :longitude, numericality: true

  def self.by_location(latitude, longitude)
    record = where(latitude: latitude, longitude: longitude).where('created_at > ?', Time.now.utc - 1.hour).first_or_initialize
    unless record.persisted?
      response = current_weather_by_location(latitude, longitude)
      record.save_weather(response)
      record.save
    end
    record
  end

  def self.by_city(city)
    record = where('name LIKE ?', '%' + city + '%').where('created_at > ?', Time.now.utc - 1.hour).first_or_initialize
    unless record.persisted?
      response = current_weather_by_city(city)
      record.save_weather(response)
      record.save
    end
    record
  end

  def save_weather(response)
    self.name = response['name']
    self.latitude = response['coord']['lat']
    self.longitude = response['coord']['lon']
    self.country = response['sys']['country']
    self.temperature = response['main']['temp']
    self.feels_like = response['main']['feels_like']
    self.humidity = response['main']['humidity']
    self.wind_speed = response['wind']['speed']
    self.weather_main = response['weather'].first['main']
    self.weather_description = response['weather'].first['description']
    self.icon = response['weather'].first['icon']
    self.temp_min = response['main']['temp_min']
    self.temp_max = response['main']['temp_max']
    self.full_response = response.to_json
  end
end
