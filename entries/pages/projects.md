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
open-source projects. Looking back, I'm actually pleased with the
conversion ratio, but I remain convinced the best is yet to come.

In the meantime, here is a summary and status for each of my current
projects, roughly ordered by some combination of popularity, age, and
personal utility. You could get a majority of this information from
[my GitHub repositories page][cn]. Also included here is a little
information about the current state of each project and minor
background details.

All the weird names are because I fancy myself an amateur
geologist. But you don't need to be a geologist to appreciate all this
free software!

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
  also my most popular project, and certainly my most mature in terms
  of being documented, tested, and officially released.

  I actively maintain Boltons and encourage you to take a look at the
  README and let me know if you have any questions or feature
  requests.

---
title: Ashes
est_date: January 11, 2013
release_status: Soft release, pending documentation
gh_link: https://github.com/mahmoud/ashes
pypi_link: https://pypi.python.org/pypi/ashes
description: |

  Ashes is a small and scrutable HTML templating library with a
  practical, language-agnostic featureset. Ashes achieves this by
  implementing virtually all of [the Dust templating language][cn] in
  a single, easily-embeddable Python file. It is tested on Python 2
  and 3 and used in production by countless projects, including
  [Clastic](#clastic).

---
title: Clastic
est_date: November 8, 2012
release_status: Soft release, pending branding
gh_link: https://github.com/mahmoud/clastic
pypi_link: https://pypi.python.org/pypi/clastic
description: |

  Clastic is a web site and service microframework with low
  performance overhead and high developer productivity. By eschewing
  global state, Clastic is easy to reason about and run with all
  concurrency models. It also uses Werkzeug's web primitives, so it's
  well-documented and widely understood.

  Clastic was built in response to several shortcomings I encountered
  with Django and Flask. I used it to build [ETAVTA][etavta] and some
  [Hatnote projects][hatnote_projects], and gradually developers at
  PayPal started using it, too. Billions of requests later it
  continues to fulfill its primary goals without issue and unlike any
  other service framework. There are still several TODO items, but
  seeing as it works so well, development is occasional, at least
  until I get the time to write up a public release announcement.

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
  useful from the first moments of development.

  Lithoxyl started after discovering major inefficiencies in Python's
  built-in [logging module][cn], a hasty port of Java's Log4J. Rather
  than engineering a better implementation of an outdated design,
  Lithoxyl is an inherently more powerful system that is
  lower-overhead and higher-performance by nature.

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
  as IFTTT).

  I use it literally every day to monitor my Hatnote projects. Special
  thanks to Mark Williams for all his help on this.

---
title: ETAVTA
est_date: November 8, 2012
release_status: Soft release, pending announcement
gh_link: https://github.com/mahmoud/etavta
description: |

  ETAVTA is my answer to the Valley Transit Authority's (VTA)
  complicated light rail schedule and Google Maps' inaccurate
  estimates. It computes a full weeklong schedule for all trains and
  tells you the next five trains going north and south at any of the
  62 VTA stations. It's pretty simple, and serves as a decent example
  of how to use [Clastic](#clastic).

---
title: Hematite
est_date: May 19, 2013
gh_link: https://github.com/mahmoud/hematite
pypi_link: https://pypi.python.org/pypi/hematite
release_status: On hiatus
description: |

  Hematite is a set of HTTP primitives for server and client use. It's
  tough creating a symmetrical abstraction that is practical, so while
  I use it in some projects, I don't recommend it for public usage
  yet.

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
  *P*ackage *I*ndex *Critic*.

---
title: PythonDoesBlog
gh_link: https://github.com/mahmoud/PythonDoesBlog
est_date: January 14, 2012
release_status: Discontinued
description: |

  Originally created as platform for [Python Does What?!][cn] (PDW),
  PythonDoesBlog is a one-of-a-kind blogging engine, where posts are
  written as Python modules. Text is ReStructuredText in docstrings,
  and the remainder of the code is highlighted. There was also special
  docstring handling to make sure that the module executed as expected
  before publishing.

  PythonDoesBlog likely still works, and its partial results are still
  visible at [pythondoeswhat.com](http://pythondoeswhat.com), but as
  the PDW topics became more complex, we were writing cases that would
  crash the interpreter and do other bad things that PythonDoesBlog
  could never support.

  To this day I scoff at Python static site generators (including
  [this one](#chert)), "Oh, your blog post is rendered with Python?
  That's cool. My blog posts **are** Python."

---
# Other projects

* Erosion

---
# Affiliated projects

These are projects close to my heart, projects I'm proud to have helped with.

* ufork
* spyce
