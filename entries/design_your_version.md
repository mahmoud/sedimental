---
title: "Design Your Version: Semantics, Calendars, and Releases"
entry_id: design_your_version
---

<!-- or Choosing The Right Versioning System For Your Project -->
<!-- or What Your Project's Version Says About You -->

In these times of modern software development, a project can hardly be
called a project without a proper versioning scheme. From a technical
perspective, the lack of a version number is as negligent toward
clients and integrators as lack of source control is to collaborators,
and both prove equally punishing to oneself. Beyond technical reasons,
a project's version bears a huge impact on the perception of the
project. At every turn, this critical component will appear next to
the name of the project, closer and more often than the name of the
author and maintainers.

Given this magnitude, it's a wonder that versioning schemes seem to be
mostly afterthoughts and foregone conclusions. This guide seeks to
change that by introducing some options and direction for picking the
versioning scheme that is right for projects and their maintainers.

## Collective Expectations

I encounter and use far more software than I write, and I'm pretty
sure that holds true for all engineers. As a result, we accumulate
general expectations about version numbers.

1. **Versions increase with time** - Bigger is better, less would be worse.
2. **Versions speak to the quality of the software** - Whereas a good
   project name communicates an ideal, a good project version
   communicates the progress toward that ideal.
3. **Versions are trackable** - Continuity is a good thing. Irregular gaps
   can cause confusion.
4. **Versions are numeric, except when they're not** - Numeric versions are
   the default, but non-numeric versions and version components
   abound. Terms like "alpha" and "beta", as well as named project versions
   like those used in Linux distributions (Debian's "jessie" or Ubuntu's
   "trusty"), are well-understood in many circles.

<!-- TODO: case studies in all of the above? -->

Like them or not, there's no escaping these versioning tropes, and
while they may seem trivial or obvious, versions are fundamental
enough that the long-term effects can be profound. For instance, with
regard to #1, bigger versions are generally considered better,
especially within a project. However, there are cases where this
impact spilled out across projects.

For instance, when Google Chrome entered the browser race, it brought
with it a fast feature release schedule and a versioning system to
match. This versioning system had Chrome see a dozen major releases
while Firefox was still 3.x, making Firefox appear to be left in the
dust. Obviously Chrome was less mature and, as anyone who used it at
the time can attest, Chrome 4 wasn't half the browser Firefox 4 ended
up being. After a couple years of this onslaught, Firefox switched its
versioning system to match, and now, despite browsing for hours a day,
few users or even developers could tell you off the top of their heads
what version of Firefox/Chrome they use. Internet Explorer might be
another story.

## Semantic Versioning

Semantic Versioning, or SemVer, is the go-to versioning system for
most projects these days. A quick glance at the 40 most recent updates
on the Python Package Index (PyPI) show that all but six packages
appear to have the comfortable three-part versioning scheme. Among
those packages the highest minor version was 108 and the highest
micro version was all the way up to 595. For those unfamiliar with SemVer

First thing I have to check when I see a project version is when was
it last updated, when was it last released.

The problem with calling SemVer a "specification" is that unlike the
vast majority of successful RFC specifications, there is no validator
that can determine whether a project has correctly implemented
SemVer. If a project API breaks, but the major version is not
incremented, SemVer has been violated. More often than not the version
is not retroactively changed, and that's mostly just how project life
goes. Better to embrace the realities and treat SemVer as a detailed
recommendation rather than to argue over the polarizing MUSTs and MUST
NOTs of specification language.

## Challenges

### Encourages breakages

Everyone knows it's more exciting to announce 2.0 than 1.5.11, even if
there's more user demand for the latter than the former. This is
especially true with SemVer, which mandates that an upgrade to 2.0
indicates breaking API changes. Conversely, good software could be
assessed as inferior or less mature because its version number is
lower, even though it may have just done a particularly good job.

### Barrier to major releases

The inverse problem of the sort of the 2.0 breakage is the Zeno's
paradox 1.0. Conservative library authors may end up indefinitely
preferring the safety umbrella that a 0.x version entails. The ability
to break APIs. Whether humility or conservatism run amock, it largely
misrepresents the release state of many major libraries.

At the risk of oversimplifying:

* If both you (or your team) **and** a stranger (someone not
  directly advised) are both using a library in a production
  environment, the time for a major version has been reached.

If it's just you and yours, that's understandable; many great
scientists took great risks with themselves for the sake of
progress. If it's just a stranger going against your explicit advice,
then there's no accounting for such wildcards. But if both of groups
are using something effectively in production, then it's time to face
the facts. Tie up the loosest of ends and give it a major version.

## Calendar versioning

If you're an earnest engineer with honest intents of creating a
project for the long run, then calendar versioning may be for you.

* d3 could have been protovis 2.0, but instead both projects exist and
  everyone's the better for it
* Calendar versioning is actually quite commonplace when you look closely. Examples:
    * Twisted
    * Windows 95/98/2000
* If your project is being used in production by you AND someone you
  don't know, the time for a non-beta major release has already been reached.

### Advantages

SemVer is all relative, and one developer's 1.0 is another's
0.0.1alpha. As a library author, it's easy to write this off as others
being wrong. However, as an application developer who will be
depending on many libraries, one major advantage of calendar
versioning is being able to look at the dependency list and quick
ascertain which libraries are good candidates for updating.


## Summary

In the end a versioning scheme often isn't something that can be
chosen ready off the shelf. After spending days, weeks, and months on
a project architecture, it's worthwhile to spend a few minutes or
hours designing a versioning system that is tailored to the needs of
its users and author.

# PyPI recent 40

* Highest minor: 108
* Highest micro: 595
* Five 4-part versions
* One calendar version
