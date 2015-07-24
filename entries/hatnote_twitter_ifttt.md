---
title: Build Your Own Topic Bot
tags:
  - wikipedia
  - code
  - hatnote
---

It's been 10 days since
[the new Wikipedia IFTTT channel launch][launch], and the response has
been amazing. Our backend has seen almost **2.5 million requests** for
Recipe updates, from *tens of thousands* of unique users. In this post
we wanted to do a quick hands-on guide showing one way IFTTT helps
Wikipedians reach a wider web.

[launch]: https://blog.wikimedia.org/2015/07/14/wikipedia-recipes-with-ifttt/

From [drones][eg_drones_twitter] to [Florida news][eg_florida_news] to
[aesthetic][eg_aesthetic_blog_1] [blogs][eg_aesthetic_blog_2] to
[fake news][eg_fake_news] to [drones][eg_drones_tumblr],
topic-specific streams are drawing a big audience these days. Running
one isn't as easy as it looks, though. Content doesn't create and
curate itself. Unless you automate. Case in point, here at Hatnote,
the fleet of special-interest Twitter bots built on
[Wikipedia and IFTTT][wp_ifttt] just keeps getting longer. Here's a
selection from the last week:

  * [@WikiRedlist][wikiredlist]: Track the status of critically endangered species.
  * [@Wikidemics][wikidemics]: Find out when doctors (PhDs, JDs, MDs, etc.) join Wikipedia.
  * [@NotableDeath][notabledeath]: Reports recent passings of people with Wikipedia pages.
  * [@GreeceEdits][greeceedits]: Updates on pages related to the [Greece crisis][greece_crisis].
  * [@SveWikipedia][svewikipedia]: Tweets about opportunities to collaboratively edit Wikipedia.
  * [@FlagsForDays][flagsfordays]: Updates on flag design and [vexillology][vexillology].

<img src="https://40.media.tumblr.com/0879a71fbdaa99cbb752538a0a665915/tumblr_nryuiaodZA1s4aev9o2_540.png">

[eg_drones_twitter]: https://twitter.com/drones
[eg_aesthetic_blog_1]: http://vaporwave.org/
[eg_aesthetic_blog_2]: http://seapunkscully.tumblr.com/
[eg_florida_news]: https://twitter.com/_floridaman
[eg_fake_news]: http://literallyunbelievable.org/
[eg_drones_tumblr]: http://faildrone.com/

[wp_ifttt]: http://blog.hatnote.com/post/124069724187/wikipedia-and-ifttt-a-technical-guide

[wikiredlist]: https://twitter.com/wikiredlist
[wikidemics]: https://twitter.com/Wikidemics
[notabledeath]: https://twitter.com/notabledeath
[greeceedits]: https://twitter.com/greeceEdits
[svewikipedia]: https://twitter.com/SveWikipedia
[flagsfordays]: https://twitter.com/FlagsForDays

[vexillology]: https://en.wikipedia.org/wiki/Vexillology
[greece_crisis]: https://en.wikipedia.org/wiki/Greek_government-debt_crisis

<!-- Idea: Wikipedia on Wikipedia bot. Signpost, Wikipedia page edits, some categories -->

And you can have your very own with 5 simple steps. It only takes
about 10 minutes, so let's get started!

## <a href="#step-1" id="step-1">Step 1</a>: Pick a topic

Before signing up for anything, first let's sort out our goals. If
you're running an editathon or are an experienced editor, maybe you
already have a topic or [tracked hashtag][hashtag] in mind. For the
rest of us, English Wikipedia alone has millions of articles and
hundreds of thousands of [categories][category]. Think about your
audience, but above all, pick something *you're* interested in. If
you'd like to pick something out of a hat, try
[a random article][random_article] or try watching
[Listen to Wikipedia][l2w] and seeing if anything catches your
eye. Wikipedia excels as a source of random history and science, but
also current events.

[hashtag]: http://blog.hatnote.com/post/124069724187/wikipedia-and-ifttt-a-technical-guide#edits_with_a_hashtag
[category]: https://en.wikipedia.org/wiki/Help:Category
[random_article]: https://en.wikipedia.org/wiki/Special:Random
[l2w]: http://listen.hatnote.com

Here are some more fun entry points for browsing Wikipedia:

  * [List of lists of lists][list3]
  * [High-level categories][top_cats]
  * [Contents][wp_contents]
  * [Recent changes][recent_changes]
  * [Portals][portal_docs]
    * [Current Events Portal][current_events_portal]
    * [All Portals][wp_portals]

[list3]: https://en.wikipedia.org/wiki/List_of_lists_of_lists
[recent_changes]: https://en.wikipedia.org/wiki/Special:RecentChanges
[wp_contents]: https://en.wikipedia.org/wiki/Category:Contents
[top_cats]: https://en.wikipedia.org/wiki/Category:Main_topic_classifications
[portal_docs]: https://en.wikipedia.org/wiki/Wikipedia:Portal
[wp_portals]: https://en.wikipedia.org/wiki/Category:Portals
[current_events_portal]: https://en.wikipedia.org/wiki/Portal:Current_events

## <a href="#step-2" id="step-2">Step 2</a>: Register your Twitter username

This is the hardest part. Finding and picking a name that is
available. Twitter has [a billion registered users][twillion]. It
might take you a minute or two to come up with a username that doesn't
have two tweets from 2011.

[twillion]: http://www.businessinsider.com/twitter-we-are-a-massive-mobile-ad-network-2014-4

You'll need to create a new Twitter account. Here's a timesaver: Gmail
(and other email providers) treat emails such as
`janedoe+anything@gmail.com` the same as `janedoe@gmail.com`. So you can
skip creating a new email and just use your existing one, such as
`youremail+yournewtwittername@gmail.com`.

## <a href="#step-3" id="step-3">Step 3</a>: Register for IFTTT

Even if you already have an IFTTT account, registering a new one makes
the process go smoother and keeps your Recipes more organized in the
long run. You wouldn't want your bot's recipes mixed up with your
personal ones. You can use the same [email trick from Step 2](#step-2)
on IFTTT.

## <a href="#step-4" id="step-4">Step 4</a>: Connect the IFTTT Channels

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

## <a href="#step-5" id="step-5">Step 5</a>: Create the Recipes

Finally we get to the fun part. Choosing and creating the
recipes. Here's where you get creative, but there are three Triggers
worth highlighting:

 * [Hashtag][hashtag_trigger] ([docs][hashtag_docs]) - Fires on edits with [a #hashtag in the comment][hashtag_guide]. Particularly useful if running an Editathon.
 * [Added to category][add_to_cat_trigger] ([docs][add_to_cat_docs]) - Triggers when an editor adds an article to a Category.
 * [Modified in category][edits_to_cat_trigger] ([docs][edits_to_cat_docs]) - Fires whenever an article in a Category is edited.

[hashtag_guide]: http://blog.hatnote.com/post/112756032432/the-humble-hashtag-now-on-wikipedia
[hashtag_trigger]: https://ifttt.com/channels/wikipedia/triggers/1023086349-new-edit-with-hashtag
[add_to_cat_trigger]: https://ifttt.com/channels/wikipedia/triggers/1704714369-article-added-to-category
[edits_to_cat_trigger]: https://ifttt.com/channels/wikipedia/triggers/1444240077-new-edit-to-article-in-category

[hashtag_docs]: http://blog.hatnote.com/post/124069724187/wikipedia-and-ifttt-a-technical-guide#edits_with_a_hashtag
[add_to_cat_docs]: http://blog.hatnote.com/post/124069724187/wikipedia-and-ifttt-a-technical-guide#article_added_to_a_category
[edits_to_cat_docs]: http://blog.hatnote.com/post/124069724187/wikipedia-and-ifttt-a-technical-guide#edits_to_articles_in_a_category

Depending on how articles have been categorized, to really cover a
subject you may have to create more than one Recipe. Still, this is
Wikipedia. If you see something that can be improved, don't hesitate
to try out creating or adding to a Category!

**And that's it!** Your bot is operational. No backend work necessary,
just some old-fashioned research on a new-fashioned encyclopedia. Here
are some parting tips:

  * Consider sprinkling in human commentary for a more engaging reader
  experience.
  * Keep an eye on posting rate to make sure it's not too fast-paced for
  your service or audience.
  * If there's not enough posts, add more Recipes!
  * If you have an international audience, you may want to use
  [interlanguage links][interlanguage_links], found at the bottom of the sidebar on the left
  of Wikipedia pages, to connect Categories from different languages'
  Wikipedias.
  * If you want to post to other channels, you can have a single recipe
  watch the Twitter feed and copy it over to Tumblr, Facebook, or other
  platform of choice.
  * Twitter recommends you get and maintain real followers as soon as
  possible to ensure that your bot performs well in search rankings.

As always, as soon as you create your bot, tweet at us so we can
[add it to the list][twiki_list]!

<img src="https://40.media.tumblr.com/30e5ab385d8d6eace06073098f9d736b/tumblr_nryuiaodZA1s4aev9o1_540.png">

[interlanguage_links]: https://en.wikipedia.org/wiki/Help:Interlanguage_links
[twiki_list]: https://twitter.com/sklaporte/lists/wikipedia-edits/members
