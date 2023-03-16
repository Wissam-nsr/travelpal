import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-element"
export default class extends Controller {
  static targets = ["element"]
  connect() {
  }

  toggle() {
    this.elementTarget.classList.toggle("active")
  }
}
