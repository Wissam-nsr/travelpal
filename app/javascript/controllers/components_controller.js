import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="components"
export default class extends Controller {
  static targets = ['location']
  connect() {
  }

  momentform(event) {
    this.locationTarget.disabled = event.currentTarget.checked
    if (this.locationTarget.disabled) {
      this.locationTarget.value = ""
      this.locationTarget.style.background = "#b9b6b6fc"
    }
    else {
      this.locationTarget.style.background = "white"
    }
  }
}
