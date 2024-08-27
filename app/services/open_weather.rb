module Services
  module OpenWeather
    CURRENT_WEATHER_URL = 'https://api.openweathermap.org/data/2.5/weather?units=imperial'.freeze

    def current_weather_by_location(latitude, longitude)
      url = CURRENT_WEATHER_URL + "&lat=#{latitude}&lon=#{longitude}&appid=#{api_key}"
      response = HTTParty.get(url)
      JSON.parse(response.body)
    end

    def current_weather_by_city(city)
      url = CURRENT_WEATHER_URL + "&q=#{city}&appid=#{api_key}"
      response = HTTParty.get(url)
      JSON.parse(response.body)
    end

    def self.included(base)
      base.extend OpenWeather
    end

    private

    def api_key
      Rails.application.credentials.open_weather_api_key
    end
  end
end