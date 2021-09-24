---
layout: post
title: "Next.js를 위한 sitemap generator 만들기"
categories: [Next.js, React.js, Web, Frontend]
tags: [featured]
image: https://spemer.com/img/works/sitemap/logo.jpeg
---

> 사이트맵 생성부터, 검색엔진 색인 요청까지

안녕하세요! 라이브 마켓 모음 앱, 볼라의 디자이너 서혁입니다. 볼라는 셀러(판매자)와 구매자가 라이브 방송을 통해 소통하며 상품을 구매할 수 있는 플랫폼입니다.

얼마 전, 기존 [Vue.js](https://vuejs.org/)로 만들어져있던 볼라 랜딩페이지(https://volla.live)를 앱 내 콘텐츠 공유용 브릿지 페이지([Next.js](https://nextjs.org/))에 통합하게 되면서 함께 진행한 검색엔진 최적화(SEO) 작업 - 그중에서도 사이트맵 작업 중에 진행했던, Next.js 동적 sitemap generator 스크립트 작성기를 공유하고자 합니다.

---

### 1. Next.js의 폴더구조를 활용한 sitemap generator 스크립트 작성​

Next.js는 pages 디렉토리 내의 폴더와 파일명을 따라 URL이 생성되므로, globby를 사용해 pages 디렉토리의 모든 폴더와 파일명들 중 Next.js만의 특수한 파일명들 (`\_document.js`, `\_app.js`등)을 제외한 나머지 폴더 및 파일명들로 사이트맵 xml이 만들어지도록 코드를 작성했습니다.

우선 루트 디렉토리에서 scripts 폴더를 만들고, 그 안에 `sitemap-common.js`라는 이름으로 아래와 같은 코드를 작성했습니다.

```javascript
const fs = require("fs");
const globby = require("globby");
const prettier = require("prettier");

const getDate = new Date().toISOString();

const YOUR_AWESOME_DOMAIN = "https://website.com";

const formatted = (sitemap) => prettier.format(sitemap, { parser: "html" });

(async () => {
  const pages = await globby([
    // include
    "../pages/**/*.tsx",
    "../pages/*.tsx",
    // exclude
    "!../pages/_*.tsx",
  ]);

  const pagesSitemap = `
    ${pages
      .map((page) => {
        const path = page
          .replace("../pages/", "")
          .replace(".tsx", "")
          .replace(/\/index/g, "");
        const routePath = path === "index" ? "" : path;
        return `
          <url>
            <loc>${YOUR_AWESOME_DOMAIN}/${routePath}</loc>
            <lastmod>${getDate}</lastmod>
          </url>
        `;
      })
      .join("")}
  `;

  const generatedSitemap = `
    <?xml version="1.0" encoding="UTF-8"?>
    <urlset
      xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd"
    >
      ${pagesSitemap}
    </urlset>
  `;

  const formattedSitemap = [formatted(generatedSitemap)];

  fs.writeFileSync("../public/sitemap-common.xml", formattedSitemap, "utf8");
})();
```

위의 스크립트를 실행하면, 아래와 같은 xml 파일을 만들어줍니다(예시).

```html
<?xml version="1.0" encoding="UTF-8"?>
<urlset
  xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd"
>
  <url>
    <loc>https://website.com/</loc>
    <lastmod>2020-04-03T08:19:25.691Z</lastmod>
  </url>
  <url>
    <loc>https://website.com/about</loc>
    <lastmod>2020-04-03T08:19:25.691Z</lastmod>
  </url>
  <url>
    <loc>https://website.com/blog</loc>
    <lastmod>2020-04-03T08:19:25.691Z</lastmod>
  </url>
  <url>
    <loc>https://website.com/profile</loc>
    <lastmod>2020-04-03T08:19:25.691Z</lastmod>
  </url>
  <url>
    <loc>https://website.com/teams</loc>
    <lastmod>2020-04-03T08:19:25.691Z</lastmod>
  </url>
</urlset>
```

---

### 2. 외부 API를 위한 sitemap generator 스크립트 작성

위의 예제 코드와 같이, 정적 페이지들에 대해서는 사이트맵을 만들어주기가 비교적 쉽습니다. 하지만, 동적 페이지들(e.g. userId 등을 받아서 페이지를 띄워주는)에 대해서는 조금 다른 방식을 통해 사이트맵을 생성하는 스크립트를 작성해야 했습니다(예제 코드에서는 [JSONPlaceholder](https://jsonplaceholder.typicode.com/)의 API 를 사용했습니다).

`sitemap-posts.js`라는 이름으로 아래와 같은 코드를 작성했습니다.

```javascript
const fs = require("fs");
const fetch = require("node-fetch");
const prettier = require("prettier");

const getDate = new Date().toISOString();

const fetchUrl = "https://jsonplaceholder.typicode.com/posts";
const YOUR_AWESOME_DOMAIN = "https://website.com";

const formatted = (sitemap) => prettier.format(sitemap, { parser: "html" });

(async () => {
  const fetchPosts = await fetch(fetchUrl)
    .then((res) => res.json())
    .catch((err) => console.log(err));

  const postList = [];
  fetchPosts.forEach((post) => postList.push(post.id));

  const postListSitemap = `
    ${postList
      .map((id) => {
        return `
          <url>
            <loc>${`${YOUR_AWESOME_DOMAIN}/post/${id}`}</loc>
            <lastmod>${getDate}</lastmod>
          </url>`;
      })
      .join("")}
  `;

  const generatedSitemap = `
    <?xml version="1.0" encoding="UTF-8"?>
    <urlset
      xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd"
    >
      ${postListSitemap}
    </urlset>
  `;

  const formattedSitemap = [formatted(generatedSitemap)];

  fs.writeFileSync("../public/sitemap-posts.xml", formattedSitemap, "utf8");
})();
```

위의 스크립트를 실행하면, 아래와 같은 xml 파일을 만들어줍니다(예시).

```html
<?xml version="1.0" encoding="UTF-8"?>
<urlset
  xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd"
>
  <url>
    <loc>https://website.com/post/1</loc>
    <lastmod>2020-04-03T16:03:19.388Z</lastmod>
  </url>
  <url>
    <loc>https://website.com/post/2</loc>
    <lastmod>2020-04-03T16:03:19.388Z</lastmod>
  </url>
  <url>
    <loc>https://website.com/post/3</loc>
    <lastmod>2020-04-03T16:03:19.388Z</lastmod>
  </url>
  <url>
    <loc>https://website.com/post/4</loc>
    <lastmod>2020-04-03T16:03:19.388Z</lastmod>
  </url>
  <url>
    <loc>https://website.com/post/5</loc>
    <lastmod>2020-04-03T16:03:19.388Z</lastmod>
  </url>
  <url>
    <loc>https://website.com/post/6</loc>
    <lastmod>2020-04-03T16:03:19.388Z</lastmod>
  </url>
  <url>
    <loc>https://website.com/post/7</loc>
    <lastmod>2020-04-03T16:03:19.388Z</lastmod>
  </url>
  <url>
    <loc>https://website.com/post/8</loc>
    <lastmod>2020-04-03T16:03:19.388Z</lastmod>
  </url>
  <url>
    <loc>https://website.com/post/9</loc>
    <lastmod>2020-04-03T16:03:19.388Z</lastmod>
  </url>
  <url>
    <loc>https://website.com/post/10</loc>
    <lastmod>2020-04-03T16:03:19.388Z</lastmod>
  </url>
</urlset>
```

---

### 3. 위에서 만들어진 사이트맵 파일들을 모두 gzip 형식으로 압축해주는 스크립트 작성

gzip(.gz) 형식으로 압축된 사이트맵은 용량을 줄이면서도, xml 형식의 사이트맵과 동일하게 사용할 수 있습니다. 위에서 만들어진 xml 파일들을 zlib을 사용해서 모두 gzip 형식으로 압축하겠습니다.

```javascript
const fs = require("fs");
const zlib = require("zlib");

var dirs = ["../public/sitemap"];

dirs.forEach((dir) => {
  fs.readdirSync(dir).forEach((file) => {
    if (file.endsWith(".xml")) {
      // gzip
      const fileContents = fs.createReadStream(dir + "/" + file);
      const writeStream = fs.createWriteStream(dir + "/" + file + ".gz");
      const zip = zlib.createGzip();

      fileContents
        .pipe(zip)
        .on("error", (err) => console.error(err))
        .pipe(writeStream)
        .on("error", (err) => console.error(err));
    }
  });
});
```

위의 스크립트를 실행하면, 1번과 2번에서 만들어진 xml 파일들을 모두 .gz 형식으로 압축해줍니다.

---

{% include ads-contents.html %}

---

### 4. 위의 방법들로 만들어진 sitemap 파일들을 위한, 사이트맵 색인 파일 생성 스크립트 작성

여러 개의 사이트맵들을 검색엔진에 제공(구글 서치콘솔, 네이버 서치 어드바이저 등)하기 위해서는, 사이트맵 색인(Sitemap index) 파일이 별도로 필요합니다.

볼라의 경우 `/seller/[_id]`, `/product/[_id]`, `/video/[_id]` 등 다양한 동적 웹페이지들에 대응해 각각 사이트맵을 따로 만들어주었으며, 구글 서치콘솔 등에 사이트맵을 제출하기 위해서는 단일 사이트맵으로 제출해야 하기 때문에 아래와 같은 코드를 작성해서 사이트맵 색인 파일을 만들었습니다.

```javascript
const fs = require("fs");
const globby = require("globby");
const prettier = require("prettier");

const getDate = new Date().toISOString();

const webrootDomain = "https://website.com";

const formatted = (sitemap) => prettier.format(sitemap, { parser: "html" });

(async () => {
  const pages = await globby(["../public/sitemap/*.gz"]);

  const sitemapIndex = `
    ${pages
      .map((page) => {
        const path = page.replace("../public/", "");
        return `
          <sitemap>
            <loc>${`${webrootDomain}/${path}`}</loc>
            <lastmod>${getDate}</lastmod>
          </sitemap>`;
      })
      .join("")}
  `;

  const sitemap = `
    <?xml version="1.0" encoding="UTF-8"?>
    <sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
      ${sitemapIndex}
    </sitemapindex>
  `;

  const formattedSitemap = [formatted(sitemap)];

  fs.writeFileSync("../public/sitemap.xml", formattedSitemap, "utf8");
})();
```

위의 스크립트를 실행하면, 아래와 같은 xml 파일을 만들어줍니다(예시).

```html
<?xml version="1.0" encoding="UTF-8"?>
<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <sitemap>
    <loc>https://website.com/sitemap/sitemap-common.xml.gz</loc>
    <lastmod>2020-04-03T08:19:46.858Z</lastmod>
  </sitemap>
  <sitemap>
    <loc>https://website.com/sitemap/sitemap-posts.xml.gz</loc>
    <lastmod>2020-04-03T08:19:46.858Z</lastmod>
  </sitemap>
</sitemapindex>
```

---

### 5. 마스터 배포 시마다 새로운 사이트맵을 생성하는 Bash 스크립트와, GitHub Actions에서 구글 Search Console에 사이트맵을 Ping 하는 스크립트 작성

```bash
# yarn sitemap
$ cd public
$ rm -rf sitemap
$ mkdir sitemap
$ cd ..
$ cd scripts
$ node ./sitemap-common.js
$ node ./sitemap-posts.js
$ node ./sitemap.js
```

구글 서치콘솔에 페이지의 색인을 다시 생성하도록 요청하려면, 아래의 스크립트를 마지막에 추가하면 됩니다.

```bash
$ curl http://google.com/ping?sitemap=http://website.com/sitemap.xml
```

볼라의 경우에는 xml 형식의 사이트맵을 만든 후 해당 사이트맵들을 gzip 형식으로 압축한 다음, 기존의 xml 사이트맵을 제거할 수 있도록 아래와 같은 bash 스크립트를 따로 작성해주었습니다.

![Bash script](https://blog.kakaocdn.net/dn/bvtUCO/btrdJj7Rnum/lpe5O3PF7Rf38nl7ZlREr0/img.png)

이후, 마스터 배포 시 GitHub Actions에서 위의 스크립트들을 실행하도록 workflow 파일을 수정했습니다.

```bash
# 사이트맵을 만들고, 구글에 제출합니다.
- run: yarn sitemap
  name: ping sitemap
```

---

### 추후 반영/개선해야 할 사항

- 매 00시 정각마다 자동으로 신규 콘텐츠들이 반영된 새로운 사이트맵을 만들고, 이후 구글에 새로운 사이트맵 색인 Ping

---

### 마치며

개발에 대한 지식이 많이 부족한 터라 잘못된 내용이 있을 수도 있는데, 해당 부분에 코멘트를 달아주신다면 바로잡을 수 있도록 하겠습니다. 혹시 위 방법보다 더욱 좋은 방법이나, 개선을 위한 의견 등은 댓글로 부탁드립니다. 읽어주셔서 감사합니다!
