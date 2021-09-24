---
layout: post
title: "Vue.js 에서 Axios 사용하기"
categories: [Vue.js, Axios, Web, Frontend]
tags: []
image: https://spemer.com/img/works/vue/thumb.png
---

[Axios](https://github.com/axios/axios)는 http통신을 하고, ajax 요청을 하는 등의 작업을 위한 라이브러리입니다. 이 외에 [vue-resource](https://github.com/pagekit/vue-resource) 라는 라이브러리도 있지만 업데이트도 느리고 Axios보다 커뮤니티도 활성화되어있지 않아서 잘 사용하지 않는다고 합니다.

[https://github.com/axios/axios](https://github.com/axios/axios)

---

### Axios 설치하기

아래의 명령어를 입력해서 Axios를 설치합니다.

```bash
npm install --save axios
```

그리고, Axios를 전역으로 사용할 수 있도록 `main.js` 안에 메소드를 추가합니다.

```javascript
import Vue from "vue";
import App from "./App";
import axios from "axios";

Vue.prototype.$http = axios;

app = new Vue({
  el: "#app",
  components: { App },
  template: "<App/>",
});
```

---

### Axios 사용하기

[JSONPlaceholder](https://jsonplaceholder.typicode.com/) 라는 서비스를 활용해서, 방금 설치한 Axios를 테스트 해보겠습니다. 다음과 같은 코드를 작성해주시면 됩니다.

```html
<template lang="pug">
  div#app div(v-for="user in users" v-bind:key="users.id") h1 {{ user.name }} p
  {{ user.email }} button(@click="fetchUsers") Click me
</template>

<script>
  export default {
    name: "app",
    data() {
      return {
        users: [],
      };
    },
    methods: {
      fetchUsers: function () {
        let baseURI = "https://jsonplaceholder.typicode.com";
        this.$http.get(`${baseURI}/users`).then((result) => {
          console.log(result);
          this.users = result.data;
        });
      },
    },
  };
</script>
```

---

{% include ads-contents.html %}

---

### IE 지원하기

IE는 `promise`를 지원하지 않기때문에, 그에 해당하는 polyfill이 필요합니다. 아래 명령어를 입력해서 설치할 수 있습다.

```bash
npm install --save es6-promise
```

그 후, webpack의 config 파일에 아래 코드를 작성해서 불러옵니다.

```javascript
require("es6-promise").polyfill();
```
