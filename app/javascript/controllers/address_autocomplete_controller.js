import { Controller } from "@hotwired/stimulus";
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder";

export default class extends Controller {
  static values = { apiKey: String };
  static targets = ["address"];

  connect() {
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      countries: 'fr',
      types: "country,region,place,postcode,locality,neighborhood,address,poi"
    });
    this.geocoder.addTo(this.element);
    this.geocoder.on("result", event => this.#setInputValue(event));
    this.geocoder.on("clear", () => this.#clearInputValue());

    // Get the search icon element
    this.searchIcon = this.element.querySelector(".mapboxgl-ctrl-geocoder--icon-search");

    // Get the pin-right element
    this.pinRightElement = this.element.querySelector(".mapboxgl-ctrl-geocoder--pin-right");

    // Hide the search icon and pin-right element initially
    this.#toggleSearchIcon(false);
    this.#togglePinRightElement(false);

    // Listen for input events on the search input
    const inputElement = this.element.querySelector('.mapboxgl-ctrl-geocoder--input');
    inputElement.addEventListener('input', (event) => {
      const hasText = !!event.target.value;
      // Show or hide the search icon and pin-right element depending on whether the input has text
      this.#toggleSearchIcon(!hasText);
      this.#togglePinRightElement(hasText);
    });
  }

  #setInputValue(event) {
    this.addressTarget.value = event.result["place_name"];
  }

  #clearInputValue() {
    this.addressTarget.value = "";
  }

  #toggleSearchIcon(show) {
    // Change the visibility of the search icon based on the 'show' argument
    this.searchIcon.style.display = show ? 'block' : 'none';
  }

  #togglePinRightElement(show) {
    // Change the visibility of the pin-right element based on the 'show' argument
    this.pinRightElement.style.display = show ? 'block' : 'none';
  }

  disconnect() {
    this.geocoder.onRemove();
  }
}
