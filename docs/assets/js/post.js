const app = Vue.createApp({
  data() {
    return {
      activeMotto: "1",
      activeLang: "r",
      authorOneModal: false,
      authorTwoModal: false,
      authorThreeModal: false,
      activeDotto: "1",
      commentOpen: false,
    };
  },
  methods: {},
  mounted() {
    var handler = document.querySelector(".handler");
    var wrapper = handler.closest(".wrapper");
    var boxA = wrapper.querySelector(".box");
    var boxB = wrapper.querySelector(".box2");
    var isHandlerDragging = false;
    var isHandlerDragging2 = false;
    var handler2 = document.querySelector(".handler2");
    var wrapper2 = handler2.closest("#resizable");

    document.addEventListener("mousedown", function (e) {
      if (e.target === handler) {
        isHandlerDragging = true;
        isHandlerDragging2 = false;
      } else if (e.target === handler2) {
        isHandlerDragging2 = true;
        isHandlerDragging = false;
      }
    });

    document.addEventListener("mousemove", function (e) {
      if (!isHandlerDragging && !isHandlerDragging2) {
        return false;
      } else if (isHandlerDragging) {
        var containerOffsetLeft = wrapper.offsetLeft;
        var pointerRelativeXpos = e.clientX - containerOffsetLeft;
        var boxAminWidth = 60;
        boxA.style.width =
          Math.max(boxAminWidth, pointerRelativeXpos - 8) + "px";
        boxA.style.flexGrow = 0;
      } else if (isHandlerDragging2) {
        var containerOffsetLeft = wrapper2.offsetLeft;
        var pointerRelativeXpos = e.clientX - containerOffsetLeft;
        var boxBminWidth = 60;
        boxB.style.width =
          Math.max(boxBminWidth, pointerRelativeXpos - 8) + "px";
        boxB.style.flexGrow = 0;
      }
    });

    document.addEventListener("mouseup", function (e) {
      isHandlerDragging = false;
      isHandlerDragging2 = false;
    });
  },
  updated() {
    var handler = document.querySelector(".handler");
    var wrapper = handler.closest(".wrapper");
    var boxA = wrapper.querySelector(".box");
    var boxB = wrapper.querySelector(".box2");
    var isHandlerDragging = false;
    var isHandlerDragging2 = false;
    var handler2 = document.querySelector(".handler2");
    var wrapper2 = handler2.closest("#resizable");

    document.addEventListener("mousedown", function (e) {
      if (e.target === handler) {
        isHandlerDragging = true;
        isHandlerDragging2 = false;
      } else if (e.target === handler2) {
        isHandlerDragging2 = true;
        isHandlerDragging = false;
      }
    });

    document.addEventListener("mousemove", function (e) {
      if (!isHandlerDragging && !isHandlerDragging2) {
        return false;
      } else if (isHandlerDragging) {
        var containerOffsetLeft = wrapper.offsetLeft;
        var pointerRelativeXpos = e.clientX - containerOffsetLeft;
        var boxAminWidth = 60;
        boxA.style.width =
          Math.max(boxAminWidth, pointerRelativeXpos - 8) + "px";
        boxA.style.flexGrow = 0;
      } else if (isHandlerDragging2) {
        var containerOffsetLeft = wrapper2.offsetLeft;
        var pointerRelativeXpos = e.clientX - containerOffsetLeft;
        var boxBminWidth = 60;
        boxB.style.width =
          Math.max(boxBminWidth, pointerRelativeXpos - 8) + "px";
        boxB.style.flexGrow = 0;
      }
    });

    document.addEventListener("mouseup", function (e) {
      isHandlerDragging = false;
      isHandlerDragging2 = false;
    });
  },
});
app.mount("body");
