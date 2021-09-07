---
layout: post
title:  "Auto CSS prefix with Gulp"
categories: [ CSS, Gulp, Web ]
tags: [ featured ]
image: https://spemer.com/img/works/gulp/gulp.png
---

> Short tutorial for beginners with bit of examples

Gulp is front-end toolkit runs with JavaScript. Before I knew about Gulp, I used to write CSS vendor prefixes one by one, or copied and pasted tons of CSS codes on online auto-prefixer websites to get prefixed CSS codes. Still you can use CSS vendor prefixes with such ways, but after you read this short tutorial, I bet you’ll never do that again — instead, you’ll going to love to use this brilliant toolkit, Gulp.

---

# Start Off

### So, what can we do with Gulp?

- Create sprite images
- Combine media queries easily for CSS
- Minify or beautify your JavaScript and CSS files
- Compress your HTML files
- Compile Sass, Less, Stylus, PostCSS, Pug
- and so on…

---

### How to install

Before you get started, you need to install [Node.js](https://nodejs.org/en/) first on the link below. If you already installed this, you can skip this step.

To make sure Node.js installed correctly, write node -v and npm -v to check your Node.js and npm’s current version on command prompt. After that, write a line of command below, on your command prompt.

```bash
npm install -g gulp
```

If you can’t find or use your command prompt, I recommend you to install [Git Bash](https://git-scm.com/downloads). Moreover, It looks cooler than built-in command prompt!

Now you’ve installed Gulp globally, so you need to make directory to install Gulp locally and to play with it. Type following command lines on your command prompt, on directory wherever you want to.

```bash
mkdir newProject && cd newProject
npm init
npm install --save-dev gulp
```

`mkdir` lets you to make directory on current directory, and `newProject` will be your new directory’s name. Unlike `npm install -g gulp` on above, `npm install --save-dev gulp` will install Gulp on newProject directory locally.

---

### Create your first gulpfile.js file

Now you have to create gulpfile.js on the directory newProject that you’ve made before with command prompt. Next, write code snippet below into your gulpfile.js file, and save it.

```javascript
const gulp = require('gulp');

gulp.task('taskname', function(){
    console.log('\nHello world!\n');
});
```

On the command prompt(or Git Bash), write command line like below.

```bash
gulp taskname
```

If you can see the same result of mine like the image below, Congrats! You set your first gulpfile successfully.


{% include image.html url="https://spemer.com/img/works/gulp/npmver.png" description="Terminal" %}

On the Gist code snippet above, I wrote `taskname` after `gulp.task` on the line 3, and used that taskname on my command prompt to execute the task. You can set the name of task with the way you want, or you can set it’s name as `default`. If you set the name of task as `default`, you don’t need to write the task’s name on command prompt — just write `gulp` to execute it.

---

# Play with code

### Auto prefix your CSS code with Gulp plug-ins

You can find bunch of stunning [Gulp plug-ins](https://gulpjs.com/plugins/) on Gulp website. In my case, I use Gulp to minify my JavaScript files, combine CSS media queries, or make my CSS file to have vendor prefixes automatically. In this tutorial, I’m going to let you know how I used Gulp auto-prefixer.

You can also see basic usages and how to use it with your CSS code on the link below. On your command prompt, write following command to install Gulp auto-prefixer locally into your directory.

```bash
npm install --save-dev gulp-autoprefixer
```

To test this auto-prefixer, we’re going to make CSS file on the same directorywith property that needs vendor prefixes like below.

```css
div {
    display: flex;
}
```

Go back to your gulpfile.js, copy and paste the code snippet below.

> Note: You must keep `const gulp = require('gulp');`
> on the top of your gulpfile.js, Always!

```javascript
const gulp = require('gulp');
const autoprefixer = require('gulp-autoprefixer');

gulp.task('prefix', () =>
    gulp.src('styleTest.css')
        .pipe(autoprefixer({
            browsers: ['last 99 versions'],
            cascade: false
    }))
    .pipe(gulp.dest('style'))
);
```

As you can see, I set the name of task as `prefix`, so you can execute this gulpfile with command `gulp prefix` on your command prompt. You can set versions of CSS vendor prefix like line 6.

- gulp.src points source folder where original files are located now.
- gulp.dest points destination folder where processed files will be placed through gulp.

```bash
gulp prefix
```

Write the command line above(with name of the task) on your command prompt. Now, let’s see how CSS code has changed.

```css
div {
    display: -webkit-box;
    display: -webkit-flex;
    display: -moz-box;
    display: -ms-flexbox;
    display: flex;
}
```

That’s it! Now you can browse and search for bunch of other useful Gulp plug-ins on [Gulp website](https://gulpjs.com/), and I hope you make them run on your web browser. Here’re some of my recommendations:

- gulp-htmlclean
  - HTML/SVG cleaner without changing it’s structure
- gulp-clean-css
  - Minify your CSS files
- gulp-uglify
  - One of my favorite, JavaScript minifier!

---

# Takeaway

I hope you enjoyed my short tutorial about stunning toolkit — Gulp. You can check my [GitHub repository](https://github.com/spemer/spemer_portfolio) if you want to see how I used Gulp for my [design portfolio website](https://spemer.com/). If you want to contact me, visit my [LinkedIn](https://www.linkedin.com/in/hyouk-seo-0b6801122/) or just send me an Email to ghsspower@gmail.com. Thanks!
