json.extract! current_weather, :id, :latitude, :longitude, :created_at, :updated_at
json.url current_weather_url(current_weather, format: :json)
