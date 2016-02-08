window.App = window.App || {}

App.init = () => {
  // Any global initialization goes here.
}

$(document).on("page:change", () => {
  App.init()
})