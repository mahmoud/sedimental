---
title: Introducing Montage
---

If I told you that the world's largest photography competition, Wiki
Loves Monuments, has run every year since 2010, gathering over a
million submissions, with little to no standard process, I don't think
your surprise could have matched mine. New year, new people, new
processes.

Worse yet, these processes were getting byzantine, discouraging
would-be organizers, and hurting overall participation. Less
participation means fewer photos, and nobody wants a less media-rich
Wikipedia.

<!-- TODO: nepal story -->

But how do you prescribe a standard process without standard tools?
And how do you build standard tools without a standard process?
Besides, who has time for either, when everyone is so busy running the
world's largest photography competition?!

This year, the international team of Wiki Loves Monuments organizers
set out to quash this chicken-and-egg problem, with a little help from
[Hatnote][hatnote].

Today, we're happy to present Montage, the web platform used to judge
Wiki Loves Monuments 2016.

[hatnote]: http://hatnote.com

# Overview

We started by looking at all the independent processes and tools used
over the years. Gradually, a new, streamlined design emerged, one
which would enable a standard recommended process for future
participants. Before long, we were on our way to making it easier than
ever to organize a photography contest on Wikimedia Commons, and
including communities who could not participate regularly.

For those unfamiliar with the Wiki Loves Monuments competition, here
is a handy executive summary:

* Countries have one or more official lists of national or regional
  heritage sites.
* Local contest coordinators self-organize on their language-specific
  wiki, uploading the monument registry if need be, then contacting
  the international team to indicate their country's participation.
* These coordinators advertise the contest on their wiki, social
  media, and all other means.
* Contest submissions are accepted for one month, around October,
  through uploading to Commons under a particular category (e.g., Wiki
  Loves Monuments in Iran 2016)
* Each country receives somewhere between 100 and 100,000 images,
  which are judged by a jury selected by the local coordinators,
  consisting of experts in photography, history, anthropology, and the
  local wiki community needs.
* After several rounds of judging, at least 10 winners are chosen from
  each local contest.
* All local winners, hundreds in total, advance to the international
  stage, where another jury judges them in several rounds.
* The winners of the international stage are presented in a report, to
  much joy, fanfare, and celebration.

Submissions and prizes may vary from year to year, but the contest
has always achieved its goals:

* Collecting invaluable, free-to-use heritage documentation on
  Wikipedia and elsewhere.
* Familiarizing a new set of creators with contributing to Wikimedia
  Commons.

It's no wonder that Wiki Loves Monuments' success has inspired many
other "Wiki Loves" competitions, for all sorts of subjects, including
nature, food, and folk culture.

# Design

Considering the unique processes of Wiki Loves Monuments, Montage had
to be designed specifically for photo contests hosted on Wikimedia
Commons. With development starting only a couple short weeks before
submissions began, Montage was in beta mode for 2016's Wiki Love
Monuments. Some features may not have been utilized by all contests,
and features may have changed since publishing this post.

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

Montage also provides a *quorum* for yes-no and rating rounds. For
example, in a rating round with quorum set to 3, each image must be
rated by at least 3 randomly-selected jurors. This lightens the load
on individual jurors, while still ensuring each image gets a fair
appraisal.

To serve the wide range of contest sizes, we made it a key feature of
Montage to support an arbitrary numbers of rounds and jurors. Larger
campaigns tend to need more rounds and jurors to spread out the
workload. The smallest WLM2016 campaign on Montage ran with xxx
entries, yyy rounds, and zzz jurors. Compare to the largest, which had
XXX entries, YYY rounds, and ZZZ jurors. We've taken feedback from
these groups, and others, to ensure Montage works for contests of any
size.

## Technical details

Montage also packs some notable technological advantages.

First off, Montage is hosted on Wikimedia's community server, Tool
Labs. This supported environment makes collaboration easier, while
also providing critical features like automatic database backups,
direct access to database replicas for faster imports, and HTTPS. The
price is right, too!

As mentioned earlier, Montage also uses Wikimedia's OAuth for
authentication, meaning that user accounts are autocreated on first
login, as long as they're registered on Wikipedia, Commons, or some
other Wikimedia wiki. This means users don't need to remember another
password, and the Montage team doesn't need to worry about storing
sensitive user information. Votes, permissions, and other information
is still treated confidentially, of course.

Montage itself is built on Python, Clastic, and Werkzeug, giving it an
added measure of maintainability. It has extensive logging throughout,
using Lithoxyl. On the frontend, Angular.js provides a responsive user
experience with a familiar feel.

# New frontiers

Without a doubt, Montage was much more of a success than we had
anticipated. In the span of just a couple months Montage has raised
the bar for software support, while lowering the barrier to entry for
coordination.

Right now we are putting together our feature list for the next
iteration of Montage. The priorities are far from final, but some
directions we are investigating include:

* Adding more public-facing features to the site
* Improving internationalization and localization
* Enhancing communication between organizers and jurors
* Supporting lower bandwidth connections
* Further customizing the photo viewing feature <!-- e.g., zoom, etc. for increased scrutiny -->
* And as always, more performance!

The list is long, and we're excited to tackle it for the 2017 Wiki
Loves contests! We hope you'll join us. If you're an engineer of any
sort, get in touch!

# Team

Many people contributed to Montage directly and indirectly. To name a few:

* Leila - de facto product manager
* Pawel - Front-end
* Stephen - Backend
* Mahmoud - Design/backend
* Jean Fred - Design review
* Lodewijk - Leadership
* Yuvi - Operations and support
* Ori Livneh - Operations and support
* Kenneth Samonte - Logo and graphics

# TODO

* Link to project page
* Link to status page
* Link to GitHub
* Link to other tools
* Embed art
