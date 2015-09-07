---
title: (Over)simplify Your Code
date: 2014-04-25
layout: post
cover: simple.jpg
tags: code
---
One of my eureka moments as a developer came when my programming pair suggested I separate some very simple math in the body of a method into another method. At the time it seemed like overkill to create an entirely new method when the operation was so simple. Wouldn't that make it *more* complicated? But I quickly realized the benefits outweighed the cost.

The first benefit is code reuse. This is rather obvious; If we think we might need to do a thing more than once, we throw it into a method so we don't have to write it again.

The next benefit is that when the code needs to change, we can fix it in one place. Pretty straightforward stuff.

Having many small methods separates our code into bite-size chunks that are easier to test. Testing greatly increases the quality of the software we write. Whether you actually practice unit testing or not, you know you should be.

You might think you've heard all this before. However, I'm contending that you should break your code into small methods even if you don't plan on reusing it; even if you don't expect it to change; even if you don't do any unit testing.

I would first argue that you may eventually want to reuse the code, the code *will* need to change at some point, and you *should* be doing some unit testing. Not convinced? Well I have one more benefit for you...

The advantage that didn't hit me until I was encouraged to over-simplify my code is that you no longer have to think about the code in that method, like, at all. Even if it is as simple as dividing two numbers, there is at least a little cognitive overhead in looking at those numbers and determining their function. That subtracts from the mental capacity we have for the problem we are actually trying to solve. Likewise, when we want to work on what the small, extracted operation is actually doing, we don't need to worry about all of the other context of the system.

I love one line methods (as long as they only do one thing). I love taking complex things and breaking them up into simpler pieces. You probably do this most of the time too, but do you still have methods that look like this?

<script src="https://gist.github.com/Ross-Hunter/11144996.js"></script>

In the "shorter" example we have to keep track of the fact that we are actually calculating density, and that density is mass divided by volume, and that the density needs to be less than one for something to float, and to question what the number "1" means. In the example that is broken into methods our brain only has to recognize that the density of the thing needs to be less than the density of water. Not to mention the code is more reusable, flexible, and testable.

Once I challenged myself to over-simplify my code, I became a much stronger developer.

<em>Originally posted on the <a href="http://www.mutuallyhuman.com/blog/2014/04/25/over-simplify-your-code/">MHS Blog</a></em>
