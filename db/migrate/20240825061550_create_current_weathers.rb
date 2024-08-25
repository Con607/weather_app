class CreateCurrentWeathers < ActiveRecord::Migration[7.2]
  def change
    create_table :current_weathers do |t|
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
