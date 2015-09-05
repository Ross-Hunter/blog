---
title: Understand Your True $PATH
date: 2012-08-06
layout: post
---
I recently took some time to actually understand what the hell was going on in my terminal config file (I use ZSH, but this post should apply to BASH as well). The thing that pushed me over the edge was that I was running into a situation where I had different versions of git that were being used in different situations. I was working on an Adobe Air app that was somehow using my system git, instead of the one I installed via <a href="http://mxcl.github.com/homebrew/">Homebrew</a>. I tracked the problem down to my PATH and then realized that I didn't fully understand the whole PATH thing as well as I should.

So I opened up my config and my PATH variable looked like a super long unintelligible mess (I wish I had saved a version of it for comparison). I had followed too many tutorials/installation instructions that simply told me to "copy and paste this code into terminal" and it resulted in a ton of things appending to my PATH. There were a lot of words and slashes and it was not clear to me the order in which things were loaded. So I decided to separate each individual path that was being added to my PATH, and put each one on a separate line. This really makes it clear the order in which things load, so that it is clear that things being installed from brew (/usr/local/bin) run before macports or system.

<strong>*Update*:</strong> I bought a new computer and cleaned out my PATH even more, getting rid of macports etc.

<script src="http://pastebin.com/embed_js.php?i=0zq8Wn2R"></script>


Let me know in comments if you have any questions, or suggestions for improvement.
