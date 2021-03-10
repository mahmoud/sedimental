---
title: "Changing the Tires on a Moving Codebase"
entry_root: tech_refresh
tags:
  - python
  - code
  - work
publish_date: 8:30am March 10, 2021
---

*2020 was a year of reckonings. And for all that was beyond one’s
control, as the year went on, I found myself pouring more and more
into the one thing that felt within reach: futureproofing of the large
enterprise web application I helped build,
[SimpleLegal](https://simplelegal.com).*

*Now complete, this replatforming easily ranks in my most complex
projects, and right now, holds the top spot for the happiest
ending. That happiness comes at a cost, but with some the right
approach that cost may not be as high as you think.*

[TOC]

# The Bottom Line

We took [SimpleLegal](https://simplelegal.com)’s primary product, a
300,000 line Django-1.11-Python 2.7-Redis-Postgres-10 codebase, to a
Django 2.2-Python 3.8-Postgres-12 stack, on-schedule and without major
site incidents. And it feels amazing.

Speaking as tech lead on the project, what did it look like? For me,
something like this:

<img width="100%" src="/uploads/tr_img/2020_commit_graph.png"
title="You can see the last vestiges of normal all the way on the left.">

But as Director of Engineering, what did it cost? **3.5 dev years**
and just about **$2 per line of code**.

And I'm especially proud of that result, because along the way, we
also substantially improved the speed and reliability of both the site
and development process itself. The product now has a bright future
ahead, ready to shine in sales RFPs and compliance
questionnaires. Most importantly, there’ll be no worrying about when
to delicately break it to a candidate that they’ll be working with
unsupported technology.

In short, a large, solid investment that’s already paying for
itself. If you just came here for the estimate we wish we had, you've
got it. This post is all about how your team can achieve the same
result, if not better.

# The Setup

The story begins in 2013, when a freshly YC-incubated SimpleLegal made
all the right decisions for a new SaaS LegalTech company: Python,
Django, Postgres, Redis. In classic startup fashion, features came
first, unless technology was a blocker. Packages were only upgraded
incidentally.

<img width="40%" src="/uploads/tr_img/tech_debt.png" align="right"
title="Masks are effective, except when it comes to dusty code.">

By 2019, the end of this technical runway had drawn near. While Python
2 may be getting extended support from various vendors, there were
precious few volunteers in sight to do Django 1 CVE patches in 2021. A
web framework’s a riskier attack surface, so we finally had our
compliance forcing function, and it was time to pay off our tech debt.

# The Outset

So began our Tech Refresh replatforming initiative, in Q4 2019. The
goal: Upgrade the stack while still shipping features, like changing
the tires of a moving car. We wanted to do it carefully, and that
would take time. Here are some helpful ground rules for long-running
projects:

1. Any project that gets worked on 10+ hours per week deserves a
   30-minute weekly sync.
2. Every recurring meeting deserves a log. Put it in the invite. Use
   that Project Log to record progress, blockers, and decisions.
3. It’s a marathon, not a sprint. Avoid relying on working nights,
   weekends, and holidays.

We started with a sketch of a plan that, generously interpreted, ended
up being about halfway correct. Some early guesses that turned into
successes:

1. Move to [pip-tools](https://github.com/jazzband/pip-tools) and
   unpin dependencies based on extensive changelog analysis. Identify
   packages without py23 compatible versions. (Though we’ve since
   moved to [poetry](https://github.com/python-poetry/poetry).)
2. Add line coverage reporting to CI
3. Revamp internal testing framework to allow devs to quickly write tests

More on these below. Other plans weren’t so realistic:

1. Take our CI from ~60% to 95% line coverage in 6 months
2. Parallelized conversion of app packages over the course of 3 months
3. Use low traffic times around USA holidays (Thanksgiving, Christmas,
   New Years) to gradually roll onto the new app before 2021.

We were young! As naïve as we were, at least we knew it would be a lot
of work. To help shoulder the burden, we scouted, hired, and trained
three dedicated off-shore developers.

# The Traction Issues

Even with added developers, by mid-2020 it was becoming obvious we
were dreaming about 95% coverage, let alone 100%. Total coverage may
be best practice, but 3.5 developers couldn’t cover enough ground. We
were getting valuable tests, and even finding old bugs, but if we
stuck with the letter of the plan, Django 2 would end up being a 2022
project. At 70%, we decided it was time to pivot.

We realized that CI is more sensitive than most users for most of the
site. So we focused in on testing the highest impact code. What’s
high-impact? 1) the code that fails most visibly and 2) the code
that’s hardest to retry. You can build an inventory of high-impact
code in under a week by looking at traffic stats, batch job schedules,
and asking your support staff.

Around 80% of the codebase falls outside that high-traffic/high-impact
list. What to do about that 80%? Lean in on error detection and fast
time-to-fix.

# The Sentry Pivot

<img width="25%" src="/uploads/tr_img/magnifyingglass.png" align="right"
title="You haven't seen your code until you've seen it in a stack trace.">

One nice thing about startup life is that it’s easy to try new
tools. One practice we’ve embraced at SimpleLegal is to reserve every
5th week for developers to work on the development process itself,
like a coordinated 20% time. Even the best chef can’t cook five-star
food in a messy kitchen. This was our way of cleaning up the shop and
ultimately speeding up the ship.

During one such period, someone had the genius idea to add dedicated
error reporting to the system, using
[Sentry](https://sentry.io/). Within a day or two, we had a site you
could visit and get stack traces. It was pretty magical, and it wasn’t
until Tech Refresh that we realized that while integration takes one
dev-day, full adoption can take a team months.

You see, adding Sentry to a mature-but-fast-moving system means one
thing: noise. Our live site was erroring all the time. Most errors
weren’t visible or didn’t block users, who in some cases had quietly
learned to work around longstanding site quirks. Pretty quickly, our
developers learned to treat Sentry as a repository of debugging
information. A Sentry event on its own wasn’t something to be taken
seriously in 2019. That changed in 2020, with the team responsible for
delivering a seamless replatform needing Sentry to be something else:
a responsive site quality tool.

How did we get there? First step, enhance the data flowing into Sentry
by following [these best
practices](https://docs.sentry.io/product/sentry-basics/guides/getting-started/#-how-many-projects-should-i-create):

1. Split up your products into
   [separate Sentry projects](https://docs.sentry.io/product/sentry-basics/guides/getting-started/#-how-many-projects-should-i-create). This includes your frontend and backend.
2. Tag your releases. Don’t tag dev env deployments with the branch,
   it clutters up the Releases UI. Add a separate branch tag for
   searches.
3. Split up your environments. This is critical for directing
   alerts. Our Sentry client environment is configured by domain
   conventions and Django’s [sites
   framework](https://docs.djangoproject.com/en/3.1/ref/contrib/sites/). If it helps, here's
   a baseline, we use these environments:
    * Production: Current official release. DevOps monitored.
    * Sandbox: Current official release (some companies do next
      release). Used by customers to test changes. DevOps monitored.
    * Demo/Sales: Previous official release. Mostly internal traffic,
      but external visibility at prospect demo time. DevOps monitored.
    * Canary: Next official release. Otherwise known as
      staging. Internal traffic. Dev monitored.
    * ProdQA: Current official release. Used internally to reproduce
      support issues. Dev monitored.
    * QA: Dev branches, dev release, internal traffic. Unmonitored
      debugging data.
    * Local test/CI: Not published to Sentry by default.

With issues finally properly tagged and searchable, we used Sentry’s
new [Discover tool](https://docs.sentry.io/product/discover-queries/)
to export issues weekly, and prioritize legacy errors. To start, we
focused on high-visibility production errors with non-internal human
users. Our specific query: `has:user !transaction:/api/*
event.type:error !user.username:*@simplelegal.*`

We triaged into 4 categories: Quick fix (minor bug), Quick error (turn
an opaque 500 error into a actionable 400 of some form),
[Spike](http://agiledictionary.com/209/spike/) (larger bug, requires
research), and Silence (using Sentry’s ignore feature). Over 6 weeks
we went from over 2500 weekly events down to less than 500.

Further efforts have gotten us under 100 events per week, spread
across a handful of issues, which is more than manageable for even a
lean team. While "Sentry Zero" remains the ideal, we achieved and
maintained the real goal of a responsive flow, in large part thanks to
[the Slack integration](https://sentry.io/integrations/slack/). Our
team no longer hears about server errors from our Support team. In
fact, these days, we let them know when a client is having trouble and
we’ve got a ticket underway.

And it really is important to develop close ties with your support
team. Embedded in our strategy above was that CI is much more
sensitive than a real user. While perfection is tempting, it’s not
unrealistic to ask a bit of patience from an enterprise user, provided
your support team is prepared. Sync with them weekly so surprise is
minimized. If they’re feeling ambitious, you can teach them some
Sentry basics, too.

# The New Road

<img width="28%" src="/uploads/tr_img/tachometer.png" align="right"
title="Pedal to the metal.">

With noise virtually eliminated, we were ready to move fast. While the
lean-in on fast-fixing Sentry issues was necessary, a strong reactive
game is only useful if there are proactive changes being
pushed. Here are some highlights we learned when making those changes:

## Committing to transactions

Used properly, rollbacks can make it like errors never happened, the
perfect complement to a fast-fix strategy.

### The truly atomic request

Get as much as possible into the transactions. Turn on
[ATOMIC_REQUESTS](https://docs.djangoproject.com/en/3.1/topics/db/transactions/#tying-transactions-to-http-requests),
if you haven’t already. Some requests do more than change the
database, though, like sending notifications and enqueuing background
tasks.

At SimpleLegal, we rearchitected to defer all side effects (except
logging) until a successful response was being returned. Middleware
can help, but mainly we achieved this by getting rid of our Redis
queue, and switching to a PostgreSQL-backed task queue/broker. This
arrangement ensures that if an error occurs, the transaction is rolled
back, no tasks are enqueued, and the user gets a clean failure. We
spot the breakage in Sentry, toggle over to the old site to unblock,
and their next retry succeeds.

### Transactional test setup

Transactionality also proved key to our testing strategy. SimpleLegal
had long outgrown Django’s primitive fixture system. Most tests
required complex Python to set up, making tests slow to write and slow
to run. To speed up both writing and running, we wrapped the whole
test session in a transaction, then, before any test cases run, we set
up exemplary base states. Test cases used these base states as
[fixtures](https://docs.pytest.org/en/stable/fixture.html), and rolled
back to the base state after every test case. See [this conftest.py
excerpt](https://gist.github.com/mahmoud/10f6b6b0a9c5860030693357124131df)
for details.

## Better than best practices

Software scenarios vary so widely, there’s an art to knowing which
advice isn’t for you. Here’s an assortment of cul de sacs we learned
about firsthand.

### The utility of namespaces

Given how code is divided into modules, packages, Django apps, etc.,
it may be tempting to treat those as units of work. Don’t start
there. Code divisions can be pretty arbitrary, and it’s hard to know
when you’ve pulled on a risky thread.

Assuming there are automated refactorings, as in [a 2to3
conversion](https://portingguide.readthedocs.io/en/latest/), start by
porting by type of transformation. That way, one need only review a
command and a list of paths affected. Plus, automated fixes
necessarily follow a pattern, meaning more people can fix bugs arising
from the refactor.


### Coverage tools

<img width="25%" src="/uploads/tr_img/scantron.png" align="right"
title="Grade those tests carefully.">

Coverage was a mixed bag for us. Obviously our coverage-first strategy
wasn’t tenable, but it was still useful for prioritization and status
checks. On a per-change basis, we found coverage tools to be somewhat
unreliable. We never got to the bottom of why coverage acted
nondeterministically, and we left the conclusion at, “off-the-shelf
tools like codecov are probably not targeted at monorepos of our
scale.”

In running into coverage walls, we ended up exploring many other
interpretations of coverage. For us, much higher-priority than line
coverage were “route coverage” (i.e., every URL has at least one
integration test) and “model repr coverage” (i.e., every model object
had a useful text representation, useful for debugging in
Sentry). With more time, we would have liked to build tools around
those, and even around online-profiling based coverage statistics, to
prioritize the highest traffic lines, not just the highest traffic
routes. If you’ve heard of approaches to these ends, we’d love to
discuss them with you.

### Flattening database migrations

On the surface, reducing the number of files we needed to upgrade
seems logical. Turns out, flattening
[migrations](https://docs.djangoproject.com/en/3.1/topics/migrations/)
is a low-payoff strategy to get rid of files. Changing historical
migration file structure complicated our rollout, while upgrading
migrations we didn’t flatten was straightforward. Not to mention, if
you just wanted the CI speedup, you can take the same page from [the
Open EdX
Platform](https://openedx.atlassian.net/wiki/spaces/AC/pages/23003228/Everything+About+Database+Migrations#EverythingAboutDatabaseMigrations-SquashingMigrations)
that we did: [build a base DB cache that you check in every couple
months](https://github.com/edx/edx-platform/blob/66f0f9891f00994f77604a51dbb29736aa605fa8/scripts/reset-test-db.sh#L75).

Turns out, [you can learn a lot from open-source
applications](https://sedimental.org/awesome_python_applications.html#goal-1-a-better-development-cycle).

## Easing onto the stack

If you have more than one application, use the smaller, simpler
application to pilot changes. We were lucky enough to have a separate
app whose tests ran faster, making for a tighter development loop we
coul learn from. Likewise, if you have more than one production
environment, start rollouts with the one with the least impact.

Clone your CI jobs for the new stack, too. They’ll all fail, but
resist the urge to mark them as optional. Instead, build a single-file
inventory of all tests and their current testing state. We built a
small extension for our test runner,
[pytest](https://docs.pytest.org/en/stable/), which bulk skipped tests
based on a status inventory file. Then, ratchet: unskip and fix a
test, update the file, check that tests pass, and repeat. Much more
convenient and scannable than [pytest
mark](https://docs.pytest.org/en/latest/skipping.html#skipping-test-functions)
decorators spread throughout the codebase. See [this conftest.py
excerpt](https://gist.github.com/mahmoud/10f6b6b0a9c5860030693357124131df)
for details.

# The Rollout


In Q4 2020, we doubled up on infrastructure to run the old and new
sites in parallel, backed by the same database. We got into a loop of
enabling traffic to the new stack, building a queue of Sentry issues
to fix, and switching it back off, while tracking the time. After
around 120 hours of new stack, strategically spread around the clock
and week, enough organizational confidence had been built that we
could leave the site on during our most critical hours: Mondays and
Tuesdays at the beginning of the month.

The sole hiccup was [an AWS
outage](https://www.zdnet.com/article/aws-outage-impacts-thousands-of-online-services/)
Thanksgiving week. At this point we were ahead of schedule, and enough
confidence had been built in our fast-fix workflow that we didn’t need
our original holiday testing windows. And for that, mmany thanks were given.

We kept at the fast-fix crank until we were done. Done isn't when the
new system has no errors, it's when traffic on the new system has
fewer events than the old system. Then, fix forward, and start
scheduling time to delete the scaffolding.

<img width="60%" src="/uploads/tr_img/baton.png"
title="Finally, that tired old stack can rest.">

# The Aftermath

So, once you’re on current LTS versions of Django, Python, Linux, and
Postgres, job complete, right?

Thankfully, tech debt never quite hits 0. While updating and replacing
core technologies on a schedule is no small feat, replacing a rusty
part with a shiny one doesn’t change a design. Architectural tech debt
-- mistakes in abstractions, including the lack thereof -- can present
an even greater challenge. Solutions to those problems don’t
generalize between projects as cleanly, but they do benefit from
up-to-date and error-free foundations.

For all the projects looking to add tread to their technical tires, we
hope this retrospective helps you confidently and pragmatically
retrofit your stack for years to come.

Finally, big thanks to [Uvik](https://uvik.net/) for the talent
connection, and the talent: [Yaroslav](https://github.com/ypankovych),
[Serhii](https://github.com/skhortiuk), and Oleh. Shoutouts to
[Kurt](https://github.com/kurtbrose/),
[Justin](https://github.com/justinvanwinkle), and Chris, my fellow
leads. And the cheers to business leadership at SimpleLegal and
everywhere, for seeing the value in maintainability.
