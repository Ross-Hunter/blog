---
title: Topic Based Retro
date: 2016-05-09
layout: post
tags: team, retro
---
At [Modustri](http://modustri.com) we have always had weekly retrospectives amongst the dev team. We tried a couple different formats, but now we do a simple format that we call a "topic-based" retro.

The concept is simple, throughout the course of the week, if you run into something that you would like to discuss with the whole dev team, you simply post it into our "retros" slack channel, and we will cover it at our weekly retro. Here are a couple examples of real topics

- topic: let’s clarify the guidelines for branching from staging vs. develop
- topic: bugfixes aren’t getting merged back into develop.
- topic: testing new API releases against current mobile clients.
- topic: messaging up when shit’s not going as planned.
- topic: how can we avoid two-week long PRs?

So a topic can simply be a reminder of existing process that was already decided and just needs to be reiterated (fix bugs in staging, merge back to develop), or just the start of a conversation (how can we avoid long PRs?). Anyone can add a topic, and it will get discussed in the retro.

This has decreased the overall time we spend in retro by a lot, and improved the quality of the time we do spend. Previously we had a tendency to fill the time allotted. Every retro had lots of moments of silence when the whole team was thinking of "pluses" or "deltas". Now we go through our topic list, and end when we run out of topics. If there are no topics posted, we simply don't hold a retro that week (that actually happened this week for the first time).

One person records notes and projects/shares their screen, and the rest of the team puts away their computers and phones and pays attention. When a discussion leads to an action item (hopefully it does!), that is noted and assigned to someone if necessary. That is then posted back into that same slack channel.

- Look into developer dashboard for build statuses. - jason
- Always strive to make your git commits be revertable units.
- Our Arrow is pointing left on Long PRs.

We then post these notes back into the same slack channel. At the beginning of the next retro, we go down the previous week's action items to ensure we are following through on topics.

If you are looking for a simple retro format that focuses on getting stuff done, try a "topic-based" retro.


