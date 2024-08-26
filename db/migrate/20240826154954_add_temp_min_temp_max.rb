class AddTempMinTempMax < ActiveRecord::Migration[7.2]
  def change
    add_column :current_weathers, :temp_min, :float
    add_column :current_weathers, :temp_max, :float
  end
end
