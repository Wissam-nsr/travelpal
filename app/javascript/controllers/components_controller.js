import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="components"
export default class extends Controller {
  static targets = ['location']
  connect() {
    console.log("hello components controller")
  }

  momentform(event) {
    this.locationTarget.disabled = event.currentTarget.checked
  }
}
