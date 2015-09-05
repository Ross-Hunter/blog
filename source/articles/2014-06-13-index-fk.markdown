---
title: Index Your Foreign Keys
date: 2014-06-13
layout: post
---
<p>We add indexes to our database in order to speed up read operations. Basically, an index is a sorted copy of a particular set of columns the database uses to quickly look up the attributes of another table, most commonly, foreign keys of relations. There are several ways this can actually be implemented on the database; essentially, we tell the database which values we'll be looking up most often and it sorts the logical and physical storage of the information to make those operations faster.</p>

<p>One downside to this process is that it takes more physical space on disk because we're keeping extra copies of data in our database. Another drawback is that because we're keeping these indexes up to date, we also have extra writes whenever that data changes.</p>

<p>I would advise you to index all of your foreign keys, unless you have good reasons not to. Also, if you're already down with indexes, don't produce any example migration code that doesn't include `index: true` on your foreign keys. I think I was late to the database index game because not enough people are preaching it.</p>

<p>To add indexes to your database, create a migration.</p>

<script src="https://gist.github.com/Ross-Hunter/b5ae27f67398c0565873.js"></script>

<p>You can use <a href="https://gist.github.com/tomafro/191181">this script</a> to find missing indexes in your application.</p>

<p>Here are some performance numbers from an application I have been working on, before and after adding database indexes.</p>

<script src="https://gist.github.com/Ross-Hunter/78c0d895c5f7c90e8c19.js"></script>

<p>Speed increased by 4.4x on a simple query and 2.2x on a complex query. Looking around the internet you will find many other people with even greater speed gains.</p>

<p>You can index non-foreign key fields if you query them a lot, such as `name`, or some other alternative id, and see incredible performance improvements.</p>

<p><em>Originally posted on the <a href="http://www.mutuallyhuman.com/blog/2014/06/13/index-your-foreign-keys/">MHS Blog</a></em></p>
