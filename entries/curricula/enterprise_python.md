---
title: Enterprise Python Curriculum
---

Enterprise software is the discipline of scaling up. But not usually
in terms of volume and performance, but in terms of complexity and
roles involved. Scaling technology is easy compared to scaling people
and processes. In addition to preparing you for practical Python
development, this course will teach you how to form and justify the
technical positions necessary to drive successful projects.

Basic outline:

  * Review
  * Environments
  * Architecture concepts
  * Development priorities

[TOC]

## Review

Beginners come from all walks. If you've done one of the following you're as ready as you need to be:

  * Taken a Beginning Python course
    * link to oreilly course and a couple books
  * read a beginning Python book
    * links
  * Done an online tutorial
    * [Python Tutorial](https://docs.python.org/2/tutorial/)
    * [How to Think Like a Computer Scientist](http://interactivepython.org/runestone/static/thinkcspy/index.html)
    * [Learn Python the Hard Way](http://learnpythonthehardway.org)

A single run through of one of the above and you're ready to benefit
from this course. Especially if you've done at least one Python
project of 500 lines or more since the reading. You should know the
fundamentals of the language, this course will teach you how to apply
them. Along the way we'll be covering well-known architectural
concepts and operating systems features, as viewed through the window
of Python.

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

### Security

### Profiling

### Debugging

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
