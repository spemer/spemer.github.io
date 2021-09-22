---
layout: post
title: "Customizing website scrollbar with CSS(NO JavaScript!)"
categories: [Web, CSS, HTML]
tags: [featured]
image: https://miro.medium.com/max/1400/1*kh08HW91JyQ2FMUyHGRA9w.png
---

![Scrollbar](https://miro.medium.com/max/1400/1*kh08HW91JyQ2FMUyHGRA9w.png)

It seems like **scrollbar** has just tiny part of the webpage, but to me — as UI designer — it’s not that tiny, nor okay to ignore.

---

### Start off

To customize your website’s scrollbar, Only few lines of code in your stylesheet are needed. You don’t even need to write JavaScript to customize it. Following snippet shows CSS code to customize scrollbar of your webpage.

```css
/* Customize website's scrollbar like Mac OS */

/* total width */
body::-webkit-scrollbar {
  background-color: #fff;
  width: 16px;
}

/* background of the scrollbar */
body::-webkit-scrollbar-track {
  background-color: #fff;
}

/* scrollbar body */
body::-webkit-scrollbar-thumb {
  background-color: #babac0;
  border-radius: 16px;
  border: 4px solid #fff;
}

/* set button */
body::-webkit-scrollbar-button {
  display: none;
}
```

Customizing web browser’s scrollbar is non standard method to styling, so you need `-webkit-` **[vendor prefix](https://developer.mozilla.org/en-US/docs/Glossary/Vendor_Prefix)** to use pseudo-elements above.

---

### Pseudo elements

You can use 7 different pseudo-elements to customize scrollbar of webpage with the code below:

```css
::-webkit-scrollbar {
  /* entire scrollbar scope */
}

::-webkit-scrollbar-button {
  /* directional buttons at the top and bottom of the scrollbar */
}

::-webkit-scrollbar-track {
  /* space below the scrollbar */
}

::-webkit-scrollbar-track-piece {
  /* not covered area by the scrollbar-thumb */
}

::-webkit-scrollbar-thumb {
  /* draggable scrollbar itself */
}

::-webkit-resizer {
  /* resizser at the bottom of the scrollbar */
}

::-webkit-scrollbar-corner {
  /* bottom of the scrollbar without resizse */
}
```

I used `::-webkit-scrollbar`, `::-webkit-scrollbar-track` and `::-webkit-scrollbar-thumb` for this tutorial. Each properties need value inside the brackets.

---

### From my stylesheet

I wrote only three lines of CSS code to customize my website’s scrollbar. These methods don’t need a single line of JavaScript code, super simple and easy to use. Check out link below to watch on live **[website](https://spemer.com)**!

```css
body::-webkit-scrollbar {
  background-color: #fff;
  width: 16px;
}

body::-webkit-scrollbar-track {
  background-color: #fff;
}

body::-webkit-scrollbar-thumb {
  background-color: #babac0;
  border-radius: 16px;
  border: 4px solid #fff;
}
```

---

### Can I use?

At this point - in my writing this article today(**September 21, 2021**), search result on **[caniuse.com](https://caniuse.com/?search=scrollbar)** says 97.27% of browsers support for `::-webkit-scrollbar` pseudo-elements.

![Can I Use](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FdhRMju%2Fbtrfw3WGN9W%2Fx1jCBReNUjAZns1Dhkt1x0%2Fimg.jpg)

Thank you for reading my article, and hope you enjoyed!
