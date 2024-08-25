require "test_helper"

class CurrentWeathersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @current_weather = current_weathers(:one)
  end

  test "should get index" do
    get current_weathers_url
    assert_response :success
  end

  test "should get new" do
    get new_current_weather_url
    assert_response :success
  end

  test "should create current_weather" do
    assert_difference("CurrentWeather.count") do
      post current_weathers_url, params: { current_weather: { latitude: @current_weather.latitude, longitude: @current_weather.longitude } }
    end

    assert_redirected_to current_weather_url(CurrentWeather.last)
  end

  test "should show current_weather" do
    get current_weather_url(@current_weather)
    assert_response :success
  end

  test "should get edit" do
    get edit_current_weather_url(@current_weather)
    assert_response :success
  end

  test "should update current_weather" do
    patch current_weather_url(@current_weather), params: { current_weather: { latitude: @current_weather.latitude, longitude: @current_weather.longitude } }
    assert_redirected_to current_weather_url(@current_weather)
  end

  test "should destroy current_weather" do
    assert_difference("CurrentWeather.count", -1) do
      delete current_weather_url(@current_weather)
    end

    assert_redirected_to current_weathers_url
  end
end
