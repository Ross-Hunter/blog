---
title: Configuring Sublime Text 2
date: 2012-10-18
layout: post
---
I have been a (relatively) long time Sublime Text 2 user. Early 2011, I was running Ubuntu on my laptop and wasn't happy with any text editors I was finding. I gazed longingly at TextMate on my colleagues's Macbooks, but overall I was happy with my OS choice and wasn't ready to make that leap. Then I discovered Sublime, and fell in love. Over time I have learned some things, and developed some methods that have made Sublime and I the best of friends.

### Workflow

My first piece of advice is to set up a command line alias for Sublime and open all projects using the terminal. Once you get used to this workflow you will be more efficient. Using the terminal along with an alias, one simply needs to cd into the project and open the folder using " slime . " - the folder is now open in sublime in it's own window.

OS X alias placed in profile (.bash\_profile, .zshrc, .bash\_rc)

<code>alias slime='open -a "Sublime Text 2"'</code>

### Search Across Open Project

<code>["super+t"]</code> opens a fuzzy finder that allows you to very quickly switch between files based on the filename. <code>["super+shift+f"]</code> opens the find in folders display. This is incredibly useful for discovering where a method or variable is being used, or where it is defined. <code>["super+alt+f"]</code> opens the find & replace dialog.

<em>Learn Regular Expressions!</em> - This will make the search so much more powerful. You don't have to become a regex master, but some simple things like understanding capturing groups for find & replace will save you a lot of time when doing code refactoring. Sublime uses the Boost Syntax for regex.

### Window Management

First I suggest figuring out a window management system that works for you. If you are on Windows 7 or Ubuntu, the built in window snapping works pretty well. The default window management on OS X is not great, so I like to use a program like Better Touch Tool to allow me to quickly maximize windows to the left, right, or full-screen. I then add to my Key Bindings - User file settings to quickly hide and expand the sidebar and gutter.

<code>{ "keys": ["ctrl+s"], "command": "toggle\_side\_bar" }, 
{ "keys": ["ctrl+1"], "command": "toggle\_setting", "args": {"setting": "gutter"} },</code>

I use these combined with the side-by-side pane view ["super+alt+2"] in order to most efficiently use my screen real-estate.

### Sublime Settings

You may want to spend some time perusing the Settings - Default file available from preferences. This will show you what settings are available. Do not make any changes to the defualt settings file, instead, add overrides to the Settings - User file.

Here are some settings that I suggest adding to the Settings - User file

<code>"bold\_folder\_labels": true, # makes the sidebar a little easier to understand
"caret\_style": "phase", # looks cool :p
"highlight\_line": true, # adds a subtle highlight to the current line
"translate\_tabs\_to\_spaces": true, # in general this is good practice
"trim\_trailing\_white\_space\_on\_save": true, # trims trailing whitespace
"scroll\_past\_end": true # I don't like to work at the very bottom of my screen</code>

### Install Packages

First install Package Manager if you don't already have it. Then, use the command pallette ["super+shift+p"] and type "install package" to activate the Package Manager. Here are some suggestions:

<em>Languages</em> - Install any languages you use on a regular basis that are not included in vanilla Sublime. Some languages are just the syntax, others may add snippets, or even build environments.

<em>SublimeLinter</em> - This package allows for realtime syntax checking - and can greatly reduce the amount of time you spend looking for bugs.

<em>Sidebar Enhancements</em> - This adds some extra file operations and functionality to the sidebar such as new folder, cut, copy, rename etc.

<em>Ruby Test</em> - Really easy way to run individual tests right from within sublime.

<em>FileDiffs</em> - This can be a really useful tool for diffing files. I use a tool like GitX to examine the source of past commits, copy the text to the clipboard, and then use FileDiffs to diff with my clipboard. It's not perfect, but I don't find myself needing to look at diffs in Sublime terribly often.

<em>Auto Semi-Colon</em> - Automatically moves ; outside of () while typing. [function(arg;) => function(arg);]

### Misc. Tips

<code>["ctrl+d"]</code> selects the word the caret is on. Pressing again selects the next instance of that word and allows you to simply type and replace all the selected words. This can be much faster for simple uses than find and replace.

<code>["ctrl+g"]</code> opens up a "go to line" panel. Very useful for big files.

Map caps lock to control - Why is caps lock a huge button right next to your pinky, but control is a tiny button down at the bottom? Google how to map keys for your OS.

<code>["super+shift+v"]</code> is default the command for paste and indent. Some folks may want this to be the default behavior - simply add this to the Key Bindings - User file to swap the keybindings.

<code>{ "keys": ["super+v"], "command": "paste\_and\_indent" },
{ "keys": ["super+shift+v"], "command": "paste" },</code>

### In conclusion

Sublime Text is fast becoming one of the most popular text-editors among web developers and designers and it's cross-platform design and package manager give it a leg up over TextMate.

As a craftsmen it is important to understand and use our tools properly. Just as a painter needs to use the best paint and brushes - and understand how to use them - a developer should understand and use the best software tools available. For me, Sublime Text is the highest-quality brush available.

### Update

NetTuts has produced a great Sublime Text 2 screencast series that includes many of my tips above, but dives even deeper. Very highly recommended if you are looking for even more tricks.

<em>Originally posted on the <a href="http://www.mutuallyhuman.com/blog/2012/10/18/configuring-sublime-text-2/">MHS Blog</a></em>
