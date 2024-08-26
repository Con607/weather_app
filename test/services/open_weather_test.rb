require 'test_helper'
require 'webmock/minitest'

module Services
  module OpenWeatherTest
    # TODO: Write tests for OpenWeather
    # describe 'OpenWeather' do
    #   it 'should request the url with the correct latitude and longitude' do
    #     latitude = 1
    #     longitude = 2
    #     api_key = '123'
    #     url = "https://api.openweathermap.org/data/2.5/weather?lat=#{latitude}&lon=#{longitude}&appid=#{api_key}"
        
    #     HTTParty.stub :get, OpenStruct.new(body: '{}') do
    #       Services::OpenWeather.current_weather_by_location(latitude, longitude)
    #     end
    #     assert_requested :get, url
    #   end
    # end
  end
end