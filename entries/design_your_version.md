---
title: "Design Your Version: Semantics, Calendars, and Releases"
entry_root: design_your_version

---

<!-- or Why Version Matters -->
<!-- or Choosing The Right Versioning System For Your Project -->
<!-- or What Your Project's Version Says About You -->
<!-- or Version Birth -->
<!-- tagline: your 6-minute guide to semantics, calendars, and releases. -->

In modern software development, a project isn't a project without a
proper versioning scheme.

Lack of a project version neglects clients like lack of source control
neglects collaborators. Dependency management and migration rely on
versions. Beyond the technical, a project's version bears a huge
impact on the perception of the project. It informs adoption and
entices users to upgrade. The version is attached to the name of the
project — appearing closer and more often than the names of the
maintainers.

So why are so many projects' versioning schemes afterthoughts?
Indefinitely stuck at 0.0.x or worse. What do clients expect and what
do projects need?

[TOC]

# Semantic Versioning

Currently, The go-to versioning system for open-source software is
referred to as Semantic Versioning, or [SemVer][semverorg].

Take a quick look at the
[40 most recent updates on the Python Package Index][pypi40]
([PyPI][pypi]). My glance showed all but *six* packages with the
comfortable three-part versioning scheme: `major.minor.micro`. Among
those packages the highest minor version was 108. The highest micro
version was all the way up to 595.

<!--
# PyPI recent 40

* Highest minor: 108
* Highest micro: 595
* Five 4-part versions
* One calendar version
-->

[semverorg]: http://semver.org/
[pypi40]: https://pypi.python.org/pypi?%3Aaction=rss
[pypi]: https://pypi.python.org/pypi

So, if it's so popular, SemVer must be easy, right? Follow
[a couple straightforward steps][semver_process]. Pick a number, add
one to it. With arithmetic that simple, what could go wrong?

[semver_process]: http://semver.org/#semantic-versioning-specification-semver

### SemVer and code breakage

Everyone knows it's more exciting to announce 2.0 than 1.6.11, even if
there's more user demand for the latter than the former. This is
especially true with SemVer, which implies that a major version change
should break the API.

As we will see, people make assumptions about quality based on version
number. SemVer supports opaque apples-and-oranges comparison,
punishing libraries that get it right on the first try, and
encouraging libraries to break APIs to appear active.

### SemVer and release blockage

More damaging than the fatuous 2.0 is **[Zeno's][zeno_paradox]
1.0**. We have an epidemic.

Conservative library authors end up indefinitely preferring the
*semantic power* of 0.x: [The ability to break APIs][0.x]. Whether the
cause is conservatism, humility, or misunderstanding, the effect is
misrepresenting the release state of many major libraries.

To quote the [second answer in SemVer's own FAQ][when10]:

> If your software is being used in production, it should probably
> already be 1.0.0. If you have a stable API on which users have come
> to depend, you should be 1.0.0. If you’re worrying a lot about
> backwards compatibility, you should probably already be 1.0.0.

On this count, SemVer is found not guilty[^2]. It's the SemVer users
that didn't get the memo -- myself included, until I started writing
this. Maybe if it had been in the spec instead of the FAQ.

Still, the "public API" emphasis is a heavy one. A more practical
scheme might have helped represent accurate versions for mature,
production libraries like Cython (0.23) and SciPy (0.17), both of
which have books and nearly a decade of releases still available on PyPI.

[zeno_paradox]: https://en.wikipedia.org/wiki/Zeno's_paradoxes#Dichotomy_paradox
[0.x]: http://semver.org/#spec-item-4
[when10]: http://semver.org/#how-do-i-know-when-to-release-100

### SemVer and certifiability

Appealing to engineering aesthetics, SemVer is presented as a
"specification". But, unlike the vast majority of successful
[RFCs][rfc], there is no validation or certification that can
determine whether a project has correctly implemented SemVer. If a
project API breaks, but the major version is not incremented, the
SemVer specification has been violated. But there's no way to test
that generally, and no one does it specifically.

SemVer is a detailed suggestion. Software breaks as quickly as
SemVer's promise. The [remediations][semver_rerelease] do *not*
happen. Better to embrace the realities of versioning, rather than
argue over the MUSTs and MUST NOTs of an unenforceable specification.

[rfc]: https://en.wikipedia.org/wiki/Request_for_Comments
[semver_rerelease]: http://semver.org/#what-do-i-do-if-i-accidentally-release-a-backwards-incompatible-change-as-a-minor-version

# Collective Expectations

Let's take a brief moment to reconsider the humble version.

We encounter and use far more software than we write. Few, if any,
know and expect compliance with all the suggestions in SemVer.  So
what do we expect from our versions?

There are three main expectations driving modern software versioning:

## #1 Versions go up

The later the release, the greater the version. Sofware should not
change without a version change, and the version must go up.

## #2 Versions correlate to software quality

A project name communicates an ideal. The project version communicates
progress toward that ideal. The greater the version, the greater the
software.

## #3 Versions are numeric, except when they're not

Here's where things get hairy. Numeric versions are the default, but
non-numeric versions and version components abound.

Version vernacular is now thoroughly mainstream: "alpha", "beta",
"dev", "nightly", "stable", and so on. There are also named project
versions, like those used in Linux distributions, such as Debian's
"jessie", Ubuntu's "trusty", and Windows' "longhorn".

# Case Study: Chrome vs. Firefox

We take our version expectations for granted, but something this
fundamental has profound effects at scale. Higher versions are
considered better, especially within a project. But there's at least
one case where this impact visibly spilled out across projects.

When Google Chrome entered the browser race, it brought with it a fast
feature release schedule and a versioning system to match. This
versioning system had Chrome see a dozen major releases while Firefox
was still 3.x, making Firefox appear to be left in the dust. Obviously
Chrome was less mature and, as anyone who used it at the time can
attest, Chrome 4 wasn't half the browser Firefox 4 ended up
being.

After a couple years of [this onslaught][ff_verbloat], Firefox switched its
versioning system to match. Now, despite browsing for hours a day, few
users or even developers [could tell you][ff_rmver] off the top of their heads
what version of Firefox/Chrome they use.[^3]

SemVer ignored this huge precedent,
[harshly judging fast-moving projects][semver_speed]. Let's call that
our last straw and look at an alternative.

[semver_speed]: http://semver.org/#if-even-the-tiniest-backwards-incompatible-changes-to-the-public-api-require-a-major-version-bump-wont-i-end-up-at-version-4200-very-rapidly
[ff_verbloat]: http://lowendmac.com/musings/11mm/version-numbers.html
[ff_rmver]: http://www.extremetech.com/internet/92792-mozilla-takes-firefox-version-number-removal-a-step-further

# Calendar Versioning

If you're an earnest engineer with honest intents of creating,
releasing, and maintaining a project, then calendar versioning may be
for you. It fulfills all of the expectations delineated above, so what
advantages does it bring?

* Calendar versioning is actually quite commonplace when you look closely. Examples:
    * Twisted
    * Windows 95/98/2000

<!-- Yes, planned obsolescence is a corporate plague upon
consumers. But it can be a great tool for software creators. The same
principle applies: The version is for today, and the brand is
forever. -->

## CalVer leverages natural understanding

People are calendar-oriented. Practically, it's just easier to
remember that a library was causing a live issue back in 2013 than it
is to remember that up until version 1.6.18 that library had a lot of
bugs.

Furthermore, in long-term development, releases pile up and
increasingly large major versions blur together. Browser versions have
been rendered meaningless. But the calendar is one construct where
numbers increase and cycle regularly. Leveraging that natural
understanding anchors otherwise arbitrary versions.

## CalVer has better semantics

Ironic, I know.

SemVer is all relative, and one developer's 1.0 is another's
0.0.1alpha. As authors, we try to ignore this and write others off as
wrong. However, as an application developer who will be depending on
many libraries, one major advantage of calendar versioning is being
able to look at the dependency list and quick ascertain which
libraries are good candidates for updating.

Besides, one of the first steps in evaluating a new library is the
most recent release date. CalVer puts us in the ballpark right away.

Many might not realize it, but the oh-so ubiquitous Ubuntu is in fact
calendar versioned. For example, version 15.04 came out in April, 2015.
It gets better when you remember Long-Term Support. Ubuntu's
LTS is 5 years. So, 14 + 5, Ubuntu 14.04 LTS end of life will be in 2019.
You don't have to look anything up. It's all right there in the CalVer
semantics.

## CalVer protects projects

If you care about the future of the project, then guard it against one
of the worst fates: the fatuous 2.0. Give your project a
future. Guard against the learned expectation of 2.0 or death.

SemVer is set up so that every major release needs to include more
changes than the last. If the project is founded on and aiming for
correctness, the opposite should be true. With CalVer, you are safe to
add as much or as little functionality as needed.

# Summary

Consider adding a calendar component to your next library's versioning
schemes. As for my opinion, I've joined other maintainers in doing so
for boltons and ashes. I've found it makes a lot of sense for
libraries, and a little less sense for protocols and services.[^4]

Either way, think about project versions. After spending days, weeks,
and months on a project, it's worthwhile to spend a few minutes or
hours designing a versioning system that is tailored to the needs of
project users and maintainers.

<!--
If you don't have time to think about the version of the library
you are writing or including, then maybe you shouldn't be writing
including it.
-->

<!-- ============== !-->

[^1]: Astute readers will note that it's Semantic Versioning 2.0.0.
      *"Oh, cute, Tom used his own scheme for the document."* But did you
      wonder what public API changed to trigger that major version bump?
      SemVer's public API has been semver.org **[since before 1.0][semver_wayback]**.
      How about those semantics?

[^2]: I've actually been saying something similar, but more practical, for a long time:

      > If both you (or your team) **and** a stranger (someone not
      > directly advised) are both using a library in a production
      > environment, the time for a major version has come.

      If it's just you and yours, that's understandable; many great
      scientists took great risks with themselves for the sake of
      progress. If it's just a stranger going against your explicit
      advice, then there's no accounting for such wildcards. But if
      both of groups are using something in production, then it's time
      to face the facts. Tie up the loosest of ends and give it a
      major version.

[^3]: Here are some more resources for those interested in the
      Firefox release switch up:

      - [Support forum discussion on FF major releases](https://support.mozilla.org/en-US/questions/896705)
      - [Firefox Rapid Release Criticized](http://www.pcworld.com/article/224842/why_firefox_rapid_release_schedule_is_a_bad_idea.html)
      - [Former Mozilla dev Jono DiCarlo on Firefox Rapid Release](http://www.theverge.com/2012/7/9/3147445/mozilla-jono-dicarlo-rapid-releases-firefox)
      - [The Bugzilla bug for hiding the version number](https://bugzilla.mozilla.org/show_bug.cgi?id=678775)

      Versions matter. They're part of your project's identity. Design
      them to help your user.

[^4]: To illustrate, if I could have it my way, we'd have OpenSSL
      16.x.x. That way I can easily complain if I find someone using
      10.x.x in production. That said, TLS/1.3 seems better than
      TLS/16.0.

      My current thought is that protocols live outside of time,
      because I believe it's possible to complete a protocol, but an
      implementation is never done.


[semver_wayback]: https://web.archive.org/web/20111207065319/http://semver.org/
