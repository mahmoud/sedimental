---
title: "Maintainerati 2017: GitHub Design"
publish_date: 10:00pm October 17, 2017
tags:
  - code
  - python
  - events
---

Last week I attended a [Maintainerati][maintainerati] event, an
unconference/mini-summit for maintainers of popular software, run as a
prelude to the [GitHub Universe][gh_universe] conference. After being
taught the secret handshake of the software elite among other rituals,
I had a great time in the documentation breakout group, as well as
moderating a lively discussion on diversity in open-source, both of
which deserve their own write-ups at some point.

<img title="One of about a dozen minitalks summarizing one of the
breakout groups' discussions." width="100%"
src="/uploads/maintainerati_2017_summaries.jpg">

Once those were through and coffee breaks were had, what I consider
the main event was upon us: An opportunity to discuss with GitHub
designers and developers all the different ways projects use
[GitHub][gh_wp], and how GitHub might improve to match those use
cases. I think these interactions have the most direct potential to
bear fruit, so in my excitement I wrote a bunch of the proceedings
down:

[maintainerati]: https://twitter.com/maintainerati
[gh_universe]: https://githubuniverse.com/
[gh_wp]: https://en.wikipedia.org/wiki/GitHub

[TOC]

# Digested emails

Discussion is one of the greatest things about GitHub, but as Jupyter
developer [Ian Rose][ian_rose] brought up, an email for every comment
can be overwhelming. Daily or weekly digests for issues, or even for
all your GitHub activity would be a huge improvement, especially for
more lightweight users of GitHub. This may not strike subscribers of
[The Weeklypedia][weeklypedia] as a surprise, but I am a big fan of
email digests.

More control over engagement levels could open a great new avenue for
driving traffic for GitHub, too.

[ian_rose]: https://github.com/ian-r-rose
[weeklypedia]: http://weekly.hatnote.com/

## Star spectrum

Right now you can either [star][star] repos or [watch][watch] them, effectively getting
no notifications or *all* of them.

[star]: https://help.github.com/articles/about-stars/
[watch]: https://help.github.com/articles/watching-and-unwatching-repositories/

I'd estimate about a third of the repos I star look interesting, but
haven't yet reached the point where I'd use or contribute to them. So
they mostly get starred and forgotten.

<a href="https://starminder.xyz"><img title="A screenshot of the
simple but useful Starminder" align=right width="40%"
src="/uploads/starminder_20171017.png"></a>

A friend of mine started a little project called
[*Starminder*][starminder], which emails a nightly selection of five
of my starred repos. I've been having a grand time revisiting these
old stars and seeing how far they've come, even reminding me of
features I was waiting to build.

[starminder]: https://starminder.xyz/

And while I love [Nik's work][nik_gh], instead of relying on
Starminder, it would be way better if I could tell GitHub roughly how
often I'd like updates on a project, and then get [Pulse-like info][twisted_pulse]
delivered to my inbox on a weekly or monthly basis.

[nik_gh]: https://github.com/nkantar
[twisted_pulse]: https://github.com/twisted/twisted/pulse/monthly

Commit activity, high-traffic issues, and especially new tags/releases
are all things I'd be very excited to get personalized, periodic
updates on, without having to get every single notification as a
separate email.

One off-the-cuff idea I had was to establish some sort of star
gradient, with the basic star without notifications being an option on
one end of the opt-in engagement spectrum, and full-blown,
every-notification "Watching" on the other. Could there be one Star
dropdown to rule them all?

# Code review permissions

Requiring code review before merging is a pretty smart idea for any
rigorous project, and [now GitHub supports it natively][reqd_code_review].
However, only developers with write permissions can actually perform a
code review. Here are some real-life use cases that demonstrate why this
is less than ideal:

* A senior developer not involved with the project files an issue
  requesting a feature. I would like them to review the implementation
  to ensure it does what they want. The senior developer has a busy
  schedule and doesn't want to join the project and get a bunch of
  notifications, but would be qualified to review the code.
* A novice developer finds an problem in the documentation, they could
  review the new documentation for clarity. Their lack of experience
  makes them best qualified to review.
* The core maintainer implements a feature, but is actually the only
  developer on the project. Requesting a code review from
  non-project-member peers is a great way to get them to look at the
  code and become more involved with the project going forward.

For bonus points all permissions could have an option to be
time-limited. Designated reviewr and expiration possibilities
notwithstanding, I think the best flow would include the ability to
add someone to a specific PR as reviewer, without giving them any
project-wide permissions.

[reqd_code_review]: https://help.github.com/articles/enabling-required-reviews-for-pull-requests/

# Dashboard improvements

I'm probably weird for doing this, but I habitually visit the normal
[github.com][gh] logged-in landing page, aka the dashboard, several times a
day. Now, for the few of you who share my habit probably noticed,
there's a new Discover tab, offering personalized
suggestions of repos to star.

[gh]: https://github.com/

The event stream stayed mostly the same, however, as it has for many
years. But despite its maturity there are a couple events that
surprisingly don't show up anywhere, even when the dashboard seems
like a natural fit:

* **Follows** - I have the better part of a thousand followers, but I can't remember
  if I've ever seen a notification about this. [They seem like nice folks!][mh_followers]
* **Stars on org-owned repos** - [There][attrs] [are][montage]
  [several][hyperlink] [repos][pyjks] I maintain and watch, but for
  which I've never seen on-dash notifications. What do they all have
  in common? They're all owned by organizations (e.g.,
  [python-hyper][hyper]). Other types of
  notifications show up, but not stars.
* **Watches** - Not sure I've ever gotten a notification for someone
  watching one of my repos, even though they're probably more
  interested in collaboration than the average stargazer.

[mh_followers]: https://github.com/mahmoud?tab=followers
[hyperlink]: https://github.com/python-hyper/hyperlink
[montage]: https://github.com/hatnote/montage
[pyjks]: https://github.com/kurtbrose/pyjks
[attrs]: https://github.com/python-attrs/attrs
[hyper]: http://github.com/python-hyper

Any or all of these would certainly make my [github.com][gh] itch
yield more interesting results, and I'm sure there are some
enhancements I've missed, too!

# Thanks!

Just wanted to say thanks to GitHub for putting together such a great
event. Whether or not any of these features materializes in the near
future, it was so nice to meet up with old friends and make some new
ones, too.

Focused, cross-technology encounters like these are all too rare. For
my Python readers, let this serve as a reminder to get out and
interact with other stacks. Python's strength is its integrative
nature, and I think that can be a strength for us Pythonists as well.

In any case, thanks for the event, GitHub! Hope to see you again next
year!
