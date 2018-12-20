---
title: Awesome Python Applications
---

If you're reading this, you probably read and write code. Somehere in
the excitement of software's abstraction, we can lose sight of where
the rubber meets the road. Where our reusable modules and packages and
frameworks turn into real-world applications.

That's why I'm pleased to announce *Awesome Python Applications*, a
hand-curated list of 180+ projects, all of which are:

1. Free software with an online source repository.
2. Using Python for a considerable part of their functionality.
3. Well-known, or at least prominently used in an identifiable niche.
4. Maintained or otherwise demonstrably still functional on relevant platforms.
5. Applications, not libraries or frameworks.

Exceptions can be made within reason.

This list predominantly focuses on software that installs without
`pip` or PyPI, and whose audience is mostly *not* developers. There's
still plenty of that in there, too, but the view taken is broader.

So why do we need a catalog of open-source Python applications?

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

Isn't Python one of the largest programming languages in the world?
Aren't there dozens of successful, real-world applications written in
Python? What are the chances your application is totally unique?

So *Awesome Python Applications* is really an attempt to create a
new flow for answering tough development questions.

When building an application, scan the list to find projects which
most closely match your project's requirements. Then, use that
application as a guide for answering your own questions. This works
especially well around abstract questions like architecture,
deployment, and testing.

Back in school, I learned more about architecture and software
development from the MediaWiki source code than I did from any
class. APA is the next step in enabling the holistic education of a
working application with real users.

In short, a production application worth a thousand blog posts. The
APA has over 180 applications already, so you do the math.

# Goal #2: A More Complete Python Production Loop

We Python programmers are also software *users*. But unlike other
software users, we know how to file issues and may even make
significant contributions back to our applications of choice.

By choosing Python software when possible, we take one step closer to
pitching in. Not to mention that Python developers interested in
eventually developing their own application will find the experience
much more edifying than lower-level library work.

I would love to see more developers connect with software they didn't
realize was Python. My (minor) contributions to the
[Twisted](https://github.com/twisted/twisted) were greatly energized
by the knowledge that one of my favorite applications,
[Deluge](https://github.com/deluge-torrent/deluge), heavily used the
library.

# Goal #3: Grounding for the Python Ecosystem

With the pace and cerebrality of technology, it can be easy to get
ahead of ourselves and our end users. Even widely-used applications
garner few stars if their users are not developers, and they rarely go
viral in software circles. Few major Python applications are
distributed with PyPI, so download statistics can't help us
either. Even if they did, lower-level libraries would blow them out of
the water. And of course free software projects can't lay down big
donations or conference sponsorships, so representation tends to be
pretty sparse all around.

These projects represent the best of the free and living portion of
Python. Not only are they a source of utility and pride, but they need
our support, in spirit and in practice. it is my sincere hope that the
APA will help anchor the Python community in its real-world
applications.

There's a lot of directions and room for improvement! A keen eye will
notice how [the list is
structured](https://github.com/mahmoud/awesome-python-applications/blob/master/projects.yaml). This
isn't just for consistent rendering, but because I hope this can act
as a sort of API for the dataset. We should explore our ecosystem with
the relationship between libraries and applications in mind.

For example, I know metrics aren't everything, but it would be very
interesting to see the Python FOSS ecosystem explored as an analogue
of the scientific publishing framework. Can we get interesting metrics
by treating libraries as "articles" and applications as "journals"?
Adding in some application userbase approximations (via social
altmetrics and other means) can give us much deeper insight into
real-world impact.

# Next steps

If this essay seems shorter than [my usual](/archive.html), that's
because it's really an introduction to [the list
itself](https://github.com/mahmoud/awesome-python-applications). I got
caught up in several projects' codebases while doing the research, and
you will, too.
