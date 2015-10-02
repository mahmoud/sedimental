---
title: Enterprise Python Curriculum

---

A class about successful software project development, with Python.

[TOC]

# Introduction

Enterprise software is the discipline of scaling up. Not in terms of
volume and performance, but in terms of complexity and people
involved. Scaling technology is easy compared to scaling human
processes. In addition to preparing you for practical Python
development, this course will teach you how to form and justify the
technical positions necessary to drive projects to success.

## Prerequisites

Beginners come from all walks. There are many ways to be prepared for
this course. If you've done one of the following you're as ready as
you need to be:

  * Taken a Beginning Python course
    * O'Reilly's [Introduction to Python](http://shop.oreilly.com/product/110000448.do)
    * MIT's [Introduction to CS using Python](https://www.edx.org/course/introduction-computer-science-mitx-6-00-1x7)
    * A college or AP-level programming course that used Python
  * Read a beginning Python book
    * [Data Science from Scratch](http://www.amazon.com/Data-Science-Scratch-Principles-Python-ebook/dp/B00W4DTP2A/)
    * [Automate Boring Stuff with Python](http://www.amazon.com/Automate-Boring-Stuff-Python-Programming/dp/1593275994/)
    * Or any other book you may have read with Python in the title
    * Topic-specific Python books tend to outshine the general ones
  * Done an online tutorial
    * [Python Tutorial](https://docs.python.org/2/tutorial/)
    * [How to Think Like a Computer Scientist](http://interactivepython.org/runestone/static/thinkcspy/index.html)
    * [Learn Python the Hard Way](http://learnpythonthehardway.org)

A single run through of one of the above and you're ready to benefit
from this course. As a further recommendation, try applying new
knowledge by attempting at least one Python project of 500 lines or
more.

Either way, you should already know the fundamentals of the Python
language. This course will teach you how to apply those skills in a
professional context. Along the way we'll be covering well-known
architectural concepts and operating systems features, as viewed
through the window of Python.

You'd be surprised how little computer science and math knowledge it
takes to start being effective in an enterprise environment. There
will be some references to software engineering concepts, but nothing you
can't look up afterwards. Fluency with your development and deployment
environments is far more critical, so comfort at the command line is a
plus.

## System Requirements

We're going to be using the terminal. For the demonstrations, you'll
need Python 2.7 and a shell. (TODO: more details?)

TODO: basis of terminal usage.

# Defining the basics

Every good lesson starts with a review.

## What is Python?

* Language
* Runtime
* Platform

In enterprise environments these concepts often run together. It's
possible to use the Python language without using one of the primary
environments or runtimes (as a DSL or crosscompiling to another
language). The vast majority of enterprise Python code runs on CPython
2, specifically CPython 2.7.

## What is enterprise software?

Enterprise software, as the name suggests, is software made to be used
by a business. Enterprise software components are tailor-made and
usually one of a kind. It often has a small userbase, so accurate
requirements and feedback can be hard to obtain and incorporate.

Enterprise software often has very stringent requirements. High
performance, scalability, and reliability are the hallmark
ideals. Components may have to run indefinitely: for years or decades
with minimal maintenance. Businesses can demand a high degree of
interoperability with their existing systems and processes, so
components are specialized and often incorporate "legacy"
specifications -- design decisions made long before the project at
hand.

Timelines very widely, but enterprise software still follows the
general trend of acceleration. Customers expect usable results faster.

## When is the right time to use Python?

*"Whenever you can!"*

Python is very much a general-purpose language. ([Run through list](https://www.paypal-engineering.com/2014/12/10/10-myths-of-enterprise-python/#python-is-for-scripting))

Within enterprise it has been well-accepted into most applications:

  * Network Infrastructure (DNS)
  * Cloud computing (OpenStack, Boto)
  * Configuration management
  * ETL and data analysis, including Big Data (Hadoop, Disco)
  * Email and VoIP

Notable exceptions are mobile and web frontend, where there are viable
inroads being made, but just not in mainstream enterprise settings.

Theoretical and aesthetic superiority arguments aside, there are many
reasons why larger enterprises invest in Python.

  * Technical
      * Platform cross-compatibility
      * Wide deployment
      * Community
  * Personal
      * Popularity - A broad hiring base
      * Learnability - Train when you can't hire
      * Applicability - Many areas means easy cross-pollination

### What is Python not? (Or, other myths of enterprise Python)

Selections from
[Myths of Enterprise Python](https://www.paypal-engineering.com/2014/12/10/10-myths-of-enterprise-python/)

# Architecture and design

## Gathering requirements

First, identify your customer and other project stakeholders. They
define the standards to which the product will be held. Consumer
products without a definite customers have a bit of a
problem. Enterprise products without customers have a big
problem. And no, "everyone" is not a valid customer.

Second, define the aspects of a software component. The vocabulary of
requirements.

  * Performance
      * Latency
      * Throughput
      * Utilization and efficiency
  * Security
      * Preventing breaches
      * Maintaining availability
  * Monitoring
      * Discovering that there *is* a problem
  * Transparency
      * Finding the root cause of acute problems
      * Avoiding acute problems before they happen
      * Improving other aspects when there are no other problems
  * Agility (Maintenance, Development, and Deployment speed)
  * Reliability and predictability

All forms of testing is a process to improve one or more aspects of the above.

Scalability is the result of a strong balance of all of the above.

A stakeholder, presented with a simple checklist of the above will
check off every aspect without exception. Every aspect is desirable,
but time and resources are inevitably limited.

  * HLD template
    * Stakeholders
    * Timelines
    * Environment
    * Requirements (SLAs, etc.)
    * Dependencies
    * Architecture
    * Testing strategy
    * Contacts

## Researching environments

Define them and lock them down, for both development and deployment
environments. The more you have to support, the more support resources
you have. Ask, "where does this have to run?" and "where will
developers be working on this?"

At PayPal:

  * Local development
      * 64-bit (Linux, Mac) and 32-bit (Windows)
  * Staging and production
      * 32-bit Linux

At PayPal, 2.7 across the board. Basic in-house analytics service to
track outliers and changing environment choices of developer
community.

Making your development environment mirror your deployment environment
is a solid practice to avoid whole classes of surprises.

For each environment have an answer for:

  * Who controls this environment?
  * Who else has access?
  * How frequently can deployments be made?

The answers to these questions have more important implications for
your architectural priorities than any particular library
choices. Python exists for practical projects, and practical projects
succeed through concrete specifications.

## Choosing dependencies

* How to identify a good library
* How to gauge risk

## Designing an architecture

### Balancing KISS and DRY

Software architecture boils down to balancing two mantras:

  * Keep it simple (KISS)
  * Don't repeat yourself (DRY)

Software is inherently about automating tedious tasks: avoiding
repetition. To what extents should you go to avoid repeating
yourself. There's no point in projects so advanced that they become
unfinishable or unmaintainable.

#### Reuse

Python provides a fixed set of conceptual tools for reducing code
redundancy:

  * Functions
  * Classes
  * Modules
  * Packages


We'll talk about packages and packaging more later.

Python has been built to closely match the underpinnings of modern
operating systems. Clean-running code depends on robust support for
the fundamentals:

  * Processes
  * Threads
  * Files, all types
  * Memory

The OS's abstractions provide us the tools to effective resource
usage. Small imperfections get magnified at scale, which is why
CPython's consistency is the key to its success at these scales.

### Lifetimes and contexts

* Shortlived vs longlived processes (batch vs server)
* Within the process, use explicit contexts instead of mutating global
  state.

### Technology and Architectural Review

Always favor on-time completion. Only use "hot" technologies when you
are sure they are fully under your control. Dependencies cascade
catastrophically.

Touting new technologies can sometimes have upsides in politics and
developer morale, but generally can't make up for delivery
slippage. If you're using Python in the enterprise, count your lucky
stars and focus on building a reputation for consistency before
attempting to break the mold. If you're really in a rush, build a side
project or prototype to help build buy-in.

# Engineering practices

## Development environments

* Approximate production

### Choosing a development environment

There is no one right answer. It depends on you and your use case. In
many cases I recommend starting with what you know until you get a
feel for Python itself. If you don't know anything, then know that
Python leans toward simpler environments. So, I recommend a text
editors which are highly extensible. This way you can start simple and
customize for your workflows as you discover them.

* Text editors
    * emacs
    * SublimeText
* IDEs
    * PyCharm
    * WingIDE
* Alternatives
    * IPython Notebook
    * IDLE

## Source control, issue tracking, and continuous integration

* TODO: does source control go into development environments
* Your CI system is like an extra team member that never tires or
  holds a grudge because you pushed broken code that once.

Generally teams in enterprise don't have much control over what
technologies are used here. Regardless of the options, always use
source control. Python itself uses hg, which is written in Python, but
other DVCSes like the more popular git and less popular fossil are
free and scale well to teams of all sizes.

A centralized mirroring service such as the Enterprise version of
Github or Bitbucket is strongly recommended. Avoid issue tracking
systems which do not tightly integrate with your version control. Less
is more. Stick to the issue tracker built into your version control as
long as possible. Separate systems *will* result in out of date
information, miscommunications, and release delays.

Continuous integration takes many forms. Python has a good native
offering in buildbot, and great support in Jenkins and Travis CI.

In general, try to use what's already hosted in your environment. If
you can avoid running your own version of these developer services,
you will have more time to focus on development. That said, if you're
stuck with ClearCase and ClearQuest, maybe it's a devop's life for you.

## Development workflow

You can't automate what you haven't done at least twice
manually. Iterate by interaction

  * REPL
  * pdb
  * Source (`module.__file__`)
  * inspect
  * dis

None of these is a security risk. Trying to obfuscate this is security by obscurity.

## Design Patterns

Python-flavored Python.

  * Modules
  * Types
  * What is self?
  * Inheritance
  * 3 Everythings
    * Everything is an object
    * Everything is a dict
    * Everything is public (everything is an interface)

Design Patterns are presented as applicable to every object-oriented
language. In reality design patterns are very language-oriented.

  * Specifically created to work around the design gaps of Java and C++ (and Smalltalk, I suppose)
  * Technically they can be applied to Python. You can see a wide
    selection in the [python-patterns](https://github.com/faif/python-patterns) repo
  * However, most design patterns are superseded by design in Python
  * To the degree that seeing traditional design patterns in a Python codebase is a warning flag
  * Python introduces its own language-tailored design idioms:
    * Decorator
    * Context manager
    * Descriptor protocol
    * Iterators/generators

* decorator tutorial

* TODO: refactoring advice

## Debugging

There are two types of debugging. The kind that happens before
committing/deployment and the kind that comes after
committing/deployment.

* pdb tutorial

## Security

CPython has many inherent security advantages. It's simple,
consistent, mature, and represents good engineering
fundamentals. Built-in support for building security features is
limited, but this is actually a security benefit, as building security
promises in is a good way to get in hot water (see Java and Flash
security disclosures).

* Python Fortify certification

Automated security analysis of Python projects depends more on the
type of project than the particular detail that it's written in
Python. Python websites receive different attacks than GUI

## Code Review

* PEP8

Code review often, bout by request of the author only. The author must
exercise judgement as to which commits need review and who should
review them. For most commits, junior team members review senior
developers' commits and vice versa. For important commits, senior
should review senior. For deciding when to review, if there's doubt,
there should be a review.

Keep code reviews small, 50 lines or less. As code gets larger,
suggestions become harder to make, as more suggestions would entail
significant backtracking and rearchitecture. As a result, suggested
changes tend to stay the same size, regardless of the size of code
being reviewed.

* Code review tutorial

## Testing

* unittest
* py.test
* doctest

### When to Test

Test-driven development (TDD) is a pretty recognizable trend in
software testing practice. But it doesn't work well in a lot of
enterprise environments. For instance, many projects have assigned QA
(Quality Assurance) engineers who test features primarily upon
completion and other milestones.

Despite corporate roles, the developer is still the first person
responsible for code behavior. We recommend the developer write unit
tests for the most important parts of code and use coverage tools to
help ensure that those critical parts are sufficiently tested. Be wary
of writing tests too soon. Some parts of code need to stay high
velocity and

Tests are ideally written in the same language as the product
itself. In some cases a higher-level language can be used, but the
point is that the developer should be able to easily review test cases
when errors are found.

## Logging and monitoring

* logging and Log4J-style logging
* structured logging

## Profiling

* cProfile
* lineprof
* Sampling profilers

* cProfile tutorial

## Documentation

It should live next to the code. Always have a README.

## Packaging and Deployment

Packaging starts by looking at your environment's existing deployment
options. Here are some non-enterprise options we can rule out:

  1. Push from local machine using FTP/SSH/etc.
  2. Trigger the deployment machine to pull from version control
  3. Pull from remote PyPI (pypi.python.org)

Pay particular attention to the most *reliable* means of publishing
and deploying packages and target that.

# Next steps

## Projects

## Evangelism

* Passion projects. Niche, but targetted at an underserved group that
  will appreciate the work, not "the crowd" or hypothetical users
* Stickers and other branding
* Python Day

## Other Resources

  * Guides
      * David Goodger's [brief guide to fundamental Python idioms](http://python.net/~goodger/projects/pycon/2007/idiomatic/handout.html#the-zen-of-python-1)
  * Blogs
      * pythontesting.net
      * pythondoeswhat.blogspot.com
      * Planet Python
  * Podcasts
      * Talk Python to Me
      * From python import podcast
      * podcast `__init__`
  * Interactive
      * http://www.pythontutor.com/
      * http://interactivepython.org/runestone/static/thinkcspy/index.html
      * Jupyter
      * bitbucket.org/gregmalcolm/python_koans

# Cellar

## What this course is not

  * An in-depth analysis and comparison of frameworks used by large enterprises
      * Large enterprises are often marked by their proprietary
      technologies, tailored to their use case. Portability and
      cross-applicability are not a given.
  * An abstract cookbook of challenges and architectures which may or
    may not apply to enterprise work.
      * Same as above, use cases vary widely, and so must solutions.
      * Object Relational Mappings, Asynchronous IO, WSGI, and a
        thousand other relevant technologies may be relevant in your
        current position, but even just a brief summary of each would
        be as long as the rest of the course. Better to search out
        blog posts and other detailed sources.
      * By focusing on developing good fundamentals, intuitions and
        habits, we aim to ensure you get the most out of the course
