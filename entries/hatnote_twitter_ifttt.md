---
title: Build Your Own Topic Bot
---

From [drones][eg_drones_twitter] to [Florida news][eg_florida_news] to
[aesthetic][eg_aesthetic_blog_1] [blogs][eg_aesthetic_blog_2] to
[fake news][eg_fake_news] to [drones][eg_drones_tumblr],
topic-specific streams are drawing a big audience these days. Running
one isn't as easy as it looks, though. Content doesn't create and
curate itself. *Unless* you automate. Case in point, here at Hatnote, the
fleet of special-interest Twitter bots built on
[Wikipedia and IFTTT][wp_ifttt] just keeps getting longer.

In this post we'll show you how to set up a topic-driven web bot in
10 minutes.

[eg_drones_twitter]: https://twitter.com/drones
[eg_aesthetic_blog_1]: http://vaporwave.org/
[eg_aesthetic_blog_2]:: http://seapunkscully.tumblr.com/
[eg_florida_news]: https://twitter.com/_floridaman
[eg_fake_news]: http://literallyunbelievable.org/
[eg_drones_tumblr]: http://faildrone.com/

[wp_ifttt]: http://blog.hatnote.com/post/124069724187/wikipedia-and-ifttt-a-technical-guide

<!-- Idea: Wikipedia on Wikipedia bot. Signpost, Wikipedia page edits, some categories -->

## Step 1: Pick a topic

Before signing up for anything, first let's determine what we're
trying to achieve. If you're running an editathon or are an
experienced editor or admin, maybe you already have a topic or
[tracked hashtag][hashtag] in mind. For the rest of us, English
Wikipedia alone has millions of articles and hundreds of thousands of
categories. Think about your audience, but above all, pick something
*you're* interested in. For the truly aimless, try watching
[Listen to Wikipedia][l2w] and seeing if anything catches your
eye. Wikipedia excels as a source of random history and science, but
also current events.

[hashtag]: http://blog.hatnote.com/post/124069724187/wikipedia-and-ifttt-a-technical-guide#edits_with_a_hashtag
[l2w]: http://listen.hatnote.com

Here are some fun entry points for browsing Wikipedia:

  * [List of lists of lists][list3]
  * [High-level categories][top_cats]
  * [Contents][wp_contents]
  * [Recent changes][recent_changes]
  * [Portals][wp_portals]
    * [Current Events Portal][current_events_portal]

[list3]: https://en.wikipedia.org/wiki/List_of_lists_of_lists
[recent_changes]: https://en.wikipedia.org/wiki/Special:RecentChanges
[wp_contents]: https://en.wikipedia.org/wiki/Category:Contents
[top_cats]: https://en.wikipedia.org/wiki/Category:Main_topic_classifications
[wp_portals]: https://en.wikipedia.org/wiki/Category:Portals
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

Go to [the Wikipedia IFTTT Channel][wp_channel] and click
[Connect Channel][wp_connect]. You should see a success message in a
moment.

Go to [the Twitter IFTTT Channel][tw_channel] and click
[Connect Channel][tw_connect]. Then, log in as the special-purpose
account we just created to authorize IFTTT to post on its behalf. When
you see the success message, you're done!

There are many other channels worth exploring as outputs for your Wikipedia
criteria. More on that later.

[wp_channel]: https://ifttt.com/channels/wikipedia
[wp_connect]: https://ifttt.com/channels/wikipedia/reactivate
[tw_channel]: https://ifttt.com/channels/twitter
[tw_connect]: https://ifttt.com/channels/twitter/reactivate

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
platform of choice. Also note that Twitter recommends you get and
maintain real followers as soon as possible to ensure that your bot
performs well in search rankings.

Nevertheless, popular or not, as soon as you create your bot, tweet at
us so we can add it to the list!
