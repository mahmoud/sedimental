---
title: Announcing CalVer
entry_root: calver

---

*It's about time.*

Technologists expect things to get better with time. Your current
laptop has more RAM than the last, your current car is safer than its
predecessor, and the latest version of your application or library is
certainly the best ever.

What if the same be said of versioning systems?

Software versioning systems also get better with time. That's why
today I'm pleased to announce **CalVer**, a calendar versioning
convention based on project release dates, formally hosted on
**[calver.org][calver]**.

Calendar versioning represents a powerful alternative to Semantic
Versioning ([SemVer][semver]). CalVer can combine with or even replace
SemVer versioning systems, depending on the project.

# Features

The site speaks for itself, but there you'll find:

  * [Formal terms][terms_cv]
  * Case studies, including [Ubuntu][ubuntu_cv],
    [Twisted][twisted_cv], [Teradata][teradata_cv], and
    [more][other_cv].
  * A guide to [when to use CalVer][when_to_cv] for your future projects

You'll also find [a project list][users], and badges like this one,
representing the Ubuntu versioning scheme:

> <img src="https://img.shields.io/badge/calver-YY.0M.MICRO-22bfda.svg">

[calver]: http://calver.org
[semver]: http://semver.org

[terms_cv]: http://calver.org/#scheme
[ubuntu_cv]: http://calver.org/#ubuntu
[twisted_cv]: http://calver.org/#twisted
[teradata_cv]: http://calver.org/#teradata
[other_cv]: http://calver.org/#other_notable_projects

[when_to_cv]: http://calver.org/#when_to_use_calver

# Rationale

Many projects have [designed their version schemes][dav] to better
match the needs of their developers and customers. CalVer formalizes
those practices. [calver.org][calver] began as a resource to help
maintainers communicate the design choices in their versioning scheme.

CalVer has grown to showcase prominent uses and provide a way for more
projects to adopt calendar versioning in their projects. It even hosts
a community-curated [list of projects][users] using calendar versioning.

[dav]: /designing_a_version.html
[users]: http://calver.org/users.html

# Compared to SemVer

Some comparisons are inevitable. SemVer, hosted at
[semver.org][semver], is a big name in software versioning
conventions. CalVer combines well with incremental-number schemes, so
it's not strictly a competition. That said, here is how CalVer
outshines SemVer.

🕐  CalVer integrates objective, intuitive calendar dates, whereas SemVer
subjectively increments numbers.

🕑  CalVer encompasses real-world usage through a formal
vocabulary. SemVer imitates the form of a specification, but lacks
objective verifiability and other practical bases.

🕒  CalVer makes maintenance easier through powerful, objective semantics,
though not the ones Tom Preston-Werner wished for. When was the last
time you looked at a library's version number and knew whether or not
you were running a recent version? CalVer makes this easy, and enables
comparison across projects.

🕓  CalVer's reliance on release date allows for automatable, immutable
versions on which everyone can agree.  SemVer introduces one more
place a bug can enter a project. Versions only go up, and a release
which violates SemVer guidelines cannot be undone.

The [list goes on][dav], but the message is clear. There is an
alternative to SemVer, and it's about time!

# Next steps

Have a look at the Users list and help add any projects I may have
missed. It's a big ecosystem out there, and admittedly my knowledge is
biased toward Linux and Python.

For current maintainers using calendar versioning, next time you get a
raised eyebrow, just let them know: It's CalVer.

For developers of new libraries, CalVer is here to stay, and
calver.org will be there next time you're designing your versioning
scheme. It's a big ecosystem out there, and once you try CalVer, I
think you'll agree. Software versioning get better with time.
