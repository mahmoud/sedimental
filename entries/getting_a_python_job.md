---
title: Getting a Python job
publish_date: 1:02pm January 25, 2016
tags:
  - work
  - python
---

Every day, Python is the primary programming language for tens if not
hundreds of thousands of professional engineers, analysts, and
researchers, including yours truly. Given Python's "language of
choice" status, what can you do to join those lucky ranks?

It's a good question, and one I get often. Recently I was asked more
publically than
usual. [Michael Kennedy](https://twitter.com/mkennedy), host of the
[Talk Python to Me podcast](https://talkpython.fm/), asked me five
questions on behalf of people early in their Python/programming
careers:

1. What kind of Python devs do you work with and interview?
2. What is the most important piece of experience that you look for in a candidate?
3. If someone is applying for their first job with you, what can they
   present to show they have the right skillset/education?
    * Open-source contributions
    * Side projects
    * Mobile phone apps
    * Websites
    * Code competitions
4. If you are presented with two candidates, one with a solid CS
   degree, and the other with 1-2 years of experience, which would
   you value more?
5. Why did you hire the last person you hired?

Here are my answers, the enterprise hiring perspective, as transcribed
from my parts of [the panel discussion][full_ep].

[TOC]

# Intro

Hi my name is Mahmoud Hashemi. I'm lead developer of Python
Infrastructure
[at PayPal](https://www.paypal-engineering.com/tag/python/), and I'm
also the presenter of Enterprise Software with Python, coming soon
[from O'Reilly](http://www.oreilly.com/pub/au/6849). Dedicated listeners may recognize my voice from
[episode #4 of Talk Python to Me](https://talkpython.fm/episodes/show/4/enterprise-python-and-large-scale-projects),
and it's great to be back on the show.

# My type of hiring

***What kind of Python devs do you work with and interview?***

I work with Python infrastructure engineers. Software infrastructure
is the foundation of all sorts of software development, from web to
backend to batch to automation and tools. To do it well you have to
have personal experience developing in two or more of those
categories. For the past year or so, my team has been adjunct to the
PayPal application security team, and that's who I'm hiring for right
now. So a little plug, if you have at least five years of industry
experience and want to get into some ultrahigh performance Python
security work, shoot me an email at [mahmoud@paypal.com](mailto:mahmoud@paypal.com).

All that said, one of the services the Python infrastructure team also
performs is to do phone and in-person interviews for PayPal teams
looking to expand their Python talent through hiring.

# The most important experience

***What is the most important piece of experience that you look for in a candidate?***

The most important fundamental skills I look for are closely related
to experience: environmental fluidity and personal learning abilty.

Wait, not Python? That's right. The fact is, for more junior jobs, the
Python is going to be the easiest part of the job, and new hires have
plenty of time to learn, plus the team is there to help. New
developers will come up to speed quickly provided they're comfortable
learning in the environment.

As for environmental fluidity, specifically, PayPal uses a lot of
Linux, so I look for candidates that can demonstrate familiarity at
the console, interacting with the operating system. So while I don't
usually give candidates complex algorithmic questions on the spot, I
*do* log them into one of PayPal's test servers and have them do some
basic debugging. For the experienced, you can almost feel them
relaxing into a familiar environment. For the inexperienced, the
terminal can be an aptly named dark and scary place. Either way, the
command line is a foundational technology critical to enterprise work,
and is not going away anytime soon. Lack of command line comfort is a
big yellow flag, especially when Linux is so widespread and easy to
experiment with on your own.

The other characteristic I look for is learning ability. The skills
to read and research naturally, absorbing and arranging information
automatically. I've been burned once or twice by talented people who
were too lazy to read the docs, or too intimidated to read the source
code. You don't have to do it in big gulps, but you do need to do it
consistently. So I usually look at what candidates have done to learn
lately, and the sources they've been consulting. Show me some code
you've written and what you learned during the process. Tell me about
a project that sounds much simpler than it was. What sites taught you
the web? Seen any noteworthy source code lately?

On the other hand, I watch out for HackerNewsy types. My projects have
topped HN several times in the last couple years, and some lurking is
fine, but I want someone ready to outgrow that consumption and
commodification of creative work interleaved with press
releases. Someone ready to dedicate time to actually create the sorts
of things that others will upvote.

# Side experience

***If someone is applying for their first job with you, what can they
present to show they have the right skillset/education?***

When it comes to first jobs and concrete projects, I'll look at
anything and everything. With new developers it's just so rare to get
someone with anything interesting in their GitHub or Bitbucket
account, but that is definitely my first stop. Software is
increasingly portfolio driven, and I do get a bit discouraged when I
see a developer who doesn't have a GitHub, or a site, or even a
blog. You can cram for an interview, and you can exaggerate on a
resume, but you can't really fake a meaningful commit timeline going
back a year or two. Even if it's just school projects, at least I
could see you've tried and you have some basic git
skills. Contributions to other projects tell a good story, too. You
were probably using the project for something, being productive. You
took the time to understand how it worked, you were able to
communicate, and lived up to someone else's standards. That's
stressful for a lot of people, but that's got a lot in common with
enterprise development, too.

Side projects and apps that run in environments similar to our own are
very interesting. Mobile phone apps not as much. Code competitions and
scores from reddit/stackoverflow/HN are OK, but honestly those skills
don't apply that well internally. This may make me unpopular, but
people who have high scores on all those sites are playing games that
can lead them to be impatient and unhelpful with internal people and
processes. That said, if you're someone who helps out with mentorship
or even get on IRC and answer questions, that could be great!

# Formal education

***If you are presented with two candidates, one with a solid CS
degree, and the other with 1-2 years of experience, which would
you value more?***

Of the three hires I'd truly consider my "star" hires, none of them
had a CS degree. Electrical engineering, math, and comparative
literature. The things they had in common were voracious reading and
extensive hours spent in some Python or POSIX environment.

Computer science degrees aren't really necessary for the majority of
enterprise work. Like I said before, environmental fluidity and
willingness to read docs are far more important. A couple of CS
classes get you some useful vocabulary and teach you time
complexity.

As for the concept of a degree in general, if you want to work at a
big company, it's a lot easier to get in with a bachelors. You don't
need much more than that. The right two years of experience can go a
long way in terms of skills development, but in terms of management
marketability, no degree raises eyebrows in many cases. So, in short,
for enterprise software, my observation is that a computer science
degree is about as good as a non-CS degree plus 2 years experience
which is about as good as no degree plus 4-5 years experience, at least.

Most professors and academic programs don't give you all that much
pragmatic knowledge, even if it's pretty old stuff like emacs and
terminal usage. Basically everything is about how you approach your
assignments and free time. If you push beyond the requirements, you
will learn much more.

So, if you're in school, take an operating systems class. Take a
networking class. Maybe a crypto class. You'll learn almost as much as
running a shared server in your dorm. No, those are different types of
knowledge, so consider doing both. If you're not in school, Coursera
and other options are far better than nothing, and I'd like to hear
about those experiences in interviews.

# Last hire

***Why did you hire the last person you hired?***

I gave my most recent thumbs up to a developer who knew Django and was
willing to continue working with it, but most importantly he could
start on-site before the req closed. In large companies, empty seats
have expiration dates, and everyone is willing to gamble. Because
somebody is better than nobody, and even if they're worse than nobody,
then you still get a backfill when they leave or are pushed out. But
this developer seems to be working out, but I only helped hire him for
another team.

The last engineer I hired onto my team was recruited over the course
of two years. I met him at PyCon 2012 and we collaborated on a few
open-source projects. Real recruiting can be a long process, not the
least of which is due to weird budgeting and bureaucracy. So please
don't get frustrated if you're still waiting on an email reply from
me! :)

# Takeaways

Reduced to a few bullet points, here are the key characteristics:

* Environmental fluidity
* Reading ability and conceptual familiarity
* Command line comfort
* Not HackerNewsy
* Dedication. No technical butterflies here, please.
* Pragmatism, lack of frustration
* Management marketability
* Ability/willingness to work/train/visit onsite

The other interviewees had some interesting things to say, as well. I
recommend checking out [the full podcast][full_ep], now featuring
[transcripts for everyone, not just me][full_transcript]. Thanks again
to Michael for having me back!

[full_ep]: https://talkpython.fm/episodes/show/41/getting-your-first-dev-job-as-a-python-developer-part-2
[full_transcript]: https://talkpython.fm/episodes/transcript/41/getting-your-first-dev-job-as-a-python-developer-part-2
