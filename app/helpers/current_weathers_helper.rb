module CurrentWeathersHelper
  def weather_icon(icon_name)
    icon_url = "https://openweathermap.org/img/wn/#{icon_name}@2x.png"
    image_tag(icon_url, alt: 'Weather icon', class: 'w-40 h-40')
  end
end
