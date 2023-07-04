import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toggleRead"]

  connect() {
  }

  toggle() {
    this.toggleReadTarget.classList.toggle("read")

    fetch(`/chatrooms/${this.toggleReadTarget.dataset.chatroomId}/mark_as_read`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-CSRF-Token': document.querySelector("[name='csrf-token']").content
      }
    }).then(response => {
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      return response.json();
    }).then(json => {
      console.log("Success:", json);
    }).catch(error => {
      console.log("Error:", error);
    });

  }
}
