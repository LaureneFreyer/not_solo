document.addEventListener("DOMContentLoaded", function() {
  var homeAnnonce = document.querySelector(".home-annonce");
  var lastScrollTop = 0;

  function updateHomeAnnonce() {
    var scrollTop = window.pageYOffset || document.documentElement.scrollTop;

    if (scrollTop > lastScrollTop) {
      homeAnnonce.classList.add("scroll-down");
    } else {
      homeAnnonce.classList.remove("scroll-down");
    }

    lastScrollTop = scrollTop;
  }

  window.addEventListener("scroll", updateHomeAnnonce);
});
