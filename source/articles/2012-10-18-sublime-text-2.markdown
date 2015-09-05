---
title: Configuring Sublime Text 2
date: 2012-10-18
layout: post
---
<p>I have been a (relatively) long time Sublime Text 2 user. Early 2011, I was running Ubuntu on my laptop and wasn't happy with any text editors I was finding. I gazed longingly at TextMate on my colleagues's Macbooks, but overall I was happy with my OS choice and wasn't ready to make that leap. Then I discovered Sublime, and fell in love. Over time I have learned some things, and developed some methods that have made Sublime and I the best of friends.</p>

<h3>Workflow</h3>

<p>My first piece of advice is to set up a command line alias for Sublime and open all projects using the terminal. Once you get used to this workflow you will be more efficient. Using the terminal along with an alias, one simply needs to cd into the project and open the folder using " slime . " - the folder is now open in sublime in it's own window.</p>

<p>OS X alias placed in profile (.bash_profile, .zshrc, .bash_rc)</p>

<code>alias slime='open -a "Sublime Text 2"'</code>

<h3>Search Across Open Project</h3>

<p><code>["super+t"]</code> opens a fuzzy finder that allows you to very quickly switch between files based on the filename. <code>["super+shift+f"]</code> opens the find in folders display. This is incredibly useful for discovering where a method or variable is being used, or where it is defined. <code>["super+alt+f"]</code> opens the find & replace dialog.</p>

<p><em>Learn Regular Expressions!</em> - This will make the search so much more powerful. You don't have to become a regex master, but some simple things like understanding capturing groups for find & replace will save you a lot of time when doing code refactoring. Sublime uses the Boost Syntax for regex.</p>

<h3>Window Management</h3>

<p>First I suggest figuring out a window management system that works for you. If you are on Windows 7 or Ubuntu, the built in window snapping works pretty well. The default window management on OS X is not great, so I like to use a program like Better Touch Tool to allow me to quickly maximize windows to the left, right, or full-screen. I then add to my Key Bindings - User file settings to quickly hide and expand the sidebar and gutter.</p>

<p><code>
{ "keys": ["ctrl+s"], "command": "toggle_side_bar" },<br>
{ "keys": ["ctrl+1"], "command": "toggle_setting", "args": {"setting": "gutter"} },<br>
</code></p>

<p>I use these combined with the side-by-side pane view ["super+alt+2"] in order to most efficiently use my screen real-estate.</p>

<h3>Sublime Settings</h3>

<p>You may want to spend some time perusing the Settings - Default file available from preferences. This will show you what settings are available. Do not make any changes to the defualt settings file, instead, add overrides to the Settings - User file.</p>

<p>Here are some settings that I suggest adding to the Settings - User file</p>

<p><code>
"bold_folder_labels": true, # makes the sidebar a little easier to understand<br>
"caret_style": "phase", # looks cool :p<br>
"highlight_line": true, # adds a subtle highlight to the current line<br>
"translate_tabs_to_spaces": true, # in general this is good practice<br>
"trim_trailing_white_space_on_save": true, # trims trailing whitespace<br>
"scroll_past_end": true # I don't like to work at the very bottom of my screen<br>
</code></p>

<h3>Install Packages</h3>

<p>First install Package Manager if you don't already have it. Then, use the command pallette ["super+shift+p"] and type "install package" to activate the Package Manager. Here are some suggestions:<p>

<p><em>Languages</em> - Install any languages you use on a regular basis that are not included in vanilla Sublime. Some languages are just the syntax, others may add snippets, or even build environments.</p>

<p><em>SublimeLinter</em> - This package allows for realtime syntax checking - and can greatly reduce the amount of time you spend looking for bugs.</p>

<p><em>Sidebar Enhancements</em> - This adds some extra file operations and functionality to the sidebar such as new folder, cut, copy, rename etc.</p>

<p><em>Ruby Test</em> - Really easy way to run individual tests right from within sublime.</p>

<p><em>FileDiffs</em> - This can be a really useful tool for diffing files. I use a tool like GitX to examine the source of past commits, copy the text to the clipboard, and then use FileDiffs to diff with my clipboard. It's not perfect, but I don't find myself needing to look at diffs in Sublime terribly often.</p>

<p><em>Auto Semi-Colon</em> - Automatically moves ; outside of () while typing. [function(arg;) => function(arg);]</p>

<h3>Misc. Tips</h3>

<p><code>["ctrl+d"]</code> selects the word the caret is on. Pressing again selects the next instance of that word and allows you to simply type and replace all the selected words. This can be much faster for simple uses than find and replace.</p>

<p><code>["ctrl+g"]</code> opens up a "go to line" panel. Very useful for big files.<p>

<p>Map caps lock to control - Why is caps lock a huge button right next to your pinky, but control is a tiny button down at the bottom? Google how to map keys for your OS.</p>

<p><code>["super+shift+v"]</code> is default the command for paste and indent. Some folks may want this to be the default behavior - simply add this to the Key Bindings - User file to swap the keybindings.</p>

<p><code>
{ "keys": ["super+v"], "command": "paste_and_indent" },<br>
{ "keys": ["super+shift+v"], "command": "paste" },<br>
</code></p>

<h3>In conclusion</h3>

<p>Sublime Text is fast becoming one of the most popular text-editors among web developers and designers and it's cross-platform design and package manager give it a leg up over TextMate.</p>

<p>As a craftsmen it is important to understand and use our tools properly. Just as a painter needs to use the best paint and brushes - and understand how to use them - a developer should understand and use the best software tools available. For me, Sublime Text is the highest-quality brush available.</p>

<h3>Update</h3>

<p>NetTuts has produced a great Sublime Text 2 screencast series that includes many of my tips above, but dives even deeper. Very highly recommended if you are looking for even more tricks.</p>

<p><em>Originally posted on the <a href="http://www.mutuallyhuman.com/blog/2012/10/18/configuring-sublime-text-2/">MHS Blog</a></em></p>
