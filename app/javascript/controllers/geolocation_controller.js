import { Controller } from "@hotwired/stimulus"

const options = {
  enableHighAccuracy: true,
  timeout: 5000,
  maximumAge: 0
};

// Connects to data-controller="geolocation"
export default class extends Controller {
  static targets = [ "searchWeather" ]

  handleClick() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(this.getLocation.bind(this), this.showError.bind(this));
    } else {
      console.log("Geolocation is not supported by this browser.");
    }
  }

  getLocation(position) {
    console.log("Latitude: " + position.coords.latitude + " Longitude: " + position.coords.longitude);

    // Send the data to the server
    const url = "geolocation";
    const data = { latitude: position.coords.latitude, longitude: position.coords.longitude };
    console.log(data);
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

    fetch(url, {
      method: "POST",
      headers: {
        'Content-Type': 'application/json',
        "X-CSRF-Token": csrfToken
      },
      body: JSON.stringify(data)
    })
    .then(response => response.json())
    .then((data) => {
      console.log(data);
      if (data.properties.city) {
        this.searchWeatherTarget.value = data.properties.city;
      }
    })
    .catch((error) => {
      console.error("Error:", error);
    });
  }

  showError(error) {
    switch(error.code) {
      case error.PERMISSION_DENIED:
        console.log("User denied the request for Geolocation.");
        break;
      case error.POSITION_UNAVAILABLE:
        console.log("Location information is unavailable.");
        break;
      case error.TIMEOUT:
        console.log("The request to get user location timed out.");
        break;
      case error.UNKNOWN_ERROR:
        console.log("An unknown error occurred.");
        break;
    }
  }
}
