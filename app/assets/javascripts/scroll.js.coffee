$ ->
  $nav_header    = $('.navbar-default')
  header_height  = $nav_header.height()
  hero_height    = $('#video-holder').height()
  offset_val     = hero_height - header_height

  navSlide = ->
    scroll_top = $(window).scrollTop();

    if (scroll_top >= offset_val)
      $nav_header.addClass('is-sticky')
    else
      $nav_header.removeClass('is-sticky')

  $(window).scroll(navSlide);