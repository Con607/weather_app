Geocoder.configure(
  timeout: 5,
  lookup: :geoapify,
  api_key: Rails.application.credentials.geoapify[:api_key],
  units: :km,
  use_https: true
)