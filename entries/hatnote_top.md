---
title: Announcing the Hatnote Top 100
publish_date: 5:00am December 14, 2015
tags:
  - wikipedia
  - hatnote
  - python
---

*Originally published on [the Hatnote blog][orig_pub].*

Moreso than any other major site, [Wikipedia][wp] is centered around
knowledge, always growing, and brimming with information. It's
important to remember that the insight of our favorite community-run
encyclopedia often follows the focus of its massive readership. Here
at Hatnote, we've often wondered, what great new topics is the
community learning about now?

To shed more light on Wikipedia's reading habits, we're pleased to
announce the newest addition to the Hatnote family: **The Hatnote Top
100**, available at **[top.hatnote.com][top]**. Because we can't pass
up a good headwear-based pun.

Updated daily, the Top 100 is a chart of the most-visited articles on
Wikipedia. Unlike the edit-oriented [Listen to Wikipedia][l2w] and
[Weeklypedia][weekly], Top 100 focuses on the biggest group of
Wikipedia users: the readers. Nearly 20 billion times per month,
[around 500 million people][500m] read articles in over 200
languages. Top 100's daily statistics offer a window into where
Wikipedia readers are focusing their attention. It also makes for a
great way to discover great chapters of Wikipedia one wouldn't
normally read or edit.

<a href="http://top.hatnote.com" target="_blank"><img width="40%"
title="A screenshot of the Hatnote Top 100 from December 10, 2015"
src="https://41.media.tumblr.com/85ece35a58888f09b20733d6f0f3d0c2/tumblr_nzclixxtTV1s4aev9o1_1280.png"></a>

Clear rankings, day-to-day differences, social media integration,
permalinks, and other familiar simple-but-critical features were
designed to make popular Wikipedia articles as relatable as albums on
a pop music chart. In practice, popular news stories and celebrities
definitely make the Top 100, but it is satisfying to see interesting
corners of history and other educational topic sharing, if not
dominating, the spotlight.

In addition to a clear and readable report, Top 100 is also a
machine-readable archive, with reports dating back to November 2015,
including JSON versions of the metrics, as well as
[RSS feeds for all supported languages and projects][rss]. It's all
available in over a dozen languages (and we
[take requests for more][issues]). The data comes from a variety of
sources, most direct from Wikimedia, including
[a new pageview statistics API endpoint][pageview_api] that we've been
proud to pilot and continue to use. And yes, as with all our projects
[the code is open-source][top_gh], too.

For those of you looking to dig deeper than Wikipedia chart toppers,
there are several other activity-based projects worth mentioning:

* [stats.grok.se][grokse] - The original, venerable pageview grapher and API
* [Wikimedia Report Card][wrc] - Advanced metrics and data used by the Wikimedia Foundation
* [The Open Wikipedia Ranking][wikirank] - Traffic stats and more
* [@WikipediaTrends][wikitrends_tw] - A bot posting notable upward traffic spikes
* [The Top 25 Report][top_25] - A manually-compiled weekly report of views and likely reasons
* [The Weeklypedia][weekly] - Weekly edit statistics, emailed and archived by Hatnote

And there are other visualizations on [seealso.org][seealso] as
well. But for those who like to keep it simple, hit up the
[Hatnote Top 100][top], [subscribe to a feed][rss], and/or
[follow us on Twitter][hatnotable]. See you there!

[orig_pub]: http://blog.hatnote.com/post/135182048397/announcing-the-hatnote-top-100
[wp]: http://wikipedia.org/
[l2w_app]: https://itunes.apple.com/us/app/listen-to-wikipedia/id832934300
[top]: http://top.hatnote.com
[top_gh]: https://github.com/hatnote/top/
[500m]: http://blog.wikimedia.org/2013/04/19/wikimedia-projects-500-million/
[issues]: https://github.com/hatnote/top/issues

[l2w]: http://listen.hatnote.com
[weekly]: http://weekly.hatnote.com
[rss]: http://top.hatnote.com/about.html#feeds
[pageview_api]: https://wikimedia.org/api/rest_v1/?doc#!/Pageviews_data/get_metrics_pageviews
[wikirank]: http://wikirank.di.unimi.it/
[hatnotable]: https://twitter.com/hatnotable
[grokse]: http://stats.grok.se
[wrc]: https://reportcard.wmflabs.org/
[top_25]: https://en.wikipedia.org/wiki/Wikipedia:Top_25_Report
[wikitrends_tw]: https://twitter.com/WikipediaTrends
[seealso]: http://seealso.org
