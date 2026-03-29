// Hide Header on scroll down
var didScroll;
var lastScrollTop = 0;
var delta = 5;
var nav = document.querySelector('nav');
var navbarHeight = nav ? nav.offsetHeight : 0;

window.addEventListener('scroll', function () {
  didScroll = true;
});

setInterval(function () {
  if (didScroll) {
    hasScrolled();
    didScroll = false;
  }
}, 250);

function hasScrolled() {
  if (!nav) return;
  var st = window.scrollY;

  if (Math.abs(lastScrollTop - st) <= delta) return;

  if (st > lastScrollTop && st > navbarHeight) {
    nav.classList.remove('nav-down');
    nav.classList.add('nav-up');
    nav.style.top = -navbarHeight + 'px';
  } else {
    if (st + window.innerHeight < document.body.scrollHeight) {
      nav.classList.remove('nav-up');
      nav.classList.add('nav-down');
      nav.style.top = '0px';
    }
  }

  lastScrollTop = st;
}

// Smooth scroll on external page
(function () {
  setTimeout(function () {
    if (location.hash) {
      window.scrollTo(0, 0);
      var target = document.querySelector(location.hash);
      if (target) smoothScrollTo(target);
    }
  }, 1);

  document.querySelectorAll('a[href*="#"]:not([href="#"])').forEach(function (link) {
    link.addEventListener('click', function (e) {
      if (
        location.pathname.replace(/^\//, '') === this.pathname.replace(/^\//, '') &&
        location.hostname === this.hostname
      ) {
        var target = document.querySelector(this.hash);
        if (target) {
          smoothScrollTo(target);
          e.preventDefault();
        }
      }
    });
  });

  function smoothScrollTo(target) {
    if (target) {
      window.scrollTo({
        top: target.offsetTop,
        behavior: 'smooth'
      });
    }
  }
})();
