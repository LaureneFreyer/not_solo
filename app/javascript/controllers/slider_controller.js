import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider"
export default class extends Controller {
  // connect() {
  //   console.log("connect test");
  //   this.swiper = new Swiper('.slider-container', {
  //     direction: 'horizontal',
  //     loop: true,
  //     pagination: {
  //       el: '.swiper-pagination',
  //     },
  //     navigation: {
  //       nextEl: '.swiper-button-next',
  //       prevEl: '.swiper-button-prev',
  //     },
  //   });
  //   console.log("connect interne");

  // }

  // disconnect() {
  //   console.log("disconnect");
  //   this.swiper.destroy();
  //   this.swiper = null;
  // }
}

//-----------------------------------//
//----------new slider---------------//
//-----------------------------------//




const slider = document.getElementById('scroll-pane')
// slider.addEventListener('scroll', function() {
//   console.log('scrolling');
// })


// console.log(slider.children);

function cloneSliderElements(slider) {
  let sliderElms = slider.children // [1,2,3]
  let sliderCopy = Array.from(sliderElms)
  let sliderLength = sliderCopy.length
  console.log(sliderElms);
  console.log(sliderCopy);

  for (var elm of sliderCopy) {
      sliderElms[sliderElms.length-1].insertAdjacentElement('afterend',  elm.cloneNode())
    }

  sliderCopy.reverse()

  for (var elm of sliderCopy) {
      sliderElms[0].insertAdjacentElement('beforebegin',  elm.cloneNode())
    }
}
cloneSliderElements(slider);



slider.scrollLeft = slider.scrollLeftMax/2;

let sliderW = slider.scrollLeftMax;
let elmtCount = slider.children.length;
let elmWidth = sliderW / elmtCount;

// let boundRight = sliderW * (2/3);
// let boundLeft = sliderW * (1/3);

let boundRight = slider.scrollWidth * (2/3);
let boundLeft = slider.scrollWidth * (1/3);

// let boundRight = 1000;
// let boundLeft = 400;

slider.addEventListener('scroll', function() {
  if(slider.scrollLeft >= boundRight) {
  // if(slider.scrollLeft == sliderW) {
    console.log('BACK');
    slider.scrollLeft = boundLeft+20;
    return;
  }
  if(slider.scrollLeft <= boundLeft) {
    // if(slider.scrollLeft == sliderW) {
      console.log('BACK');
      slider.scrollLeft = boundRight-20;
    }
})
