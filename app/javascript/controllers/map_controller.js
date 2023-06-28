import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl' // Don't forget this!

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    userCoordinates: Array,
    marker: Object
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })
    if (this.markersValue) {
      this.addMarkersToMap()
      this.fitMapToMarkers()
    } else if (this.markerValue) {
      this.addMarkerToMap()
      this.fitMapToMarker()
    }
  }

  addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)

      // Create a HTML element for your custom marker
      const customMarker = document.createElement("div")
      customMarker.innerHTML = marker.marker_html

      // Pass the element as an argument to the new marker
      new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([marker.lng, marker.lat]))

    if (this.userCoordinatesValue) {
      bounds.extend(this.userCoordinatesValue)
    }

    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

  addMarkerToMap() {
    const marker = this.markerValue;
    const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)

    // Create a HTML element for your custom marker
    const customMarker = document.createElement("div")
    customMarker.innerHTML = marker.marker_html

    const lngLat = new mapboxgl.LngLat(parseFloat(marker.lng), parseFloat(marker.lat))

    // Pass the element as an argument to the new marker
    new mapboxgl.Marker(customMarker)
      .setLngLat(lngLat)
      .setPopup(popup)
      .addTo(this.map)
  }

  fitMapToMarker() {
    const bounds = new mapboxgl.LngLatBounds()
    const lngLat = new mapboxgl.LngLat(parseFloat(this.markerValue.lng), parseFloat(this.markerValue.lat))
    bounds.extend(lngLat)
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }


}
