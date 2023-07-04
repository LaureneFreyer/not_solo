import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new-messages"
export default class extends Controller {
  static targets = ["toggleRead"]
  connect() {
  }
  toggle() {
    this.toggleReadTarget.classList.toggle("read")
  }
}
