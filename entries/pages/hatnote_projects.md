---
title: Hatnote and Wikipedia Projects
entry_id: hatnote_projects
field_role_map:
  content: description
field_label_map:
  gh_link: View on GitHub
  project_link: Visit project

---

Every day I wake up happy that one of my favorite websites, [Wikipedia][en_wp],
is free, open, and well-supported. My wiki-timeline summarized:

* **2003**: First memory of using Wikipedia, as a high school student in Iran.
* **2007**: First time setting up [MediaWiki][mediawiki], the software
    that runs Wikipedia.
* **2012**: Attended my first Wikimedia Foundation hackathon, in San Francisco.
* **2013**: Founded **[Hatnote][hatnote]**, with
    [Stephen LaPorte][stephen_twitter]. (Follow us on [our blog][hatnote_tumblr] or [Twitter][hatnote_twitter].)

Today, I am still a student of Wikipedia. I use it dozens of times a
day, and you'll see it cited throughout anything I write. I also
continue to proudly host and administrate MediaWiki, though my
extension-writing skills have languished. But this is mostly a story
about building on Wikipedia: the story of Hatnote.

<img title="Hatnote's logo and mascot, The Hatterpillar" width=18%
src="/uploads/hatnote/hatnote_logo_lg.png" />

[en_wp]: https://en.wikipedia.org
[mediawiki]: https://en.wikipedia.org/wiki/MediaWiki
[hatnote]: http://blog.hatnote.com/
[stephen_twitter]: https://twitter.com/sklaporte
[hatnote_twitter]: https://twitter.com/hatnotable
[hatnote_tumblr]: http://blog.hatnote.com

[TOC]

# Origins of Hatnote

Hatnote is an ongoing umbrella project organized around Wikipedia as a
social and data platform. Or, as we like to put it, finding new
perspectives on wiki life.

Hatnote grew out of a 2012 WMF hackathon, where I fell upon a
disturbing realization. The Wikimedia Foundation, proprietor of my
favorite website, while situated in Silicon Valley, epicenter of
technology, was not teeming with thousands of engineers and data
scientists coming out of the woodwork to defend and support free
knowledge and culture.

I realized, while the foundation was full of talented people and good
intentions, they simply did not have the resources to maximize
innovation potential on Wikipedia. This isn't meant as a
controversy-inducing criticism of the WMF; Wikipedia and other
Wikimedia projects have always relied much more on the community for
regulation and development. To this point, look at the numbers:

* Wikipedia is a top 10 website worldwide
* Hundreds of millions of users
* 15+ projects, including Wiktionary, Commons, and Wikibooks
* 280+ languages
* **Only ~200 employees**

Compare this to other top 100 websites worldwide. I hate to put it in
such economic terms, but Wikipedia's utility per capita, even counting
community members, is off the charts. Besides, when it comes to
innovation, is there even such a thing as "enough"?

The reality is that the WMF is a nonprofit formed to steward these
sites. They keep the servers up, keep the sites usable, and keep it
all above board legally and financially. They're rightfully more
focused on increasing accessibility, with campaigns and features like
[Wikipedia Zero][wp_zero] and [VisualEditor][vised]. Take all of that,
add in community organization of chapters and various events, and it's
not so surprising that Wikipedia doesn't keep up flashy appearances
next to for-profit Silicon Valley neighbors.

So, Stephen and I formed [Hatnote][hatnote] to do what we could to
promote Wikipedia among the Internet's established power users. To add
new types of interaction for new generations of Wikipedia users, to
help people remember that Wikipedia is more than just the first, best
result on every search site, and to keep it all free.

[wp_zero]: https://wikimediafoundation.org/wiki/Wikipedia_Zero
[vised]: https://www.mediawiki.org/wiki/VisualEditor

<img width=100% src="/uploads/hatnote/hatnote_banner_sm.jpg" />

# Hatnote Projects

A list of Hatnote projects, in reverse chronological order. Projects
not listed here can be found either on our [alpha test page][alpha],
[Hatnote's GitHub][hn_gh], or [Stephen's GitHub][stephen_gh].

[alpha]: http://alpha.hatnote.com
[hn_gh]: https://github.com/hatnote
[stephen_gh]: https://github.com/slaporte

---
title: Wikipedia IFTTT channel
gh_link: https://github.com/slaporte/ifttt
project_link: https://ifttt.com/wikipedia
description: |

  [IFTTT][ifttt_wp] (*IF This Then That*) is a web service for
  connecting and automating the sites that make up our online
  ecosystem. Wikipedia didn't have a channel, so with a bit of help
  from some friends, we built one.

  My feelings toward IFTTT are mixed, but because the walls of the
  Internet corporate gardens keep growing taller, I do use it. And if
  sites like Facebook and Buzzfeed have a channel, then Wikipedia
  deserves one, too.

  Last I checked there are tens of thousands of daily users on
  [the Wikipedia IFTTT channel][wp_ifttt], resulting in millions of
  hits to the web application that services user Recipes. That
  application runs on Wikimedia Labs and
  [the code is on GitHub][ifttt_gh].

  If you're intrigued and would like to give it a spin, I've written
  up two guides:

  * [Wikipedia and IFTTT: A Technical Guide][wp_ifttt_guide] - Details
    and examples for every feature.
  * [Build Your Own Topic Bot][wp_ifttt_tw_bot] - A step-by-step guide
    to Twitter automation.

  We hit some decent milestones. Over a million requests per day and
  IFTTT's Top Chef #89 ain't bad:

  <img width=400 src="/uploads/hatnote/ifttt_top_chef.png" />

  [wp_ifttt]: https://ifttt.com/wikipedia
  [ifttt_wp]: https://en.wikipedia.org/wiki/IFTTT
  [wp_ifttt_guide]: http://blog.hatnote.com/post/124069724187/wikipedia-and-ifttt-a-technical-guide
  [wp_ifttt_tw_bot]: http://blog.hatnote.com/post/124917412833/build-your-own-topic-bot
  [ifttt_gh]: https://github.com/slaporte/ifttt

---
title: Wikipedia Social Search
gh_link: https://github.com/hatnote/hashtag-search
project_link: http://tools.wmflabs.org/hashtags/
description: |

  Wikipedia's community is unlike any other online. Something about
  the system's radical user inclusionism, combined with a mission to
  realize the original intent of the Internet, an interconnected
  knowledgebase that anyone can edit, has attracted people from all
  walks and corners.

  <img width=300 src="/uploads/hatnote/wp_social_search_20151026.png" />

  But even unique communities expectations will evolve as people join
  from surrounding communities. Toward that end,
  [Wikipedia Social Search][wss] adds some familiar functions back to
  Wikipedia: #hashtags and @mentions. Now if you make an edit to
  Wikipedia with hashtags or mentions, we parse it out and index it
  ([with this batch job][hashtags_batch_gh]). Perfect for editathons
  and tracking ad hoc organized editing. This feature also makes an
  appearance in the IFTTT channel, with
  [the hashtags trigger][hashtag_trigger].

  [wss]: http://tools.wmflabs.org/hashtags/
  [hashtags_batch_gh]: https://github.com/hatnote/hashtags
  [hashtag_trigger]: https://ifttt.com/channels/wikipedia/triggers/1023086349-new-edit-with-hashtag

---

title: The Weeklypedia
gh_link: https://github.com/hatnote/weeklypedia
project_link: http://weekly.hatnote.com
description: |

  As much as one might like Wikipedia, it moves so quickly that it can
  be hard to track when major editing events occur. Email digests are
  a common solution to this problem, and are more relevant than
  ever. Many social networks have email to thank for retaining active
  users, who might otherwise forget they have an account (looking at
  you LinkedIn and Twitter).

  [The Weeklypedia][weeklypedia] is an aptly-named weekly summary of
  the most edited Wikipedia articles, available in 15+
  languages. Skimming an issue only takes a couple minutes and can
  yield surprising results. The data used to generate The Weeklypedia
  is [also available][weeklypedia_data]. Monitoring is achieved with
  [cronfed][cronfed].

  [weeklypedia]: http://weekly.hatnote.com
  [weeklypedia_data]: https://github.com/hatnote/weeklypedia-history/
  [cronfed]: http://sedimental.org/open_source_projects.html#cronfed

---

title: Listen to Wikipedia Mobile App
project_link: https://itunes.apple.com/us/app/listen-to-wikipedia/id832934300
description: |

  [Listen to Wikipedia](#listen_to_wikipedia) is Hatnote's most
  popular project. And while the mobile site worked on the phones we
  tested, the sheer number of user emails and messages we got prove
  that native apps have a certain je ne sais quoi for some people.

  [Bryan Oltman][boltman] crafted [the wonderful iOS app][l2w_ios]. I
  may have helped a little, but I probably got in the way as often as
  I contributed.

  I played around with the beginnings of an Android app, written in
  [Kivy][kivy]. You can find [that experiment on GitHub][l2w_native].

  [boltman]: http://bryanoltman.com/
  [l2w_ios]: https://itunes.apple.com/us/app/listen-to-wikipedia/id832934300
  [l2w_native]: https://github.com/hatnote/l2w-native
  [kivy]: http://kivy.org/

---

title: See, Also
gh_link: https://github.com/hatnote/seealso
project_link: http://seealso.org/
description: |

  <img width=400 src="/uploads/hatnote/seealso_20151026.png" />

  A play the common ["See Also"][see_also_wp] heading in Wikipedia
  articles, [*See, Also*][see_also] is a virtual gallery of Wikipedia-derived
  interactions and visualizations. After the success of
  [Recent Changes Map][rcmap] and [Listen to Wikipedia][l2w], Stephen
  and I figured we should leverage some of that Hatnote fame to get
  exposure for other wiki-based projects that we found inspiring. The
  architecture of *See, Also* partially inspired [chert][Chert], the
  application that renders this page.

  [see_also_wp]: https://en.wikipedia.org/wiki/Wikipedia#See_also
  [see_also]: http://seealso.org/
  [chert]: http://sedimental.org/open_source_projects.html#chert
  [rcmap]: #recent_changes_map
  [l2w]: #listen_to_wikipedia

---

title: Listen to Wikipedia
gh_link: https://github.com/hatnote/listen-to-wikipedia/
project_link: http://listen.hatnote.com/
description: |

  "Strangely melodic" and "oddly mesmerizing". If you haven't seen and
  heard it yet, [Listen to Wikipedia][l2w] is a real-time auralization of
  Wikipedia growing, one edit at a time.

  <img width=400 src="/uploads/hatnote/l2w_tiny.png" />

  The site is literally [self-explanatory][l2w_blog]. With around 2
  million unique users since 2013, it's been a joy to build and
  run. In addition to extensive news and blog coverage, Stephen and I
  have made appearances everywhere from major media outlets like NPR,
  BBC radio, and French TV to the halls and walls of libraries,
  museums. It also
  [won a Kantar Information is Beautiful award][kantar], in the
  Interactive Visualization category, and was used to conduct multiple
  yoga and meditation sessions.

  Listen to Wikipedia has remarkable staying power. It has tens of
  thousands of regular monthly users, and new
  [people discover it every day][l2w_twitter]. To accomodate that, L2W
  has an uptime over 99% that of its upstream services. It gets its
  data from [Hatnote's websocket][wikimon_stream] streaming from
  [Wikimon][wikimon].

  [l2w]: http://listen.hatnote.com/
  [l2w_blog]: http://blog.hatnote.com/post/56856315107/listen-to-wikipedia
  [l2w_twitter]: https://twitter.com/search?q=listen.hatnote.com
  [kantar]: http://blog.hatnote.com/post/67722486090/beholden-information-is-beautiful
  [wikimon]: https://github.com/hatnote/wikimon/
  [wikimon_stream]: http://alpha.hatnote.com/wikimon-test/index.html

---

title: Recent Changes Map
gh_link: https://github.com/hatnote/rcmap
project_link: http://rcmap.hatnote.com/
description: |

  [<img width=400 src="/uploads/hatnote/rcmap_20151026.png" />](/uploads/hatnote/rcmap_20151026.png)

  Recent Changes Map is a real-time visualization of Wikipedia edits
  by their city of origin.

  Around 10% of edits to Wikipedia are made by unregistered users. No
  other major site so faithfully puts trust in humanity to build and
  rebuild more often than destroy. Millions of articles later,
  Wikipedia stands as a testament.

  Registered Wikipedia users are only known by their user alias, so
  Recent Changes Map uses the IPs of these anonymous users to
  establish an approximate location. The results amazed. So many
  unlikely pairings. South American interest in American Idol, North
  American interest in Japanese animation and wrestling, Commonwealth
  countries interest in each other, and much less predictable results
  amazed the Internet and generated quite a buzz.

  Like [Listen to Wikipedia](#listen_to_wikipedia), the Hatnote Recent
  Changes Map is built on [our websocket stream][wikimon_stream] from
  [Wikimon][wikimon].

  [wikimon]: https://github.com/hatnote/wikimon/
  [wikimon_stream]: http://alpha.hatnote.com/wikimon-test/index.html

---

title: Wapiti
gh_link: https://github.com/mahmoud/wapiti
description: |

  Wikipedia's querying API is one of the richest and most complex
  available. And what Wikipedia lacks in semantic content, it buries
  even further with complicated and inconsistent access patterns.

  Wapiti is an experimental client which rationalizes these
  functional-if-confusing APIs into a Python interface with an highly
  consistent and recombinable API. Wapiti mostly works, but has been
  in the backseat for a while due to more pressing projects.

---
title: WOMP
gh_link: https://github.com/mahmoud/womp
description: |

  Wikipedia Open Metrics Platform, or WOMP, was created as a console
  to fetch, extract, and organize data, using [Wapiti](#wapiti),
  Hatnote's Wikipedia API client. The idea was to build an application
  you didn't have to be a programmer to use. WOMP was created for and
  inspired by [Adrianne Wadewitz][adrianne]'s research into
  Wikipedia's community dynamics. Development took a break when her
  data was fetched, and with [her passing][adrianne_rip], is on
  indefinite hiatus. I hope I get back to working on it someday.

  [adrianne]: https://en.wikipedia.org/wiki/Adrianne_Wadewitz
  [adrianne_rip]: http://www.nytimes.com/2014/04/20/business/media/adrianne-wadewitz-37-wikipedia-editor-and-academic-dies.html?_r=0

---

title: Disambiguity
gh_link: https://github.com/hatnote/Disambiguity
description: |

  Wikipedia grows quickly, almost 0.1% per week. With 700 new articles
  per day, older pages can barely keep up. One way Wikipedia
  experiences growing pains is this:

  Let's say there's a "Mars" article, talking about
  [the planet][mars_planet], and all the astronomy articles link
  there. When Wikipedia's definition of "Mars" grows to encompass the
  [Roman god][mars_myth] and [chocolate bar][mars_candy], the "Mars"
  is replaced with a "disambiguation" page, like
  [this one][mars_dab]. Now it might not be clear from reading the
  article linking to "Mars" which Mars is intended. Imagine that
  problem, but in the context of names like "John Smith" and so forth.

  This is a hard problem for Wikipedians, and we decided to tackle it
  by gamification (of course. 2012!). Suffice to say, Disambiguity was
  a very challenging, very fun, and very niche game to both play and
  build. It was featured at Wikimedia's 2012
  [Maker Faire][maker_faire] booth. Stephen has the story,
  [in photos][maker_faire_photos].

  [mars_planet]: https://en.wikipedia.org/wiki/Mars_%28planet%29
  [mars_myth]: https://en.wikipedia.org/wiki/Mars_%28mythology%29
  [mars_candy]: https://en.wikipedia.org/wiki/Mars_%28chocolate_bar%29
  [mars_dab]: https://en.wikipedia.org/wiki/Mars_%28disambiguation%29
  [maker_faire]: https://en.wikipedia.org/wiki/Maker_Faire
  [maker_faire_photos]: https://www.flickr.com/photos/slaporte/albums/72157629891589994

---
title: Qualityvis
gh_link: https://github.com/mahmoud/qualityvis
description: |

  The project that started it all. Originally proposed and implemented
  in [a two-day Wikimedia Foundation hackathon][hackathon], the
  creatively named Qualityvis aimed to solve one of the hardest
  problems on Wikipedia: **finding something to edit**.

  [hackathon]: https://www.mediawiki.org/wiki/San_Francisco_Hackathon_January_2012

  Originally based on hand-picked heuristics, Qualityvis grew into a
  full-scale Big Data + machine learning project. We extracted
  hundreds of dimensions for hundreds of thousands of pages and
  revisions to establish a baseline quality evolution gradient. We
  looked at:

    * **Internal factors**, such as page structure, media content, and citations.
    * **Interpage factors**, like categorization, linkage, and template usage.
    * **External dimensions**, including Google search and news results.

  We eventually achieved an **85% success rate at identifying Featured
  articles**. More importantly, we did so with a method, built on
  [MARS][mars], which, unlike neural networks and other opaque
  solvers, retained *explainability* of the model. That meant we could
  direct users to a prioritized set of actions that would increase
  article quality. The technique also resulted in compact and portable
  models which could be easily inspected and ported for use in other
  stacks, like frontend JavaScript.

  Qualityvis won us second place at the WMF hackathon, and ended up on
  indefinite hiatus, as we stalwartly marched into the bog of
  automation and repeatability, before being swept into wide-appeal
  projects like [Listen to Wikipedia](#listen_to_wikipedia) and
  [RCMap](#recent_changes_map).

  Qualityvis taught me a lot about machine learning, the quality of
  open source (especially Node.js and certain unnamed Python
  libraries), and project management.

  [mars]: https://en.wikipedia.org/wiki/Multivariate_adaptive_regression_splines

---
# People

<a href="/uploads/hatnote/wmf_hackathon_2012_group_lg.jpg"
target="_blank"><img title="Can you spot us?" width=100%
src="/uploads/hatnote/wmf_hackathon_2012_group_sm.jpg" /></a>

Hatnote has a lot of projects under its collective belt and it's taken
a lot of work from a lot of people. Hatnote credits roll:

* [Stephen LaPorte][stephen]
* [Mahmoud Hashemi][mahmoud]
* [Ori Livneh][ori] - IFTTT channel and environment
* [Bryan Oltman][boltman] - iOS App and Wapiti docs
* [Kenneth Samonte][ken] - Graphics
* [Sarah Nahm][sarah] - Qualityvis and Disambiguity
* [Mark Williams][mark] - Disambiguity
* [Dario Taraborelli][dario] - Various consultations
* [Moiz Syed][moiz] - Design consultations

I hope I'm not missing anyone. Going on three years and a dozen
projects, keeping track is tough! But thanks to everyone who's ever
helped, whether through code, filing issues, or simple promotion. I
really appreciate it.

[stephen]: https://twitter.com/sklaporte
[mahmoud]: https://twitter.com/mhashemi
[ori]: https://github.com/atdt
[boltman]: http://http://bryanoltman.com/
[ken]: http://kensamonte.tumblr.com/
[sarah]: http://info.sarahnahm.com/
[mark]: https://github.com/markrwilliams/
[dario]: https://twitter.com/readermeter
[moiz]: http://moiz.ca/
