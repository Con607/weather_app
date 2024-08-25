require "application_system_test_case"

class CurrentWeathersTest < ApplicationSystemTestCase
  setup do
    @current_weather = current_weathers(:one)
  end

  test "visiting the index" do
    visit current_weathers_url
    assert_selector "h1", text: "Current weathers"
  end

  test "should create current weather" do
    visit current_weathers_url
    click_on "New current weather"

    fill_in "Latitude", with: @current_weather.latitude
    fill_in "Longitude", with: @current_weather.longitude
    click_on "Create Current weather"

    assert_text "Current weather was successfully created"
    click_on "Back"
  end

  test "should update Current weather" do
    visit current_weather_url(@current_weather)
    click_on "Edit this current weather", match: :first

    fill_in "Latitude", with: @current_weather.latitude
    fill_in "Longitude", with: @current_weather.longitude
    click_on "Update Current weather"

    assert_text "Current weather was successfully updated"
    click_on "Back"
  end

  test "should destroy Current weather" do
    visit current_weather_url(@current_weather)
    click_on "Destroy this current weather", match: :first

    assert_text "Current weather was successfully destroyed"
  end
end
