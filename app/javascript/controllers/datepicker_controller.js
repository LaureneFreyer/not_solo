import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"; // You need to import this to use new flatpickr()
// import French from "flatpickr/dist/l10n/fr.js"

export default class extends Controller {
  connect() {
    flatpickr(this.element, { altInput: true, enableTime: true, altFormat: 'j F Y', minDate: 'today', disableMobile: "true" })
  }
}
