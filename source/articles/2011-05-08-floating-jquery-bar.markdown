---
title: Creating an Animated Floating Sidebar With jQuery
date: 2011-05-08
layout: post
---
<h3><em><a href="/coffeescript-jquery-animated-scrolling-sidebar">Click here for an update to this post using CoffeeScript</a></em></h3>

<p>I finally got around to implementing a floating sidebar that contains all of my follow links contained in my header. Lots of sites have a floating sidebar, but I wanted mine to be a little different. First, the items in my sidebar come flying out of the header to the sidebar 
when the user scrolls down past the header, instead of being fixed over on the side. You will also notice a nifty little elastic animation effect.</p>

<p>First let's tackle the fact that the sidebar items actually come "unglued" from the header and hang out over on the side when the user scrolls past the header, and also return to their home inside of the header when scrolled back to the top. The first step is to give the header region containing the home for the follow links relative positioning like so.</p>

<script src="http://pastebin.com/embed_js.php?i=nixWwawa"></script>

<p>Now, all of the magic happens with jQuery. The full code is posted below, but I would like to write you a narrative to explain it. The first step, believe it or not, is to set a timer. We set a timer, because we are going to be binding to the scroll function, and without setting a timeout, you can experience serious performance problems when someone scrolls quickly on your site, the scroll event can be triggered hundreds of times a second with certain mousewheels! The next thing we do is keep track of the home position of the block we will be floating.</p>

<p>It's bind time baby. The very first thing we do inside of the scroll function is to check the timer. If the timer is still going we don't do anything. If the timer has expired we reset the timer and then check if we have scrolled past the home position of our block. If we have, then the first thing is to "unglue" the block by giving it absolute positioning. Then we animate the block over to the side and set it's top position to the top of the window. I have also added easeOutElastic easing to make the animation a little more fun (check out all the types of easing available at this <a href="http://hosted.zeh.com.br/mctween/animationtypes.html">easing types demo</a>). I am also stopping the animation, clearing the queue, and jumping to the end every time the animation is fired, because even with the timer this function will be called a lot and we could potentially have a long queue of animations.</p>

<p>Now, if the user scrolls, and it isn't below the block's home (plus an offset for webkit), then we add the CSS to return the block to it's home. I don't animate it, because I really want the links to be in their home position as soon as the user scrolls up, and doing a really fast animation didn't make sense if the user wasn't going to see the animation anyway. We follow that up by resetting the timer to 0 and then defining the timeout length (250ms in my case, a larger number will have better reliability, but not as smooth of scrolling).</p>

<script src="http://pastebin.com/embed_js.php?i=UF9ki0Xa"></script>

<p>This code is a combination of several methods that I came across while researching how to do a floating sidebar, and I went down several paths before I settled on this code. As a result it is almost surely not optimized (do I need to clear the queue if I am setting a timer anyway?), but it works and should be fairly performant, even in IE. Please leave any suggestions for improvement or any questions in the comments.</p>
