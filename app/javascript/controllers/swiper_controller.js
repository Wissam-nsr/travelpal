import { Controller } from "@hotwired/stimulus"
import Swiper, { Navigation } from 'swiper';
  // import Swiper and modules styles


// Connects to data-controller="swiper"
export default class extends Controller {
  connect() {
    console.log(this.element)
    const swiper = new Swiper(this.element, {
      // Optional parameters
        loop: true,
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
    });
  }
}
