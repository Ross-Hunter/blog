---
title: CoffeeScript jQuery Animated Scrolling Sidebar
date: 2012-06-03
layout: post
tags: code, js
id: 8
---
I have been really getting into writing CoffeeScript lately, so I decided to revisit the jQuery floating sidebar I blogged about a while back. The logic is the same, other than using a named function to increase readability. The code is shrunk from 40 lines to 28 lines (with extra line breaks for readability). More importantly, I believe the code is easier to understand.

The basic concept is to create a function which I have called jitteryScroll that either scrolls the sidebar items, or returns them to the header if the scroll is at the top of the page. Then I define a function that fires on scroll and I use setTimeout in order to prevent the scroll function from overloading the browser (the scroll function fires like a machine gun when a user scrolls a page).


```coffeescript
jQuery ($)->
  timer = 0;
  $top = $('#block-block-3').offset().top + 20

  jitteryScroll = ()->
    timer = 0
    topOfWindow = $(window).scrollTop()
    if topOfWindow > $top
      $('#block-block-3').css({
          position: 'absolute'})
      $('#block-block-3').stop(true, true).animate({
          opacity: 0.75
          width: 40
          top: topOfWindow
          right: -25
          }, 600, 'easeOutElastic' )
    else
      $('#block-block-3').stop(true, true).css({
          opacity: 1
          width: 270
          top: 0
          right: 0
          position: 'relative'
          })

  $(window).scroll ()->
    if !timer
      timer = setTimeout jitteryScroll, 250
```

Let me know if you have any questions or suggestions.
