---
title: Build Your Own Wikipedia-based Web Bot
---

Automation is all the rage these days. So are special-interest blogs,
but they're mostly manual. Case in point, here at Hatnote, the list of
special purpose Twitter bots built on [Wikipedia and IFTTT][] just
keeps getting longer. In this post we'll show you how to set up a
special-purpose web bot in 10 minutes.

<!-- Idea: Wikipedia on Wikipedia bot. Signpost, Wikipedia page edits, some categories -->

## Step 1: Pick a purpose

Before signing up for anything, first let's determine what we're
trying to achieve. If you're running an editathon or are an
experienced editor or admin, maybe you already have a topic or
[tracked hashtag][] in mind. For the rest of us, English Wikipedia
alone has millions of articles and hundreds of thousands of
categories. Think about your audience, but above all, pick something
*you're* interested in. For the truly aimless, try watching
[Listen to Wikipedia][] and seeing if anything catches your
eye. Wikipedia excels as a source of random history and science, but
also current events.

Here are some fun entry points for browsing Wikipedia:

  * [List of lists of lists][]
  * [High-level categories][]
  * [Recent changes][]
  * [Portals][]
    * [Current Events Portal][current_events_portal]

[current_events_portal]: https://en.wikipedia.org/wiki/Portal:Current_events

## Step 2: Register your Twitter username

This is the hardest part. Finding and picking a name that is
available. Twitter has a billion registered users. It might take you a
minute or two to come up with a username that doesn't have two tweets
from 2011.

You'll need to create a new Twitter account. Here's a timesaver: Gmail
(and other email providers) treat emails such as
janedoe+anything@gmail.com the same as janedoe@gmail.com. So you can
skip creating a new email and just use your existing one, such as
youremail+yournewtwittername@gmail.com.

## Step 3: Register for IFTTT

Even if you already have an IFTTT account, registering a new one makes
the process go smoother and keeps your Recipes more organized in the
long run. You wouldn't want your bot's recipes mixed up with your
personal ones. You can use the same email trick from Step 2 on IFTTT.

## Step 4: Connect the IFTTT Channels

Go to [the Wikipedia IFTTT Channel][] and click Connect Channel. No
login information is necessary.

Go to [the Twitter IFTTT Channel][] and click Connect Channel. Then,
log in as the special purpose account we just created to authorize
IFTTT to post on its behalf.

There are many other channels worth exploring as outputs for your Wikipedia
criteria. More on that later.

## Step 5: Create the Recipes

* [Hashtag][] ([docs][])
* [Added to category][] ([docs][])
* [Modified in category][] ([docs][])

Depending on how articles have been categorized, to really cover a
subject you may have to create 10 or more Recipes. Don't forget, this
is Wikipedia. If you see something that can be improved, don't
hesitate to try out editing! Either way, Recipes are easy to
create. Also, if you have an international audience, you may want to
use interlanguage links, found at the bottom of the sidebar on the
left of Wikipedia pages, to connect Categories from different
languages' Wikipedias.

And that's it! Your bot is operational. No backend work necessary,
just some old-fashioned research on a new-fashioned encyclopedia. You
can leave it to post by itself, or, for a more engaging reader
experience, you can take a hybrid approach and occasionally jump in an
provide some human commentary. Keep an eye on traffic to make sure
it's not too fast-paced for your audience. If there's not enough
traffic, add more Recipes!

If you want to post to other channels, you can have a single recipe
watch the Twitter feed and copy it over to Tumblr, Facebook, or other
platform of choice.

Either way, as soon as you create your bot, tweet at us so we can add
it to our list!
