import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "activeLogo", "inactiveLogo" ]

  switch() {
    this.activeLogoTarget.classList.toggle('logo-actif');
    this.inactiveLogoTarget.classList.toggle('logo-inactif');
  }
}
