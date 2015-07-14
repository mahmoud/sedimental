---
title: Wikipedia and IFTTT: A Technical Guide
---
Here at Hatnote we build on Wikipedia a lot. And while we love building projects like [Listen to Wikipedia](http://listen.hatnote.com/) and [The Weeklypedia](http://weekly.hatnote.com/), we have to admit programming, integrating, and maintaining reliable services can be [a lot of work](https://github.com/hatnote/). Creating cool and functional Wikipedia projects remains out of reach of most busy Internet denizens. Until today.

With the aim of bringing Wikipedia to the wider web, [Stephen](https://twitter.com/sklaporte) and [I](https://twitter.com/mhashemi) are pleased to have worked with [Wikimedia](https://en.wikipedia.org/wiki/Wikimedia_Foundation) and [IFTTT](https://en.wikipedia.org/wiki/IFTTT) to build [the brand-new Wikipedia IFTTT channel](https://ifttt.com/wikipedia). This post is your usage and technical guide to all things Wikipedia+IFTTT. For the official announcement, [see the Wikimedia blog](http://blog.wikimedia.org/2015/07/14/wikipedia-recipes-with-ifttt/).

![IFTTT Logo](https://40.media.tumblr.com/c9936d5d5f024d3d9be123c86c336794/tumblr_nrhes0PCQW1r07l56o1_1280.png)

IFTTT connects web services, so when something happens on one service (the *Trigger*), it pushes an update to another service (the *Action*). With the new Wikipedia channel, so you can create customized combinations, called *Recipes*, to plug Wikipedia into your Internet ecosystem. With this new channel, Wikipedia offers eight new Triggers that can be connected to IFTTT’s [200+ other channels](https://ifttt.com/channels/), including [email](https://ifttt.com/channels/email), [phone](https://ifttt.com/phone_call), [Android](https://ifttt.com/android_device), [iOS](https://ifttt.com/ios_notifications), [Twitter](https://ifttt.com/twitter), [Tumblr](https://ifttt.com/tumblr), [Slack](https://ifttt.com/slack), and [many more](https://ifttt.com/channels/). There are already [dozens of example Wikipedia Recipes](https://ifttt.com/p/wikipedia/shared) ready for activation.

Even if you’re already familiar with IFTTT, a few things set Wikipedia apart from other channels. Foremost, whereas most other services provide an API to data and information, Wikipedia [provides a direct interface to curated knowledge](https://en.wikipedia.org/wiki/DIKW_Pyramid). So trust us when we say it pays to invest in learning the special nature of Wikipedia, as seen through the lens of the new IFTTT Triggers.

## <a href="#daily_triggers" name="daily_triggers">The Daily Triggers</a>

* **[Article of the Day](https://ifttt.com/channels/wikipedia/triggers/1401736982-article-of-the-day)**
* **[Picture of the Day](https://ifttt.com/channels/wikipedia/triggers/1449808817-picture-of-the-day)**
* **[Word of the Day](https://ifttt.com/channels/wikipedia/triggers/698971924-word-of-the-day)**

The simplest of the new Triggers, these three update once per day around midnight [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time). Their simplicity makes them the perfect candidates to introduce *Wikipedia Fact #1*:

> **Fact #1: There are many Wikipedias!** Most people are familiar with Wikipedia as one site. But unlike other IFTTT channel providers, the fact is there is[ one Wikipedia per language](https://meta.wikimedia.org/wiki/List_of_Wikipedias), each with its own conventions and quirks. We’ve made all the new Triggers customizable for all Wikipedia’s 290 languages. So keep in mind for future triggers, a recipe that works well on one language, may not apply at all to the others. As a multilingual Wikipedia editor, I’ve found clicking[ the interlanguage links](https://en.wikipedia.org/wiki/Help:Interlanguage_links) on individual articles and referring to[ the Weeklypedia archives](http://weekly.hatnote.com/) are good ways to get acquainted with the differences.

The Daily Triggers are are an exception to the interlanguage differences. Almost all Wikipedias, regardless of size and age, follow the convention of featured articles. So feel free to [get a weekly dose of free knowledge in your language of choice](https://ifttt.com/recipes/306821-weekly-digest-of-wikipedia-articles)!

## <a href="#edits_to_an_article" name="edits_to_an_article">Edits to an Article</a>

When most people talk about Wikipedia, they’re talking about the articles, Wikipedia’s fundamental unit of knowledge organization. Articles are written by many users contributing what knowledge they can, edit by edit.

On the surface, **[the Edits to an Article Trigger](https://ifttt.com/channels/wikipedia/triggers/926351857-new-edit-to-specific-article)** is simple. If you have a favorite article, IFTTT will monitor it for changes and notify you when an edit occurs. But of course there are caveats.

> **Fact #2: Wikipedia is a uniquely open platform.** That openness is reflected in the data passing through IFTTT APIs. Don’t be surprised to see raw or non-constructive changes made (and usually reverted) by Wikipedia editors, often in quick succession.

> **Fact #3: Wikipedia is a community with many subcommunities.** Quality, approaches, and discipline will vary between these subcommunities. For instance, to match naming conventions, it’s common for articles to be renamed ("moved") multiple times, especially when they’re brand new.

If you’re learning new things from the facts and think you might have some better solutions, Wikipedia [wants to hear about them](https://en.wikipedia.org/wiki/Wikipedia:Village_pump_%28idea_lab%29). In the meantime, you can have IFTTT [DM you on Twitter](https://ifttt.com/recipes/306844-get-twitter-updates-on-a-wikipedia-article) when there are updates to the discussion or new terms that might help in the debate.

## <a href="#edits_from_a_user" name="edits_from_a_user">Edits from a User</a>

Editors write articles. You don’t need to be logged in to edit Wikipedia, but it helps with site customizations and better edit history maintenance. Now, using **[the Edits from a User Trigger](https://ifttt.com/channels/wikipedia/triggers/447356988-new-edit-from-specific-user)** you can easily connect a given user’s edit activity with other social sites, making Wikipedia more personal than ever.

Other than[ Stephen](https://en.wikipedia.org/wiki/User:Slaporte) and [me](https://en.wikipedia.org/wiki/User:MahmoudHashemi), finding interesting users to follow is a topic for another post. But there is one type of user that has garnered a lot of attention in the past: the Bots. Wikipedia’s Bots are more administrative power tool than autonomous overlord, but people [are](http://www.bbc.com/news/magazine-18892510) [still](http://news.discovery.com/tech/robotics/wikipedia-bot-writes-10000-articles-a-day-140715.htm) [obsessed](http://www.technologyreview.com/view/524751/the-shadowy-world-of-wikipedias-editing-bots/). Just as well, because this brings us to the next fact.

> **Fact #4: Wikipedia grows at different speeds.** Some pages change quickly, some slowly. Generally the larger the item, the faster it changes, unless it’s brand new. This is even visible at the site level: [English](https://en.wikipedia.org/wiki/Main_Page) Wikipedia sees about [100,000 changes per day](http://weekly.hatnote.com/archive/en/20150710/weeklypedia_20150710.html), [French](https://fr.wikipedia.org/wiki/Wikip%C3%A9dia:Accueil_principal) has [20,000](http://weekly.hatnote.com/archive/fr/20150710/weeklypedia_20150710.html), and [Farsi](https://fa.wikipedia.org/wiki/%D8%B5%D9%81%D8%AD%D9%87%D9%94_%D8%A7%D8%B5%D9%84%DB%8C) has [200](http://weekly.hatnote.com/archive/fa/20150710/weeklypedia_20150710.html). If your Trigger event is too high-velocity, occurring more than 50 times per hour, it is likely not a good fit for IFTTT, and you could get temporarily blocked by a Recipe’s Action’s service. If it’s too low-velocity, you might be disappointed with an otherwise sound recipe.

Some bots, like [ClueBot](https://en.wikipedia.org/wiki/User:ClueBot_NG), are very active, and would not play well with IFTTT. Other bots edit only a couple times a day, like [SpaceFactsBot](https://en.wikipedia.org/wiki/Special:Contributions/SpaceFactsBot). It updates space-related world records in progress, and would be a fine IFTTT Trigger candidate. Tweet its edits (or your own), by filling in [this recipe](https://ifttt.com/recipes/306831-tweet-your-wikipedia-edits).

## <a href="#edits_with_a_hashtag" name="edits_with_a_hashtag">Edits with a Hashtag</a>

Hatnote is a big fan of [hashtagging on Wikipedia](http://blog.hatnote.com/post/112756032432/the-humble-hashtag-now-on-wikipedia). [Hashtags](https://en.wikipedia.org/wiki/Hashtag) are the best way to unify edits with a common purpose across articles and editors. If you’re editing with friends, colleagues, or Editathon participants, easy-to-use hashtags build momentum and record your hard work.

> **Fact #5: Set up earlier rather than later.** This is hardly specific to Wikipedia, but whenever possible, setting up a recipe beforehand is way easier than retrieving the data later. Don’t forget to test them out to make sure they work! That's what the [Sandbox](https://en.wikipedia.org/wiki/Wikipedia:Sandbox) is for.

With a little bit of forethought and **[the Edits with a Hashtag Trigger](https://ifttt.com/channels/wikipedia/triggers/1023086349-new-edit-with-hashtag)**, you can automatically build that record [into a blog](https://ifttt.com/recipes/306835-publish-edits-from-your-wikipedia-editathon-on-tumblr) or other manifest. You can even [push it to a Google Spreadsheet](https://ifttt.com/recipes/306842-save-edits-from-your-wikipedia-editathon-in-google-drive), and [access that as a form of JSON API](http://codepen.io/nickmoreton/blog/using-ifttt-and-google-drive-to-create-a-json-api), giving you a whole API backend in no time.

## <a href="#article_added_to_a_category" name="article_added_to_a_category">Article added to a Category</a>

We’ve saved the best for last, because now we’re getting into the most complex and exciting Triggers in this release. **[The Article added to Category Trigger](https://ifttt.com/channels/wikipedia/triggers/1704714369-article-added-to-category)** is one of our favorites because it is so open-ended. You can get really creative with them. Just look at these Recipes:

* [Call me if there is a new President of the United States](https://ifttt.com/recipes/306824-call-me-if-there-is-a-new-president-of-the-united-states)
* [Send me an email when a Wikipedia user earns a PhD](https://ifttt.com/recipes/307413-if-a-wikipedia-user-announces-they-have-earned-a-phd-then-send-me-an-email)
* [If The Truth Is Out There, I Want To Believe](https://ifttt.com/recipes/306826-updates-from-the-ufo-sighting-category-on-wikipedia)

In case you hadn’t interacted with them before, [Categories](https://en.wikipedia.org/wiki/Help:Category) can be found by scrolling to the bottom of any Wikipedia article. An article’s associated Talk page often references administrative categories, which are interesting in their own right. In fact, due to technical limitations for this recipe and the next, Talk page changes are automatically resolve to their "main" namespace counterparts. Talk goes to the Article namespace, User talk to User, Project talk to Project, etc. It is not possible to monitor a Talk page exclusively.

Categories are full of promise, and we eagerly anticipate the community’s leveraging of this Trigger, but that promise comes with a price.

> **Fact #6: Wikipedia Categories can be problematic.** First, the caveats of the previous facts apply doubly to Categories. Category systems and conventions vary greatly between communities and languages. Some Categories are huge and change frequently, others are small or even empty, despite having broad-sounding names. Research is necessary.

>Second, Categories often assume an unpredictable tree structure, wherein parent categories do not automatically contain their subcategories’ members. Furthermore, [cycles can exist](https://en.wikipedia.org/wiki/Help:Categories). Finally, due to the way pages are added and removed to Categories, it is possible for a page to appear to be added to a Category multiple times, simply due to editing snafus. Do not actually rely on the Presidential phone call for your think tank’s next strategy summit.

## <a href="#edits_to_articles_in_a_category" name="edits_to_articles_in_a_category">Edits to Articles in a Category</a>

Some would argue the most complex Trigger, but for those who have been following along so far, you can probably guess exactly what this will and won’t do. Use the **[Edits to Articles in a Category Trigger](https://ifttt.com/channels/wikipedia/triggers/1444240077-new-edit-to-article-in-category)** to simultaneously monitor multiple articles related to a specific topic.

From Fact #4, we know that if the topic is too broad, the edit speed may outpace IFTTT’s effectiveness. From Fact #2 and #3 we know that Categories mean different things to different communities. From Fact #6 we know that a given Category may not always be what it appears. And finally, from Fact #1 we know that Categories don’t apply across languages, so we recommend disabling the language customization field for published Category-based recipes.

Add in the Talk-page caveat from the previous Trigger and it’s been a long road, but we’re already reaping the returns. For instance, using the [Tweet about Wikipedia Updates in a Category Recipe](https://ifttt.com/recipes/306840-tweet-about-wikipedia-updates-in-a-category), there are already two special-interest Twitter accounts running solely off Wikipedia with no specific programming overhead whatsoever:

* [@LISedits](https://twitter.com/LISEdits): Tweets about Library Sciences. [We’ve heard librarians love Wikipedia.](https://www.youtube.com/watch?v=gZKkIsWJOt8)
* [@medstubs](https://twitter.com/medstubs): Tweets about newly posted medical articles that could use contributions
* [@wikibreakfast](http://wikibreakfast): Tweets about the most important meal of the day.

When it’s this easy, one might wonder where all the complexity went. Well, if you’re really curious about the technical details, read on.

## <a href="#behind_the_scenes" name="behind_the_scenes">Behind the Scenes</a>

Hard at work at Hatnote HQ:

![Stephen at Sugarlump with Snacks](https://41.media.tumblr.com/76c649b5c03b14a7807f93d781edbeca/tumblr_nrhepu5je41r07l56o1_1280.jpg)

The Article Edit Trigger, User Edit Trigger, and Daily Triggers are based on basic queries to the [Wikipedia API](https://en.wikipedia.org/w/api.php). The Wikipedia channel includes a daily update on the Wikipedia Article of the Day, Wikimedia Commons Photo of the Day, and the Wiktionary Word of the Day. All three of these feeds are also available as RSS feeds from the API.

The Hashtag Trigger and Category Triggers are all based on SQL queries to the [Wikipedia database replicas](https://wikitech.wikimedia.org/wiki/Help:Tool_Labs/Database) that are openly available on [Tool Labs](https://wikitech.wikimedia.org/wiki/Nova_Resource:Tools). The service that does all the API calls, SQL queries, and serves all the IFTTT requests is [written in Python](https://github.com/slaporte/ifttt).

The very astute might notice that all the Wikipedia IFTTT features are Triggers for reading as opposed to Actions for editing. While Wikipedia supports OAuth, there are existing community conventions and affordances for automated editing that require further consideration and discussion.

## <a href="#thanks" name="thanks" id="thanks">Thanks</a>

Many thanks to [Ori](https://github.com/atdt), [Dario](https://twitter.com/ReaderMeter), [Ed](https://twitter.com/edsu), [Niki](https://twitter.com/kikisurvives), [Yuvi](https://github.com/yuvipanda), Kirsten, and many others for their hard work and feedback during the Wikipedia+IFTTT development.

We hope you found the guide useful. If you build anything, tweet it with hashtag [#wpifttt](https://twitter.com/search?q=%23wpifttt) and CC us (our handles are linked below). Happy automating!

-- [Mahmoud](https://twitter.com/mhashemi) and [Stephen](https://twitter.com/sklaporte)
