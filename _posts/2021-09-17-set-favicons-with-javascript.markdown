---
layout: post
title: "Set favicons with JavaScript"
categories: [JavaScript, Frontend, Web]
tags: [featured]
image: https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FCtGvV%2FbtrfrdXITqu%2FpdwU5g9NL1GNdJhLPa3CX0%2Fimg.png
---

## In a super easy and simple way for JavaScript newbies

When you publishing some websites, you’ll need to set favicon for the websites. If you have bunch of HTML files to do that, one tiny change might results lots of bothersome works. In this article, I’m gonna let you know how to set favicon — include shortcut icons for Android and iOS — with just few lines of code in JavaScript without fixing your HTML codes one by one.

### Basic way to set favicon in HTML

```html
<link rel="shortcut icon" href="../images/favicon.png" />
```

We’ll make this plain HTML code runs with JavaScript, inside <head> tag. It’s pretty simple if you want to set only one kind of favicon, just for web browsers, not mobile shortcut icons or Apple touch icons.

### In JavaScript

```javascript
function setFavicons(favImg) {
  let headTitle = document.querySelector("head");
  let setFavicon = document.createElement("link");
  setFavicon.setAttribute("rel", "shortcut icon");
  setFavicon.setAttribute("href", favImg);
  headTitle.appendChild(setFavicon);
}

setFavicons("https://spemer.com/img/favicon/favicon.png");
```

Now you’ve completed to set your website’s favicon, without writing code for every HTML files you have! You can apply this way to set favicons for other favicons or shortcut icons with JavaScript arrays.

---

## Add array for favicons

```javascript
let favIcons = [
  { rel: "apple-touch-icon" },
  { rel: "apple-touch-startup-image" },
  { rel: "shortcut icon" },
];
```

And, we’re gonna use this array with for loop to apply it to our code above.

```javascript
function setFavicons(favImg) {
  let headTitle = document.querySelector("head");

  let favIcons = [
    { rel: "apple-touch-icon" },
    { rel: "apple-touch-startup-image" },
    { rel: "shortcut icon" },
  ];

  favIcons.forEach(function (favIcon) {
    let setFavicon = document.createElement("link");
    setFavicon.setAttribute("rel", favIcon.rel);
    setFavicon.setAttribute("href", favImg);
    headTitle.appendChild(setFavicon);
  });
}

setFavicons("https://spemer.com/img/favicon/favicon.png");
```

That’s it! In the same way, we can set other favicons like Android shortcut icons or Apple touch icons for iPhone and iPad.

{% include google-adsense-content.html %}

## Set another array and function

```javascript
function setAppleFavicons() {
  let headTitle = document.querySelector("head");

  let appleFavIcons = [
    { sizes: "152x152", href: "../touch-icon-ipad.png" },
    { sizes: "180x180", href: "../touch-icon-iphone-retina.png" },
    { sizes: "167x167", href: "../touch-icon-ipad-retina.png" },
  ];

  appleFavIcons.forEach(function (appleFavIcon) {
    let setAFavicon = document.createElement("link");
    setAFavicon.setAttribute("rel", "apple-touch-icon");
    setAFavicon.setAttribute("sizes", appleFavIcon.sizes);
    setAFavicon.setAttribute("href", appleFavIcon.href);
    headTitle.appendChild(setAFavicon);
  });
}

setAppleFavicons();
```

With the code above, we’ve completed to set touch icons for iOS.

![Code](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FCtGvV%2FbtrfrdXITqu%2FpdwU5g9NL1GNdJhLPa3CX0%2Fimg.png)

---

### What’s next?

In the same way, we can also set favicons for Android shortcut icons with JavaScript, not like HTML codes below.

```html
<link
  rel="icon"
  href="../favicon-16.png"
  sizes="16x16"
  type="../favicon-16.png"
/>
<link
  rel="icon"
  href="../favicon-32.png"
  sizes="32x32"
  type="../favicon-32.png"
/>
<link
  rel="icon"
  href="../favicon-48.png"
  sizes="48x48"
  type="../favicon-48.png"
/>
<link
  rel="icon"
  href="../favicon-62.png"
  sizes="62x62"
  type="../favicon-62.png"
/>
<link
  rel="icon"
  href="../favicon-192.png"
  sizes="192x192"
  type="../favicon-192.png"
/>
```

Now we can apply it in our JavaScript code. We don’t need to worry even if there’re small changes for favicons, which make us to fix every HTML codes for them. Just fix one or two lines in JavaScript can apply it on every websites.

Moreover, by applying dynamic parameter for the function, you can make your favicon dynamically(e.g., badge on favicon).
