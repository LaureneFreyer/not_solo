import { Controller } from "@hotwired/stimulus"
import Swiper from 'swiper';

// Connects to data-controller="slider"
export default class extends Controller {
  connect() {
    console.log("connect test");
    this.swiper = new Swiper('.swiper-container', {
      direction: 'horizontal',
      loop: true,
      pagination: {
        el: '.swiper-pagination',
      },
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
    });
    console.log("connect interne");

  }

  disconnect() {
    console.log("disconnect");
    this.swiper.destroy();
    this.swiper = null;
  }
}
