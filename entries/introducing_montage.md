---
title: Introducing Montage
---

Imagine, for a moment, organizing and judging a competition with a
quarter of a million contestants. To make things more interesting, you
have to pick the winners without standard tools or processes. To top
it off, do it year after year for the better part of a decade. New
year, new people, new processes.

If it sounds hard, then consider thanking your local Wiki Loves
Monuments volunteer. Thanks to the Commons community,
[2016 just saw][results_2016] another successful iteration of
[the world's largest photography competition][guinness].

[results_2016]: https://www.wikilovesmonuments.org/winners-2016/
[guinness]: http://www.guinnessworldrecords.com/world-records/largest-photography-competition/

If you were surprised to learn that for 6 years the largest
photography competition gathered over a million submissions from over
50 countries and counting, with little to no standard process, join
the club.

The lack of tooling has been a damper on organizers, as well as
overall participation for the past several years. Less participation
means fewer photos, and nobody wants to see less media on Wikipedia.

But how do you prescribe a standard process without recommending
standard tools, and how do you build standard tools without a standard
process?  This year, the international team of Wiki Loves Monuments
organizers set out to quash this chicken-and-egg problem, with a
little help from [Hatnote][hatnote].

Today, we're happy to present **Montage**, the web platform used to
judge Wiki Loves Monuments 2016.

<img src="/uploads/hatnote/montage_intro/montage_announce_banner.jpg" width="100%">

[hatnote]: http://hatnote.com

[TOC]

# Overview

We started by looking at all the independent processes and
[tools][jury_tools] used over the years. We wanted to make it easier
than ever to organize a photography contest on Wikimedia Commons, and
including communities who could not participate regularly. Before
long, a new design emerged, one which would enable a standard
recommended process, streamlined for future participants.

For those unfamiliar with the Wiki Loves Monuments competition, here
is a handy executive summary:

1. Countries have one or more official lists of national or regional
   heritage sites. These lists make it onto Wikipedia with
   [a little help from officials, volunteers, and bots][list_import_infographic].
2. Local contest coordinators self-organize on their language-specific
   wiki, then contact the international team to indicate their country's
   participation.
3. These coordinators advertise the contest on their wiki, social
   media, and elsewhere.
4. Contest submissions are accepted for one month, around September,
   through a special Commons upload link, like
   [this one][wlmir_2016_upload], which places entries under a
   particular category, like [this one][wlmir_2016_cat].
5. When submission period ends, the 100 to 100,000 entries are judged by
   a jury selected by the local coordinators, consisting of experts in
   photography, history, anthropology, and the local wiki community.
6. After several rounds of judging on
   [a variety of criteria][criteria], at least 10 winners are chosen
   from each local contest.
7. The top 10 winners from each locale, hundreds in total, advance to
   the international stage, where
   [a specially selected jury judges them][intl_jury] in
   several rounds.
8. The winners of the international stage are presented in a report,
   like [this one from 2016's contest][wlm_2016_report], to much joy,
   fanfare, and celebration.

Submissions and prizes may vary from year to year, but the contest
has always achieved its goals:

* Collecting invaluable, free-to-use heritage documentation on
  Wikipedia and elsewhere.
* Familiarizing a new set of creators with contributing to Wikimedia
  Commons.

It's no wonder that Wiki Loves Monuments' success has inspired many
other "Wiki Loves" competitions, for all sorts of subjects, including
[nature][wiki_loves_earth], [food][wiki_loves_food], and
[folk culture][wiki_loves_folk].

[jury_tools]: https://commons.wikimedia.org/wiki/Commons:Jury_tools#Montage
[wlmir_2016_cat]: https://commons.wikimedia.org/wiki/Category:Images_from_Wiki_Loves_Monuments_2016_in_Iran
[wlmir_2016_upload]: https://commons.wikimedia.org/w/index.php?title=Special:UploadWizard&campaign=wlm-ir&categories=WLM_IR_Triage%7CImages_from_Wiki_Loves_Monuments_2016%7CImages_from_Wiki_Loves_Monuments_2016_in_Iran
[criteria]: https://www.wikilovesmonuments.org/judging-criteria/
[usa_2016_process]: https://commons.wikimedia.org/wiki/Commons:Wiki_Loves_Monuments_2016_in_the_United_States/Judging
[list_import_infographic]: https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/The_secret_flow_of_Wiki_Loves_Monuments_infografic.svg/700px-The_secret_flow_of_Wiki_Loves_Monuments_infografic.svg.png
[intl_jury]: http://www.wikilovesmonuments.org/jury/
[wlm_2016_report]: https://commons.wikimedia.org/wiki/File:Wlm-jury-report-2016-lores.pdf
[wiki_loves_earth]: http://wikilovesearth.org/
[wiki_loves_food]: https://commons.wikimedia.org/wiki/Commons:Wiki_Loves_Food
[wiki_loves_folk]: https://wikilov.es/es/Wiki_Loves_Folk

# Design

Considering the unique processes of Wiki Loves Monuments, Montage had
to be designed specifically for photo contests hosted on Wikimedia
Commons. With development starting only a couple short weeks before
submissions began, Montage was in beta mode for 2016's Wiki Love
Monuments. So note that some features may not have been utilized by
all contests, and features may have changed since publishing this
post.

As with all good software, Montage puts its users first, so let's
start by taking a look at them.

## User roles

We took a hard look at the WLM process and determined that we had to
build functionality for the following groups of users:

* Maintainers: The developers of Montage itself, and key organizers
* Organizers: The central WLM organization team
* Local coordinators: The teams formed around each local competition
* Jurors: A judge chosen by organizers
* The general public: In all likelihood, you, dear reader

Note that a person can take on more than one role, especially across
rounds. For instance, Leila coordinated Wiki Loves Monuments Iran,
while also helping organize the international competition.

Except for the public parts of the site, all users log in with their
Wikimedia credentials.

The interactions between these users in a nutshell:

* Maintainers add international organizers
* International organizers can create campaigns and add local coordinators
* Local coordinators can create rounds and add jurors for those rounds
* Jurors can view and vote on images in rounds they've been added to
* The general public can see our beautiful login page

So far, Montage has seen logins from over 200 users from all
roles. Let's take a peek into what their overall workflow looks like.

## Workflow

Once a campaign has been created in Montage, organizers import any
number of entries into a first round of voting, then run successive
rounds, one at a time, to narrow down the field to just the set of
winning images.

Montage supports three voting styles:

* A simple yes-no
* A five-star rating
* A first-to-last ordered ranking

These three options offer organizers flexibility without much complication.

When a round's voting is complete, organizers select the rating
*threshold* to advance to the next round. Entries below the threshold
are eliminated. Examples of thresholds would be:

* Yes-no: At least 2 "yes" votes
* Five-star: Average rating of 3.5 stars or higher
* Ranking: Top 10

Organizers select the threshold value from a fixed set, so Montage
sidesteps complicated tiebreaking logic.

Montage also provides a [*quorum*][quorum_def] for yes-no and rating
rounds. For example, in a rating round with quorum set to 3, each
image must be rated by at least 3 randomly-selected jurors. This
lightens the load on individual jurors, while still ensuring each
image gets a fair appraisal.

The smallest WLM2016 campaign on Montage ran with 760 entries, two
rounds, and five jurors. Compare to the largest campaigns, which had
tens of thousands of entries, up to six rounds, and almost 50
jurors. We've taken feedback from these groups, and others, to ensure
Montage works for contests of any size.

[quorum_def]: https://en.wiktionary.org/wiki/quorum

## Technical details

Montage also packs some notable technological advantages.

First off, Montage [is hosted on][montage_beta] Wikimedia's community
server, [Tool Labs][tool_labs]. This supported environment makes
collaboration easier, while also providing critical features like
automatic database backups, direct access to database replicas for
faster imports, and HTTPS. The price is right, too!

As mentioned earlier, Montage also uses [Wikimedia's OAuth][oauth] for
authentication, meaning that user accounts are autocreated on first
login, as long as they're registered on Wikipedia, Commons, or some
other Wikimedia wiki. This means users don't need to remember another
password, and the Montage team doesn't need to worry about storing
sensitive user information. Votes, permissions, and other information
is still treated confidentially, of course.

Montage itself is built on Python, [Werkzeug][werkzeug_gh], and
[Clastic][clastic_gh], giving it an added measure of
maintainability. It has extensive logging throughout, using
Lithoxyl. On the frontend, [Angular.js][angular] provides a responsive
user experience with a familiar feel.

The code is free and open to contributions and issue reports
[on GitHub][montage_gh], of course.

[tool_labs]: https://tools.wmflabs.org/
[oauth]: https://www.mediawiki.org/wiki/Help:OAuth
[montage_beta]: http://tools.wmflabs.org/montage-beta/
[montage_gh]: https://github.com/hatnote/montage
[clastic_gh]: https://github.com/mahmoud/clastic
[werkzeug_gh]: https://github.com/pallets/werkzeug
[angular]: https://angularjs.org/

# New frontiers

Without a doubt, Montage was much more of a success than we had
anticipated. In the span of just a couple months, Montage has raised
the bar for software support, while lowering the barriers for future
coordination.

Right now we are putting together our feature list for the next
iteration of Montage. The priorities are far from final, but some
directions we are investigating include:

* Adding more public-facing features to the site
* Improving internationalization and localization
* Enhancing communication between organizers and jurors
* Supporting lower bandwidth connections
* Further customization of photo viewing, including light/dark themes and zooming
* And as always, increasing performance!

The list is long, and we're excited to tackle it for the 2017 Wiki
Loves contests! We hope you'll join us. If you're an engineer of any
sort, get in touch!

# Thanks

Many people contributed to Montage directly and indirectly. To name a few:

* [LilyOftheWest](https://phabricator.wikimedia.org/p/LilyOfTheWest/) - de facto product manager
* [Paweł Marynowski](https://twitter.com/pmarynowski) - UI designer and engineer
* [Mahmoud Hashemi](https://twitter.com/mhashemi) - Architecture and backend
* [Stephen LaPorte](https://twitter.com/sklaporte) - Backend and much more
* [Jean-Frédéric](https://twitter.com/JeanFred) - Design review
* [Lodewijk](https://twitter.com/effeietsanders) - Leadership and review
* [Yuvi Panda](https://twitter.com/yuvipanda) - Operations and support
* [Ori Livneh](https://github.com/atdt) - Operations and support
* [Kenneth Samonte](http://cargocollective.com/kensamonte) - Logo and illustration

And a huge thank you to all of the Montage users and Wiki Loves
Monuments organizers and jurors. We couldn't have done it without you!

We hope this peek behind the scenes of the contest has been
enlightening. For more details and updates, feel free to
[watch the repo on GitHub](http://github.com/hatnote/montage), follow
[Hatnote on Twitter](http://twitter.com/hatnotable), and of course,
watch/update/discuss via
[our Commons page](https://commons.wikimedia.org/wiki/Commons:Montage). We
look forward to hearing from you!
