---
title: Enterprise Python Curriculum
---

Enterprise software is the discipline of scaling up. Not in terms of
volume and performance, but in terms of complexity and people
involved. Scaling technology is easy compared to scaling human
processes. In addition to preparing you for practical Python
development, this course will teach you how to form and justify the
technical positions necessary to drive projects to success.

Basic outline:

  * Review
  * Environments
  * Architecture concepts
  * Development priorities

[TOC]

## Review

Beginners come from all walks. If you've done one of the following you're as ready as you need to be:

  * Taken a Beginning Python course
    * O'Reilly's [Introduction to Python](http://shop.oreilly.com/product/110000448.do)
    * MIT's [Introduction to CS using Python](https://www.edx.org/course/introduction-computer-science-mitx-6-00-1x7)
  * Read a beginning Python book
    * Topic-specific Python books tend to outshine the general ones
    * [Data Science from Scratch](http://www.amazon.com/Data-Science-Scratch-Principles-Python-ebook/dp/B00W4DTP2A/)
    * [Automate Boring Stuff with Python](http://www.amazon.com/Automate-Boring-Stuff-Python-Programming/dp/1593275994/)
    * Or any other book you may have read with Python in the title
  * Done an online tutorial
    * [Python Tutorial](https://docs.python.org/2/tutorial/)
    * [How to Think Like a Computer Scientist](http://interactivepython.org/runestone/static/thinkcspy/index.html)
    * [Learn Python the Hard Way](http://learnpythonthehardway.org)

A single run through of one of the above and you're ready to benefit
from this course. Especially if you've applied the knowledge by
attempting at least one Python project of 500 lines or more after the
reading. You should know the fundamentals of the language, this course
will teach you how to apply them. Along the way we'll be covering
well-known architectural concepts and operating systems features, as
viewed through the window of Python.

(You'd be surprised how little CS and math you need to start being
effective in an enterprise environment. Fluency with your development
and deployment environments is far more critical, so comfort at the
command line is a plus.)

### What is Python?

* Language
* Runtime
* Platform

It's important to distinguish between these three because in
enterprise environments these concepts often run together. It's
possible to use the Python language without using one of the primary
environments or runtimes (as a DSL or crosscompiling to another
language). The vast majority of enterprise Python code runs on CPython
2, specifically CPython 2.7.

### Advantages of Python

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

### When to use Python

*"Whenever you can!"*

Python is very much a general-purpose language. ([Run through list](https://www.paypal-engineering.com/2014/12/10/10-myths-of-enterprise-python/#python-is-for-scripting))

Within enterprise it has been well-accepted into most applications:

  * Network Infrastructure (DNS)
  * Cloud computing (OpenStack, Boto)
  * Configuration management
  * ETL and data analysis, including Big Data (Hadoop, Disco)
  * Email and VoIP

Notable exceptions are mobile and web frontend, where there are viable
inroads being made, but just not enterprise.

### (Other) Myths of Enterprise Python

Selections from [Myths of Enterprise Python](https://www.paypal-engineering.com/2014/12/10/10-myths-of-enterprise-python/)

## Architecture and design

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

## Engineering Practices

### When to Test

Test-driven development (TDD) is a pretty recognizable concept. But it
doesn't work well in a lot of enterprise environments. For instance,
many projects have assigned QA (Quality Assurance) engineers who test
features primarily upon completion and other milestones.

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

### Code Review

Code review often, but by request of the author only. The author must
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

### Security

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

### Profiling

### Debugging

### Source Control, Issue Tracking, and Continuous Integration

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

## Considerations

### Environmental requirements

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

### Software Aspects

  * Performance
      * Latency
      * Throughput
      * Utilization and efficiency
  * Security
      * Preventing breaches
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

### TODO

  * Refactoring
  * Design Patterns

#### Demos

  * Decorator tutorial
  * Code Review tutorial
  * Debugging demo
  * Profiling demo

#### Python-flavored Python

  * Modules
  * Types
  * What is self?
  * Inheritance
  * 3 Everythings
    * Everything is an object
    * Everything is a dict
    * Everything is public (everything is an interface)

#### Iterate by interaction

  * REPL
  * pdb
  * Source (`module.__file__`)
  * inspect
  * dis

None of these is a security risk. Trying to obfuscate this is security by obscurity.

#### Other Resources

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

#### What this course is not

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
