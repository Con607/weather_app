class CurrentWeather < ApplicationRecord
  validates :latitude, :longitude, presence: true
  validates :latitude, :longitude, numericality: true
end
