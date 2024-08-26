class AddIconToCurrentWeather < ActiveRecord::Migration[7.2]
  def change
    add_column :current_weathers, :icon, :string
  end
end
