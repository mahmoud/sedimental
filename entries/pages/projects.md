---
title: Open-Source Projects
field_label_map:
  start_date: Started
  gh_link: View on GitHub
field_type_map:
  gh_link: link
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
[my GitHub repositories page][cn], but here I also include a little
information about the current state of each project.
<!-- TODO: relevant links for each -->

[TOC]

---
title: Boltons
start_date: March 2013
release_status: Released
description: |

  Boltons is an expansive collection of Python utilities I've badly
  missed from the Python standard library. My most popular project,
  and certainly my most mature in terms of being documented, tested,
  and officially released.

  I actively maintain Boltons and encourage you to take a look at the
  README and let me know if you have any questions or feature
  requests.

---
title: Ashes
start_date: March 2013
release_status: Soft release, pending documentation
description: |

  Ashes is a small and scrutable HTML templating library with a
  practical, language-agnostic featureset. Ashes achieves this by
  implementing virtually all of [the Dust templating language][cn] in
  a single, easily-embeddable Python file. It is tested on Python 2
  and 3 and used in production by countless projects, including
  [Clastic](#clastic).

---
title: Clastic
start_date: November 2012
release_status: Soft release, pending branding
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
start_date: November 2013
release_status: Active development
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
start_date: October 2014
release_status: Active development
description: |

  Chert is the static site generation system designed to fit the
  workflow of modern digital written media. In addition to the
  standard Markdown/YAML syntax and RSS/Atom feeds, Chert supports
  automatic table of contents generation and structured list entry
  formats. Eat your heart out, Buzzfeed.

---
title: Strata
start_date: March 2014
release_status: On hiatus
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
title: ETAVTA
start_date: November 2012
description: |

  ETAVTA is my answer to the Valley Transit Authority's (VTA)
  complicated light rail schedule and Google Maps' inaccurate
  estimates. It computes a full weeklong schedule for all trains and
  tells you the next five trains going north and south at any of the
  62 VTA stations. It's pretty simple, and serves as a decent example
  of how to use [Clastic](#clastic).

---

title: Hematite

---
title: Tectonic

---
title: Picritic

---
title: Python Does Blog
start_date: 2010

---

# Other projects

* Cronfed
* Picritic
* Erosion

---

# Affiliated projects

These are projects close to my heart, projects I'm proud to have helped with.

* ufork
* spyce
