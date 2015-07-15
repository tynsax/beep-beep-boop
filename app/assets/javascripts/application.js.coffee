//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require knwl.min
//= require_tree .


$ ->
  flashCallback = ->
    $(".alert").fadeOut()
  $(".alert").bind 'click', (ev) =>
    $(".alert").fadeOut()
  setTimeout flashCallback, 3000

  