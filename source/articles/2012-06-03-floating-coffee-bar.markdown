---
title: CoffeeScript jQuery Animated Scrolling Sidebar
date: 2012-06-03
layout: post
---
I have been really getting into writing CoffeeScript lately, so I decided to revisit the jQuery floating sidebar I blogged about a while back. The logic is the same, other than using a named function to increase readability. The code is shrunk from 40 lines to 28 lines (with extra line breaks for readability). More importantly, I believe the code is easier to understand.</p>
<p>The basic concept is to create function which I have called jitteryScroll that either scrolls the sidebar items, or returns them to the header if the scroll is at the top of the page. Then I define a function that fires on scroll and I use setTimeout in order to prevent the scroll function from overloading the browser (the scroll function fires like a machine gun when a user scrolls a page).

<script src="http://pastebin.com/embed_js.php?i=H7f1x28B"></script>
s
Let me know if you have any questions or suggestions.
