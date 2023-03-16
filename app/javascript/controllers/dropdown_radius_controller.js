import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown-radius"
export default class extends Controller {
  static targets = ["radius"]
  static values = {
    params: String
  }

  connect() {
    if (this.paramsValue) {
      this.radiusTarget.value = this.paramsValue
    }
  }

  fireForm() {
    this.element.submit()
  }
}
