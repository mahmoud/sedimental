---
title: "Design Your Version: Semantics, Calendars, and Releases"
entry_id: design_your_version
---

<!-- or Why Version Matters -->
<!-- or Choosing The Right Versioning System For Your Project -->
<!-- or What Your Project's Version Says About You -->
<!-- or Version Birth -->

In modern software development, a project isn't a project without a
proper versioning scheme. To maintain a project without a version is
as negligent toward clients and integrators as lack of source control
would be to collaborators. Beyond technical reasons, a project's
version bears a huge impact on the perception of the project. It
informs and entices potential users to adopt or upgrade. It appears
right beside the name of the project, closer and more often than the
name of the author and maintainers.

So why are so many projects' versioning schemes afterthoughts?
Indefinitely stuck at 0.0.1 and worse. What options and directions
do maintainers have for picking the versioning scheme that is right
for their projects?

# Collective Expectations

We encounter and use far more software than we write. In software's
short existence, so many versioning schemes have emerged that a
complete survey of conventions could fill a book. Saving the history
for another post, there are three primary expectations driving modern
software versioning:

1. **Versions go up** - The later the release, the greater the version.
2. **Versions speak to the quality of the software** - A project
   name communicates an ideal. The project version communicates
   progress toward that ideal. Bigger is better, less is worse.
3. **Versions are numeric, except when they're not** - Numeric
   versions are the default, but non-numeric versions and version
   components abound. Even non-developers understand suffixes like
   "alpha", "beta", "dev", "nightly", "stable", and so on. There are
   also named project versions, like those used in Linux
   distributions, such as Debian's "jessie" or Ubuntu's "trusty".

While they may seem trivial or obvious, versions are fundamental
enough that the large-scale, long-term effects can be profound. Higher
versions are considered better, especially within a project. But
there are cases where this impact spilled out across projects.

<!-- TODO: images -->

For instance, when Google Chrome entered the browser race, it brought
with it a fast feature release schedule and a versioning system to
match. This versioning system had Chrome see a dozen major releases
while Firefox was still 3.x, making Firefox appear to be left in the
dust. Obviously Chrome was less mature and, as anyone who used it at
the time can attest, Chrome 4 wasn't half the browser Firefox 4 ended
up being. After a couple years of this onslaught, Firefox switched its
versioning system to match. Now, despite browsing for hours a day, few
users or even developers could tell you off the top of their heads
what version of Firefox/Chrome they use. Internet Explorer is another
story.

<!--
TODO: move the story higher?

- http://lowendmac.com/musings/11mm/version-numbers.html
- http://www.pcworld.com/article/224842/why_firefox_rapid_release_schedule_is_a_bad_idea.html
- http://www.theverge.com/2012/7/9/3147445/mozilla-jono-dicarlo-rapid-releases-firefox
- https://www.google.com/search?channel=fs&q=firefox+rapid+release+chrome
- http://www.extremetech.com/internet/92792-mozilla-takes-firefox-version-number-removal-a-step-further
- https://bugzilla.mozilla.org/show_bug.cgi?id=678775
- https://support.mozilla.org/en-US/questions/896705
-->

# Semantic Versioning

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

# Calendar versioning

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


# Summary

In the end a versioning scheme often isn't something that can be
chosen ready off the shelf. After spending days, weeks, and months on
a project architecture, it's worthwhile to spend a few minutes or
hours designing a versioning system that is tailored to the needs of
its users and author.

<!--
# PyPI recent 40

* Highest minor: 108
* Highest micro: 595
* Five 4-part versions
* One calendar version
-->
