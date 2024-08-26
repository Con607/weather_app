require "test_helper"

class CurrentWeatherTest < ActiveSupport::TestCase
  test "should not save current_weather without latitude" do
    current_weather = CurrentWeather.new
    assert_not current_weather.save, "Saved the current_weather without a latitude"
  end

  test "should not save current_weather without longitude" do
    current_weather = CurrentWeather.new
    assert_not current_weather.save, "Saved the current_weather without a longitude"
  end

  test "should save current_weather with latitude and longitude" do
    current_weather = CurrentWeather.new(latitude: 1.0, longitude: 1.0)
    assert current_weather.save, "Did not save the current_weather with latitude and longitude"
  end

  test "should not save current_weather with non-numeric latitude" do
    current_weather = CurrentWeather.new(latitude: 'a', longitude: 1.0)
    assert_not current_weather.save, "Saved the current_weather with non-numeric latitude"
  end

  test "should not save current_weather with non-numeric longitude" do
    current_weather = CurrentWeather.new(latitude: 1.0, longitude: 'a')
    assert_not current_weather.save, "Saved the current_weather with non-numeric longitude"
  end

  describe "#by_location" do
    before do
      @mock_weather_data = {
      "coord"=>{"lon"=>-45.5878, "lat"=>76.5088},
      "weather"=>[{"id"=>800, "main"=>"Clear", "description"=>"clear sky", "icon"=>"01d"}],
      "base"=>"stations",
      "main"=>
       {"temp"=>296.61,
        "feels_like"=>297.05,
        "temp_min"=>294.4,
        "temp_max"=>297.83,
        "pressure"=>1021,
        "humidity"=>78,
        "sea_level"=>1021,
        "grnd_level"=>1018},
      "visibility"=>10000,
      "wind"=>{"speed"=>1.09, "deg"=>259, "gust"=>1.06},
      "clouds"=>{"all"=>6},
      "dt"=>1724685189,
      "sys"=>{"type"=>2, "id"=>2013133, "country"=>"CA", "sunrise"=>1724666950, "sunset"=>1724715799},
      "timezone"=>-14400,
      "id"=>6077243,
      "name"=>"Montreal",
      "cod"=>200}
    end

    it "should return a new record when no record exists" do
      latitude = @mock_weather_data['coord']['lat']
      longitude = @mock_weather_data['coord']['lon']
      CurrentWeather.stub :current_weather_by_location, @mock_weather_data do
        result = CurrentWeather.by_location(latitude, longitude)
        assert result.persisted?
      end
    end

    it "should return the existing record when it already exists" do
      latitude = @mock_weather_data['coord']['lat']
      longitude = @mock_weather_data['coord']['lon']
      CurrentWeather.stub :current_weather_by_location, @mock_weather_data do
        CurrentWeather.by_location(latitude, longitude)
      end

      count = CurrentWeather.count
      CurrentWeather.by_location(latitude, longitude)

      assert_equal count, CurrentWeather.count
    end

    it "should return a new record when it was created more than an hour ago" do
      latitude = @mock_weather_data['coord']['lat']
      longitude = @mock_weather_data['coord']['lon']
      weather = nil
      CurrentWeather.stub :current_weather_by_location, @mock_weather_data do
        weather = CurrentWeather.by_location(latitude, longitude)
      end

      count = CurrentWeather.count
      weather.update(created_at: Time.now.utc - 2.hours)
      CurrentWeather.stub :current_weather_by_location, @mock_weather_data do
        CurrentWeather.by_location(latitude, longitude)
      end

      assert_equal count + 1, CurrentWeather.count
    end
  end

  describe "#by_city" do
    before do
      @mock_weather_data = {
      "coord"=>{"lon"=>-45.5878, "lat"=>76.5088},
      "weather"=>[{"id"=>800, "main"=>"Clear", "description"=>"clear sky", "icon"=>"01d"}],
      "base"=>"stations",
      "main"=>
       {"temp"=>296.61,
        "feels_like"=>297.05,
        "temp_min"=>294.4,
        "temp_max"=>297.83,
        "pressure"=>1021,
        "humidity"=>78,
        "sea_level"=>1021,
        "grnd_level"=>1018},
      "visibility"=>10000,
      "wind"=>{"speed"=>1.09, "deg"=>259, "gust"=>1.06},
      "clouds"=>{"all"=>6},
      "dt"=>1724685189,
      "sys"=>{"type"=>2, "id"=>2013133, "country"=>"CA", "sunrise"=>1724666950, "sunset"=>1724715799},
      "timezone"=>-14400,
      "id"=>6077243,
      "name"=>"Vancouver",
      "cod"=>200}
    end

    it "should return a new record when no record exists" do
      city = @mock_weather_data['name']
      CurrentWeather.stub :current_weather_by_city, @mock_weather_data do
        result = CurrentWeather.by_city(city)
        assert result.persisted?
      end
    end

    it "should return the existing record when it already exists" do
      city = @mock_weather_data['name']
      CurrentWeather.stub :current_weather_by_city, @mock_weather_data do
        CurrentWeather.by_city(city)
      end

      count = CurrentWeather.count
      CurrentWeather.by_city(city)

      assert_equal count, CurrentWeather.count
    end

    it "should return a new record when it was created more than an hour ago" do
      city = @mock_weather_data['name']
      weather = nil
      CurrentWeather.stub :current_weather_by_city, @mock_weather_data do
        weather = CurrentWeather.by_city(city)
      end

      count = CurrentWeather.count
      weather.update(created_at: Time.now.utc - 2.hours)
      CurrentWeather.stub :current_weather_by_city, @mock_weather_data do
        CurrentWeather.by_city(city)
      end

      assert_equal count + 1, CurrentWeather.count
    end
  end

  describe "#save_weather" do
    before do
      @mock_weather_data = {
      "coord"=>{"lon"=>-45.5878, "lat"=>76.5088},
      "weather"=>[{"id"=>800, "main"=>"Clear", "description"=>"clear sky", "icon"=>"01d"}],
      "base"=>"stations",
      "main"=>
       {"temp"=>296.61,
        "feels_like"=>297.05,
        "temp_min"=>294.4,
        "temp_max"=>297.83,
        "pressure"=>1021,
        "humidity"=>78,
        "sea_level"=>1021,
        "grnd_level"=>1018},
      "visibility"=>10000,
      "wind"=>{"speed"=>1.09, "deg"=>259, "gust"=>1.06},
      "clouds"=>{"all"=>6},
      "dt"=>1724685189,
      "sys"=>{"type"=>2, "id"=>2013133, "country"=>"CA", "sunrise"=>1724666950, "sunset"=>1724715799},
      "timezone"=>-14400,
      "id"=>6077243,
      "name"=>"Vancouver",
      "cod"=>200}
    end

    it "should save the weather data to the record" do
      current_weather = CurrentWeather.new
      current_weather.save_weather(@mock_weather_data)

      assert_equal @mock_weather_data['name'], current_weather.name
      assert_equal @mock_weather_data['coord']['lat'], current_weather.latitude
      assert_equal @mock_weather_data['coord']['lon'], current_weather.longitude
      assert_equal @mock_weather_data['sys']['country'], current_weather.country
      assert_equal @mock_weather_data['main']['temp'], current_weather.temperature
      assert_equal @mock_weather_data['main']['feels_like'], current_weather.feels_like
      assert_equal @mock_weather_data['main']['humidity'], current_weather.humidity
      assert_equal @mock_weather_data['wind']['speed'], current_weather.wind_speed
      assert_equal @mock_weather_data['weather'].first['main'], current_weather.weather_main
      assert_equal @mock_weather_data['weather'].first['description'], current_weather.weather_description
      assert_equal @mock_weather_data['weather'].first['icon'], current_weather.icon
      assert_equal @mock_weather_data['main']['temp_min'], current_weather.temp_min
      assert_equal @mock_weather_data['main']['temp_max'], current_weather.temp_max
      assert_equal @mock_weather_data.to_json, current_weather.full_response
    end
  end
end
