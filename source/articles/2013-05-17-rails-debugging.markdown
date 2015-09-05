---
title: Better Rails Debugging with better_errors and jazz_hands
date: 2013-05-17
layout: post
---
<h3>Go beyond the stacktrace with 2 gems that grant you debugging superpowers.</h3>

<h3>Better Errors</h3>

<p>Does this screen look familiar? Do you notice anything wrong with this picture?</p>

<img src="http://www.mutuallyhuman.com/assets/posts/2013/05/better_errors/default.png">

<p>That is correct, that is the default Rails error page and you are absolutely right, it is completely hideous and hurts to look at. It is begging to be improved.</p>

<p>By answering these questions you have already proven yourself to be quite a smart cookie, my dear reader, so you probably can guess what a gem called <a href="https://github.com/charliesome/better_errors">`better_errors`</a> does. However, you might not realize just how much of an improvement `better_errors` actually is.</p>

<br>
<aside>
<header>Basic `better_errors` stats:</header>
<ul>
<li>Full stack trace</li>
<li>Source code inspection for all stack frames (with highlighting)</li>
<li>Local and instance variable inspection</li>
<li>Live REPL on every stack frame</li>
</ul>
</aside>
<br>

<img src="http://www.mutuallyhuman.com/assets/posts/2013/05/better_errors/better_errors.png">

<p>It is clearly more visually appealing, but it also provides much more detailed debug information, as well as providing a REPL for interacting with the code (assuming you have the separate <a href="https://github.com/banister/binding_of_caller">binding_of_caller</a> gem installed).</p>

<p>One of my favorite parts of better_errors is that it filters application frames in the stacktrace, so when debugging you can focus (at least at first) on the code *you* are writing and less on the Rails internals. The flipside of that is that by showing you a little bit of code context, as well as local variables, instance variables, request info, and providing a REPL for the full stacktrace, it is much easier to examine those Rails internals and pick up on that Rails Magic™ going on.</p>

<p>If you are debugging a Rails API, AJAX, want to investigate a non-critical error like missing images, or for any other reason don't access the error page directly at the time of the error `better_errors` provides a page accessible via the url "/__better_errors" which contains the error page for the last error on the server.</p>

<p>Another awesome part of `better_errors` is that it can open up files in your editor! It comes out of the box with support for textmate, but also supports for vim and a couple other editors. You can add Sublime Text by downloading <a href="https://github.com/asuth/subl-handler">sublime-handler</a> and configuring an initializer for `better_errors` that simply contains:</p>

<p><code>BetterErrors.editor = :sublime if defined? BetterErrors</code></p>

<p>The error page page is even responsive! This is an extremely polished gem and I simply can't live without it.</p>

<h3>Jazz Hands</h3>

<p>When I need to really get my mitts in there and dig around for debugging, I like to use <a href="https://github.com/nixme/jazz_hands">`jazz_hands`</a>.</p>

<aside>
<header>`jazz_hands` is collection of gems built around the popular IRB replacement `pry`. It includes:</header>
<ul>
<li>Pry for a powerful shell alternative to IRB.</li>
<li>Awesome Print for stylish pretty print.</li>
<li>Hirb for tabular collection output.</li>
<li>Pry Rails for additional commands (show-routes, show-models, show-middleware) in the rails console.</li>
<li>Pry Doc to browse Ruby source, including C, directly from the console.</li>
<li>Pry Git to teach the console about git. Diffs, blames, and commits on methods and classes, not just files.</li>
<li>Pry Remote to connect remotely to a Pry console.</li>
<li>Pry Debugger to turn the console into a simple debugger.</li>
<li>Pry Stack Explorer to navigate the call stack and frames.</li>
<li>Coolline and Coderay for syntax highlighting as you type. Optional. MRI 1.9.3/2.0.0 only</li>
</ul>
</aside>
<br>

<p>This is not intended to be an exhaustive tutorial on how to debug using `pry`, but suffice it to say I mostly interact with `pry` by setting breakpoints with `binding.pry` in my source code to launch the pry REPL in the terminal running my rails server. `better_errors` is great at catching exceptions and helping to isolate a problem by showing the stacktrace, but once you know the problem and need to experiment in order to figure out the solution, `pry` is a much more powerful tool than the REPL provided by `better_errors`.</p>

<p>The part of the `jazz_hands` extension that I interact with the most is `awesome print`. This provides a prettier output in the REPL when getting descriptions of objects and variables. `pry-debugger` is also great for allowing you to step through the code right from the REPL. `pry-rails` is great and I find myself using the show-routes functionality frequently.</p>

<img src="http://www.mutuallyhuman.com/assets/posts/2013/05/better_errors/jazz_hands.png">

<p>I have found `pry-git` to be quite buggy and have not been able to use it successfully. The syntax highlighting as you type technically works, but oddly it causes my cursor to be offset by 10 or so characters to the right, so I don't use it.</p>

<h3>In Conclusion</h3>

<p>One of the best things about <a href="https://github.com/nixme/jazz_hands">`jazz_hands`</a> and <a href="https://github.com/charliesome/better_errors">`better_errors`</a> is that they are so simple to set up and have no downsides. These gems are my defaults and are in every single rails project I do. By giving you debugging superpowers these gems can not only be huge time-savers, but they can reduce your stress to add years to your life. Not every gem can say that!</p>

<p><em>Originally posted on the <a href="http://www.mutuallyhuman.com/blog/2013/05/17/better-rails-debugging-with-better_errors-and-jazz_hands/">MHS Blog</a></em></p>
