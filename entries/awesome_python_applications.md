---
title: Awesome Python Applications
entry_root: awesome_python_applications
tags:
  - python
  - code
  - apa
publish_date: 11:20am December 20, 2018
---

*What we can learn from 180+ case studies on successfully shipping Python software.*

If you're reading this (or hearing
[this](https://testandcode.com/55)), you read and write code, probably
Python. And for all the code you've shipped, you've probably had your
share of missed requirements. Somehere in the excitement of software
abstraction, we can lose sight of what really matters, what makes our
well-factored modules and packages and frameworks turn into real-world
applications.


That's why I'm announcing [***Awesome Python
Applications***](https://github.com/mahmoud/awesome-python-applications),
a hand-curated list of 180+ projects, all of which are:
<img align=right width="40%" src="/uploads/illo/snake_cd.png">

1. Free software with an online source repository.
2. Using Python for a considerable part of their functionality.
3. Well-known, or at least prominently used in an identifiable niche.
4. Maintained or otherwise demonstrably still functional on relevant platforms.
5. Shipped applications, not libraries or frameworks.

The result is a list of predominantly focused on software that
installs without `pip` or PyPI, and whose audience is mostly *not*
developers. There's still plenty of that in there, too, with other
exceptions, but the breadth of the list [speaks for
itself](https://github.com/mahmoud/awesome-python-applications#awesome-python-applications).

So why spend weeks cataloguing open-source Python applications?

Aside from holiday cheer, three big reasons.

[TOC]

# Goal #1: A Better Development Cycle

Ever since I started
[talking](https://www.youtube.com/watch?v=iLVNWfPWAC8)
[about](https://www.youtube.com/watch?v=tfI2hdK6vVY) [Python
packaging](http://sedimental.org/the_packaging_gradient.html), people
have been asking me questions about which packaging technique is best
for their software. I was struck, over and over again, how far people
can get in developing an application before reaching the fundamental
question of delivery. Exploring this, I landed on a more basic
question:

> Why are so many people building applications from first
> principles (blog posts and Stack Overflow)?

Isn't Python one of the biggest names in the software world?  Aren't
there dozens of successful, real-world applications written in Python?
What are the chances your application is totally unique?

*Awesome Python Applications* attempts to open up a new
flow for answering the toughest development questions.

When building an application, scan the list to find projects which
most closely match your project's requirements. Then, use that
application as a guide for answering your own questions. This works
especially well for abstract questions surrounding architecture,
deployment, and testing.

Back in school, I learned more about architecture and software
development from [the MediaWiki source
code](https://github.com/wikimedia/mediawiki) than I did from any
class. It continues to inspire me [to this
day](http://sedimental.org/hatnote_projects.html). APA is the next
step in enabling the holistic education of a working application with
real users.

In short, while we may lack the time [to write
them](http://aosabook.org/en/index.html), each production application
is worth a thousand blog posts.

# Goal #2: A Complete Python Production Loop

We Python programmers are also software *users*. But unlike other
software users, we know how to file issues and may even make
significant contributions back to our applications of choice.

<img align=right width="30%" src="/uploads/illo/network_sm.png">

By choosing Python software when possible, we take one step closer to
pitching in. What better way for a future application developer to get
started?

I would love to see more developers connect with software they didn't
realize was Python. My (minor) contributions to the
[Twisted](https://github.com/twisted/twisted) were greatly energized
by the knowledge that one of my favorite applications,
[Deluge](https://github.com/deluge-torrent/deluge), heavily used the
library. Using free software leads to creating more free software.

# Goal #3: Grounding for the Python Ecosystem

With the pace and cerebrality of technology, it can be easy to get
ahead of ourselves and our end users. Infrastructure devs get
disconnected from application devs, and that makes for worse software
over time. This problem is compounded when applications get less
developer attention. Most APA entries have three- and even two-digit
starcounts, unless users are highly technical. Few major Python
applications are distributed with PyPI, so [download
statistics](https://pypistats.org) can't help us either. Even if they
did, lower-level libraries have way more fanout. And of course free
software projects can't lay down big donations or conference
sponsorships, so representation tends to be pretty sparse all around.

These applications represent the best of the free and living portion of
Python. Not only are they a source of utility and pride, but they need
our support, in spirit and in practice. It is my sincere hope that the
APA will help to anchor the Python community in its real-world
applications.

What does this mean, concretely? A keen eye will
notice [how the list is
structured](https://github.com/mahmoud/awesome-python-applications/blob/master/projects.yaml). This
isn't just for consistent rendering, but an attempt at an API for the
dataset. We must explore our ecosystem with the relzationship between
libraries and applications in mind.

I know I'm going out on a limb here, and metrics aren't everything,
but it would be very interesting to see the Python FOSS ecosystem
explored as an analogue of the scientific publishing framework. Can we
get some sort of developer
[*h*-index](https://en.wikipedia.org/wiki/H-index) by treating
libraries as
"[articles](https://en.wikipedia.org/wiki/Article-level_metrics)" and
applications as
"[journals](https://en.wikipedia.org/wiki/Journal-level_metrics)"?
Adding in some application userbase approximations (via social
[altmetrics](https://en.wikipedia.org/wiki/Altmetrics) and other
means) can give us much deeper insight into real-world impact.

# Next steps

If this essay seems shorter than [my usual](/archive.html), that's
because it's really an introduction to [the list
itself](https://github.com/mahmoud/awesome-python-applications). I got
caught up in several projects' codebases while doing the research, and
you will, too.

If we've missed a project, please open [an
issue](https://github.com/mahmoud/awesome-python-applications/issues/new)
or PR. If you're as excited about this as I am, consider helping with
some of [the open
issues](https://github.com/mahmoud/awesome-python-applications/issues). There
are still a lot of application features to survey: licenses,
Python versions, frameworks, and more. And as always, watch this space
(and the repo) for updates as we make more discoveries!
