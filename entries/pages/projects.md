---
title: Open-Source Projects
field_label_map:
  est_date: Established
  gh_link: View on GitHub
  pypi_link: View on PyPI
field_type_map:
  gh_link: link
  pypi_link: link
field_role_map:
  content: description

---

I've had a lot of ideas over the years. Lucky as I am to be a
programmer, I've been able to realize many of them in the form of
open-source projects. Looking back, I'm pleased with the conversion
ratio, but I remain convinced the best is yet to come.

In the meantime, here is a summary and status for each of my current
projects, roughly ordered by some combination of popularity, age, and
personal utility. You could get a majority of this information from
[my GitHub repositories page][gh_repos]. Also included here are
details about the background and current state of each project.

Don't mind the odd names; you don't need to be a geologist to
appreciate all this free software!

[gh_repos]: https://github.com/mahmoud?tab=repositories
<!-- TODO: relevant links for each -->

[TOC]

---
title: Boltons
est_date: February 19, 2013
release_status: Released
gh_link: https://github.com/mahmoud/boltons
pypi_link: https://pypi.python.org/pypi/boltons
description: |

  Boltons is an expansive collection of 160+ Python types and
  functions I've badly missed from the Python standard library. It is
  also my most popular project, and certainly the most mature in terms
  of being [documented][boltons_docs], tested, and officially released.

  I actively maintain Boltons and encourage you to take a look at the
  [README][boltons_readme] and [CHANGELOG][boltons_changelog] and
  [let me know][boltons_issues] if you have any questions or feature
  requests.

  [boltons_docs]: http://boltons.readthedocs.org/en/latest/
  [boltons_readme]: https://github.com/mahmoud/boltons#boltons
  [boltons_changelog]: https://github.com/mahmoud/boltons/blob/master/CHANGELOG.md
  [boltons_issues]: https://github.com/mahmoud/boltons/issues/

---
title: Ashes
est_date: January 11, 2013
release_status: Soft release, pending documentation
gh_link: https://github.com/mahmoud/ashes
pypi_link: https://pypi.python.org/pypi/ashes
description: |

  Ashes is a small and scrutable HTML templating library with a
  practical, language-agnostic featureset. Ashes achieves this by
  implementing virtually all of [the Dust templating language][dustjs]
  in a single, easily-embeddable Python file. It is tested on Python 2
  and 3 and used in production by countless projects, including
  [Clastic](#clastic). Documentation is [underway][ashes_docs], and I
  usually refer people to
  [the documentation of the complementary frontend implementation][dustjs_docs].

  [dustjs]: http://www.dustjs.com/
  [ashes_docs]: http://ashes.readthedocs.org/en/latest/
  [dustjs_docs]: http://akdubya.github.io/dustjs/
---
title: Clastic
est_date: November 8, 2012
release_status: Soft release, pending branding
gh_link: https://github.com/mahmoud/clastic
pypi_link: https://pypi.python.org/pypi/clastic
description: |

  Clastic is a web site and service microframework built for high
  development productivity and low runtime overhead. By eschewing
  global state, Clastic is easy to reason about and run with all
  concurrency models. It also uses [Werkzeug][werkzeug]'s web
  primitives, so it's well-documented and widely understood.

  I created Clastic in response to
  [several shortcomings][django_probs] I encountered with Django and
  Flask. I used it to build [ETAVTA](#etavta) and some
  [Hatnote projects][hatnote_projects], and gradually developers at
  PayPal started using it, too. Billions of requests later it
  continues to fulfill its primary goals without issue and unlike any
  other service framework. There are still several TODO items, but
  seeing as it works so well, development is occasional, at least
  until I get the time to write up a public release announcement.

  [werkzeug]: http://werkzeug.pocoo.org/docs/
  [django_probs]: https://github.com/mahmoud/clastic#compared-to-django
  [hatnote_projects]: http://hatnote.com
  <!-- TODO hatnote project page -->

---
title: SuPPort
est_date: August 20, 2012
gh_link: https://github.com/paypal/support
pypi_link: https://pypi.python.org/pypi/support
announce_link: https://www.paypal-engineering.com/2015/03/17/introducing-support/
release_status: Released
description: |

  SuPPort is PayPal's Python infrastructure minus all the
  PayPalisms. I founded PayPal's Python team in 2011 and
  [open-sourced SuPPort in 2015][announce]. Over those 4 years,
  SuPPort's architecture evolved to achieve six nines reliability
  while serving billions of production-critical PayPal requests.

  SuPPort's enterprise elements may make it heavyweight for many
  projects, but I still refer to and recommend it as a rich resource
  of codified networking and robustness knowledge. It combines and
  builds on several of the other projects listed on this page.

  [announce]: https://www.paypal-engineering.com/2015/03/17/introducing-support/

---
title: Lithoxyl
est_date: June 18, 2013
release_status: Active development
gh_link: https://github.com/mahmoud/lithoxyl
pypi_link: https://pypi.python.org/pypi/lithoxyl
description: |

  Lithoxyl is a full-featured instrumentation framework encompassing
  structured logging and statistical profiling.

  Too often application instrumentation is forgotten completely or
  relegated to the afterthought of adding a few hasty logging
  statements. Lithoxyl aims to fix that by being lightweight and
  useful from the first stages of development through to deployment.

  Lithoxyl started after discovering major inefficiencies in Python's
  built-in [logging module][logging], a hasty port of
  [Java's Log4J][log4j]. Rather than engineering a better
  implementation of an outdated design, Lithoxyl is an inherently more
  powerful system that is lower-overhead and higher-performance by
  nature.

  Lithoxyl is used by several of my projects and
  [documentation is underway][lithoxyl_docs].

  [logging]: https://docs.python.org/2/library/logging.html
  [log4j]: http://logging.apache.org/log4j/2.x/
  [lithoxyl_docs]: http://lithoxyl.readthedocs.org/en/latest/

---
title: Chert
est_date: October 19, 2014
release_status: Active development
gh_link: https://github.com/mahmoud/chert
pypi_link: https://pypi.python.org/pypi/chert
description: |

  Chert is the static site generation system designed to fit the
  workflow of modern digital written media. In addition to the
  standard Markdown/YAML syntax and RSS/Atom feeds, Chert supports
  automatic table of contents generation and structured list entry
  formats. Eat your heart out, Buzzfeed.

  Unlike most othe projects on this page, I did not intend Chert to be
  particularly innovative or generally useful. That said, a lot of
  people showed interest, maybe it was [the colophon][colophon]?

  [colophon]: http://lithoxyl.readthedocs.org/en/latest/

---
title: Strata
est_date: June 21, 2013
release_status: On hiatus
gh_link: https://github.com/mahmoud/strata
pypi_link: https://pypi.python.org/pypi/strata
description: |

  Strata is a holistic configuration framework. Strata came into
  existence to fill the need of complex applications that accept
  inputs from a variety of sources and need to resolve that into a
  consistent, predictable configuration. For example, even basic
  applications read: command line arguments, configuration file, and
  environment variables. On top of that, there's almost always a
  default value for a particular field.

  Strata solves this with "layers", each one providing variables from
  that domain. This way precedence is always clear. For instance, a
  developer can decide that command line arguments always override
  configuration file values, and when neither exists, there is a
  fallback default value. Once Strata performs the configuration load
  procedure, the resulting configuration object keeps track of which
  values came from where.

  I'm still very much in love with the idea of Strata and would love
  to pick up work on it again. If you'd like to participate, please
  get in touch, otherwise it will have to wait for some other projects
  to process through the queue.

---
title: Cronfed
est_date: August 20, 2014
gh_link: https://github.com/hatnote/cronfed
pypi_link: https://pypi.python.org/pypi/cronfed
release_status: Released
description: |

  Cronfed is a tool for monitoring basic batch jobs, or any other
  cron-based scheduled commands. It achieves this by parsing a given
  mailbox and turning it into an RSS feed, which can then be monitored
  with your browser, feedreader or other RSS-compatible service (such
  as [IFTTT](https://ifttt.com)).

  I [use it literally every day][cronfed_announce] to monitor my
  Hatnote projects. Special thanks to Mark Williams for all his help
  on this.

  [cronfed_announce]: http://blog.hatnote.com/post/114130038643/cronfed-minimum-viable-monitoring

---
title: ETAVTA
est_date: November 8, 2012
release_status: Soft release, pending announcement
gh_link: https://github.com/mahmoud/etavta
description: |

  [ETAVTA](http://etavta.com/) is my answer to the Valley Transit
  Authority's ([VTA][vta]) complicated light rail schedule and Google
  Maps' inaccurate estimates. It computes a full weeklong schedule for
  all trains and tells you the next five trains going north and south
  at any of the 62 VTA stations. It's pretty simple, and serves as the
  earliest example of how to use [Clastic](#clastic).

  [vta]: https://en.wikipedia.org/wiki/VTA_light-rail

---
title: Hematite
est_date: May 19, 2013
gh_link: https://github.com/mahmoud/hematite
pypi_link: https://pypi.python.org/pypi/hematite
release_status: On hiatus
description: |

  Hematite is a set of HTTP primitives for server and client use. It's
  tough creating a symmetrical abstraction that is practical, so while
  I use it in some projects, it's not production-ready yet.

---
title: Tectonic
est_date: February 21, 2014
gh_link: https://github.com/mahmoud/tectonic
pypi_link: https://pypi.python.org/pypi/tectonic
release_status: On hiatus
description: |

  Tectonic is a process management and IPC framework built on nothing
  but pure Python, pure POSIX, and pure potential. It's in very early
  phases, pending work queue clearance.

---
title: Picritic
est_date: May 16, 2015
gh_link: https://github.com/mahmoud/picritic
pypi_link: https://pypi.python.org/pypi/picritic
release_status: Pending further development
description: |

  Developed for research into the Python software community, Picritic
  scans the Python Package Index (PyPI) and computes statistics
  ostensibly used to scrutinize package quality. Hence, Picritic is a
  **P**ackage **I**ndex **Critic**.

---
title: PythonDoesBlog
gh_link: https://github.com/mahmoud/PythonDoesBlog
est_date: January 14, 2012
release_status: Retired
description: |

  Originally created as platform for [Python Does What?!][pdw] (PDW),
  PythonDoesBlog is a one-of-a-kind blogging engine, specifically for
  blogs about Python.

  Posts are [written as Python modules][example]. Text is
  [ReStructuredText][rst] in [docstrings][docstring], and the
  remainder of the code is highlighted. There was also special
  docstring handling to make sure that the module executed as expected
  before publishing.

  PythonDoesBlog still works, and its partial results are still
  visible at [pythondoeswhat.com](http://pythondoeswhat.com), but as
  the PDW topics became more complex, we were writing cases that would
  crash the interpreter and do other bad things that PythonDoesBlog
  could never support.

  I still enjoy scoffing at Python static site generators (including
  [this one](#chert)), "Oh, your blog post is rendered with Python?
  That's cool. My blog posts **are** Python."

  [pdw]: http://pythondoeswhat.blogspot.com/
  [rst]: http://docutils.sourceforge.net/rst.html
  [docstring]: https://en.wikipedia.org/wiki/Docstring
  [example]: https://github.com/mahmoud/PythonDoesWhat/blob/master/pdw_009_attributedict.py

---
# Other projects

* [Erosion][erosion] - Link shortening and library demonstration
* [Skeleton sticky footer][ssf] - Responsive site template

[erosion]: https://github.com/mahmoud/erosion
[ssf]: https://github.com/mahmoud/skeleton_sticky_footer

---
# Affiliated projects

These are projects close to my heart, projects I'm proud to have helped with.

* [ufork][ufork]: Process management and server container, used by [SuPPort](#support)
* [spyce][spyce] and [pepperbox][pepperbox]: Sandboxing with Python, FreeBSD, and Capsicum

[ufork]: https://github.com/doublereedkurt/ufork
[spyce]: https://github.com/markrwilliams/spyce
[pepperbox]: https://github.com/markrwilliams/pepperbox
