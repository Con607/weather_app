class AddMissingColumnsToCurrentWeather < ActiveRecord::Migration[7.2]
  def change
    add_column :current_weathers, :name, :string # name
    add_column :current_weathers, :country, :string # sys.country
    add_column :current_weathers, :temperature, :float # main.temp
    add_column :current_weathers, :feels_like, :float # main.feels_like
    add_column :current_weathers, :humidity, :integer # main.humidity
    add_column :current_weathers, :wind_speed, :float # wind.speed
    add_column :current_weathers, :weather_main, :string # weather.main
    add_column :current_weathers, :weather_description, :string # weather.description
    add_column :current_weathers, :full_response, :text # full response
  end
end