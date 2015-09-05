---
title: ActiveRecord Associations & You
date: 2014-06-12
layout: post
---
<p>I love abstraction. It's great to compartmentalize complexity and keep your application modular. SQL is not that. Relying on SQL strings in your code ties your implementation directly to the type, structure, and even the version of your database. ActiveRecord (the ORM behind Rails) is great for letting us focus on our application and not worry so much about the database particulars.</p>

<p>However, understanding relational databases can really help improve the quality and speed of your application. Being able to compose an ERD of your system and understand how to normalize a database will lead to better system design.</p>

<h3>ActiveRecord Associations</h3>

<p>Let's look at the different ActiveRecord relations and point out what is going on in the database. I am going to assume you know how to create migrations to add attributes to a model and focus on the associations.</p>

<strong>belongs_to, has_one</strong>

<p>These are pretty straightforward and are 2 sides of the same relationship. The table of the `belongs_to` model contains a column with the foreign key of the `has_one` model. ActiveRecord expects only one `belongs_to` model to match up to the `has_one`. The `has_one` model should be the one that semantically makes more sense to own the other. For instance, it makes more sense for a profile to `belong_to` a user, rather than the other way around.</p>

<p>Before 4.1, there was a peformance benefit from specifiying that the `has_one` and `belongs_to` were related, but now rails guesses the inverse based on hueristics. If you are on a version previous to 4.1 or your relationship uses a different class name, or other options, you may want to specify the `inverse_of` attribute. This will reduce the number of database calls since ActiveRecord will not go to the database if the object has already been loaded from another association.</p>

<script src="https://gist.github.com/Ross-Hunter/f2539f3e2fd09ad4eb5c.js"></script>


<strong>belongs_to, has_many</strong>

<p>The same as above, except the `has_many` model is expected to have 0 - Infinity of the `belongs_to` model. For instance, a group might be able to have many members, but a user can only belong to one group.</p>

<script src="https://gist.github.com/Ross-Hunter/349304cfccaeca7075e8.js"></script>

<strong>has_one :through</strong>

<p>This is a way to relate two models through a third model. If a user `has_one` profile, and a profile `has_one` avatar, we can access the user's avatar directly without having to load the entire profile.</p>

<script src="https://gist.github.com/Ross-Hunter/43b85dd2af1d70bad97a.js"></script>

<strong>has_many :through</strong>

<p>Similar to `has_one :through`, this allows us to connect two models through a third model. A user might have many uploaded avatars they can choose from that are associated to the user through the profile.</p>

<script src="https://gist.github.com/Ross-Hunter/d050da14afd00b5d06b7.js"></script>

<p>In some instances it will make sense to create a new connecting model to represent the relationship. For instance a `membership` might make sense to be its own model that can have methods and be queried more easily using activerecord.</p>

<script src="https://gist.github.com/Ross-Hunter/ea122684a5cbd1795083.js"></script>

<strong>has_and_belongs_to_many</strong>

<p>This is used when you want a many-to-many relationship but you don't actually need to interact with the relationship itself. You might have a user with a simple reference to groups they join. Under the hood this is actually just another version of `has_many :through`, but the connector is a join table instead of a "real" model. We don't create a separate class to represent it.</p>

<script src="https://gist.github.com/Ross-Hunter/fc65bc87c1f57f34ed18.js"></script>

<p><em>Originally posted on the <a href="http://www.mutuallyhuman.com/blog/2014/06/12/activerecord-associations-and-you/">MHS Blog</a></em></p>
