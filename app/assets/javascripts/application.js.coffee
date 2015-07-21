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

  windowHeightz0r = ->
    $('.screen-pane').each ->
      navH = $('.navbar-default').height();
      winH = $(window).height();
      paneH = winH - navH;
      $(this).css('minHeight',parseInt(paneH)+'px');
  
  windowHeightz0r()

  $(window).resize ->
    windowHeightz0r()
