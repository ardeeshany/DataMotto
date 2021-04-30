import json from "../mottos.js";
const app = Vue.createApp({
  data() {
    return {
      dottos: json,
    };
  },
  methods: {
    goToUrl: function (link) {
      location.href = link;
    },
  },
});
app.mount("body");
