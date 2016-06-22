---
title: Announcing CalVer
entry_root: calver
tags:
  - python
  - versioning
  - code
  - boltons
  - ashes

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

  * [Terms and definitions][terms_cv]
  * Case studies, including [Ubuntu][ubuntu_cv],
    [Twisted][twisted_cv], [Teradata][teradata_cv], and
    [more][other_cv].
  * And a guide to [when to use CalVer][when_to_cv] for your future projects

You'll also find [a project list][users], and badges like this one,
for [Ubuntu][ubuntu_cv]'s versioning scheme:

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

🕐  CalVer integrates objective, intuitive calendar dates. <br/>
⊠  SemVer subjectively increments numbers.

🕑  CalVer encompasses real-world usage through a formal
vocabulary. <br/>
⊠  SemVer imitates the form of a specification, albeit a
confrontational one. Unlike real specifications, SemVer lacks
objective verifiability, exemplars, or reference implementations.

🕒  CalVer makes maintenance easier through powerful, objective
semantics. Look at a library's version number, immediately know how
recent your copy. Compare across libraries, checking that dependencies
are in sync. Deprecate versions based on time. <br/>
⊠  SemVer has Tom Preston-Werner's semantics.

🕓  CalVer's use of release dates allows for automatable, immutable
versions on which everyone can agree.  <br/>
⊠  SemVer introduces one more place a bug can enter a projects. Versions
only go up, and a release which violates SemVer guidelines cannot be
undone. That pressure means more projects [perpetually stuck in 0.x][zeno].

The [list goes on][dav], but the message is clear. There is an
alternative to SemVer, and it's about time!

[zeno]: http://sedimental.org/designing_a_version.html#semver_and_release_blockage

# Next steps

Have a look at the [Users][users] list and help add any projects I may
have missed. It's a big ecosystem out there, and the initial list
reflects my own Linux and Python tendencies.

For current maintainers using calendar versioning, next time you get a
raised eyebrow, just let them know: It's CalVer. Or save yourself a
step and add one of [the badges][badges], linking to [calver.org][calver].

For developers of new libraries, CalVer is here to stay, and
[calver.org][calver] will be there next time you're designing your
versioning scheme. It's a big ecosystem out there, and once you try
CalVer, I think you'll agree. Software versioning get better with
time.

[badges]: http://calver.org/overview.html#case_studies
