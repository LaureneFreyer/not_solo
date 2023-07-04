import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new-messages"
export default class extends Controller {
  connect() {
    console.log("Hello You!");
  }
}
