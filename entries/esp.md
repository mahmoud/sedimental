---
title: Enterprise Software with Python
entry_root: esp
tags:
  - python
  - work
  - code
  - education
  - esp
publish_date: 4:04AM March 22, 2016

---

When I first published [10 Myths of Enterprise Python][10moep] on
[the PayPal Engineering blog][10moep_pp], there were a lot of
reactions. Some I expected:

<img width="40%" align="right" src="/uploads/illo/ncc_1701d_med.png"
title="The NCC-1701D, one of many illustrations from Enterprise
Software with Python">

1. [Surprise](https://twitter.com/michahell/status/544109301401661440) at Python in the enterprise space.
2. [Relief](https://twitter.com/jpheasly/status/543882786419908611) at more attestation of Python's use in the enterprise.
3. And, as with all the best, [a few flamewars](https://news.ycombinator.com/item?id=9256082).

[10moep]: /10_myths_of_enterprise_python.html
[10moep_pp]: https://www.paypal-engineering.com/2014/12/10/10-myths-of-enterprise-python/

But there was one I missed: new developers interested in professional
software development.

Really I should have seen it coming. For the better part of a decade,
Python has provided me the best vocabulary for answering questions
from motivated individuals looking for programming productivity.  It's
only logical that once they got the basics down, they'd want to take
it to the next level.

With this end in mind, I'm pleased to announce
**[Enterprise Software with Python][esp]** (ESP), a bridging class
from beginner to pro[^1], brought to you by
[O'Reilly Media](http://www.oreilly.com/) and yours truly.

It's got something for everyone, but really it's designed with three
groups in mind:

[^1]: This link has a 50% off coupon code, applied at checkout. Check
      if your organization has Safari, first. If not, use
      [this coupon-less link][esp_nocoup] and expense it! :) Safari
      users, try [Techbus][tbs] or [the SBO site][sbo]. If you're not
      sure if you have Safari access, contact your technology
      education and training department.

* **Recently-graduated and self-taught developers**, looking for a holistic
  introduction to enterprise software.
* **Experienced developers at large organizations**, looking for a relatable
  orientation to Python industry standards.
* **Technical team leaders with priorities**, looking to quickly get
  groups on the same page of vocabulary, expectations, and practice.[^4me]

[^4me]: This target audience is me, but I know there are others out
        there. *Send me your tiring, huddled masses yearning to learn
        Python.* Seriously though, I can't fully quantify how much
        time it saves me to send a new Python initiate to a video,
        then have them come back with the foundations necessary to
        have a productive conversation.

As the title suggests, ESP is more than a Python class. While the
perspective is Pythonic and there are several examples in Python, this
is a full software development course. You will find a serious effort
has been made to set expectations and develop the soft skills large
organizations demand. You need architectural skills to form a
technical opinion, engineering skills to implement and maintain it,
and managerial skills to defend it all along the way. I can't resist a
good table of contents, so this is how the course is factored to
address all of these:

1. **Introductions and definitions** - A bit about me, a bunch about the course.
    1. [Overview][samp_overview]
    2. [Prerequisites and viewing guide][samp_prereqs]
2. **Definitions and foundations** - Know your domain, know your platform.
    1. [What is Enterprise Software?][samp_es] - 9 Hallmarks of the Enterprise
    2. What is Python? 3 Perspectives for the Organization
    3. What is Python *Not*? 4 Common Misconceptions
    4. When to Use Python? Motivations and Applications
3. **Architecture and design** - Do your research, present your findings.
    1. Designing Architectures: Professional Planning
    2. Gathering Requirements: Understanding the 6 Aspects of Software
    3. Researching Environments: From Production to Development
    4. Choosing Dependencies: Evaluating Building Blocks
    5. Getting Assistance: Finding Help in the Software World
    6. Presenting Designs: Navigating the Organizational and Interpersonal
4. **Engineering practices** - Execution and delivery with minimal regret.
    1. Development Environments: Editors and Dev Tools
    2. Source Control, Issue Tracking, and Continuous Integration
    3. Workflow: Starting a Python Project
    4. Design Patterns: Idioms for Python Projects
    5. Debugging: Solving Problems in Python projects
    6. Security: Software Risk Management Fundamentals
    7. Code Review: Python Antipatterns and Collaboration
    8. Testing: Practical Python Quality Engineering
    9. Logging and Monitoring: Introspectable Python Projects
    10. Profiling and Performance: Strategies for High-Speed Python
    11. Documentation: Preserving the Legacy
    12. Packaging and Deployment: Going Live
5. **Career development and further study** - A good end offers a dozen new beginnings.
    1. Project Ideas: Building Experience
    2. Technology Evangelism: Building a Community
    3. Other Resources: Building Skills
    4. Closing

[samp_overview]: http://player.oreilly.com/videos/9781491943755?toc_id=239870
[samp_prereqs]: http://player.oreilly.com/videos/9781491943755?toc_id=239871
[samp_es]: http://player.oreilly.com/videos/9781491943755?toc_id=239872

Yes, it is a lot. I never pass on an opportunity to give a
comprehensive treatment, but I'll save the whole motivation and process
essay for later. For now, keep in mind that most segments are under 20
minutes, and the longest, *Profiling and Performance*, is only 45
minutes — shorter than most orgs' tech talks. It's all compact and
practical, right down to [the example repo][espymetrics].

<center>
<a href="http://shop.oreilly.com/product/0636920047346.do?code=authd">
<img width="70%" src="/uploads/esp_01.jpg">
</a><br/>
*Actual footage from the intro. Not a prerelease render.*
</center>

The first three parts are free, and will give you a good sense of the
format, tone, and content. I kept it pretty light and approachable,
complete with dozens of illustrations. Purchasers can stream the rest,
and download DRM-free copies whenever you want (my personal
favorite). If you have any questions or concerns, don't hesitate to
reach out [to me][tw_me], [personally][about], or
[O'Reilly Media][tw_orm].

[tw_me]: https://twitter.com/mhashemi
[about]: http://sedimental.org/about.html
[tw_orm]: https://twitter.com/OReillyMedia

[I hope you'll take a look][esp]! It's already making waves at PayPal,
and chances are there's someone you know who could use it, too.

[esp]: http://shop.oreilly.com/product/0636920047346.do?code=authd
[esp_nocoup]: http://shop.oreilly.com/product/0636920047346.do

[tbs]: http://techbus.safaribooksonline.com/video/programming/python/9781491943755
[sbo]: https://www.safaribooksonline.com/library/view/enterprise-software-with/9781491943755/

[espymetrics]: https://github.com/mahmoud/espymetrics/

<!--

Various primary-source clippings I wrote related to the class. Don't
mind these.

I've found even many experienced developers have a lot of skill gaps
that leech at their development confidence and effectiveness in a
corporate setting. This course seeks to address that.

I'm exactly designing it to be an enterprise followup to courses like
Jess's. The largest contingent of Python programmers I've worked with
are those who know the basics of Python as a programming language, but
don't know how to apply it day-to-day. Enterprise is indeed about
scaling, but much more about scaling development than scaling
performance (though I intend to cover both).

This will appeal to all developers looking to turn professional with
Python. Most instructive programming videos don't cover the
expectations and best practices used within companies. Examples would
be when and how to add tests, automation, source control,
etc. Enterprise development is all about meetings, priorities,
budgets, and compromises, and reaching scale is a matter of earning
trust and proving approaches.

As for the topic feedback, I wholeheartedly agree. Enterprise
development is all about risk management, so my #1 priority is
avoiding failure. If new developers fail, they may blame Python, or
worse, their managers might blame them (and Python)! The TL;DR on my
opinion of when _not_ to use Python is for web frontend development,
and possibly for mobile (Kivy is really coming along,
though). Python's web frontend offerings would be very hard for a new
developer to sell against JavaScript unfortunately.

My overarching message of when to use Python is one of positivity: we
have used Python for positively everything, high performance, high
reliability, high security, high accuracy (i.e., data science), you
name it. There'll be a bit about Python 2 and 3, too. It's a key
architectural decision, after all. :)

## Description

What's makes the difference between a casual coder and a professional
software engineer? How do beginner Pythonists become intermediate
developers?

One part masterclass, one part crash course, Enterprise Software with
Python answers this question by touching on every element of the
enterprise software development. PayPal's Lead Developer of Python
Infrastructure Mahmoud Hashemi busts myths and offers guidance, using
Python to demonstrate standard patterns and practices that apply
across the software industry.

Python is renowned for making it easy to get started with programming,
but a lot of Python programmers are set adrift after learning the
language basics. Enterprise Software with Python gives you an
insider's introduction to:

    Defining software and software requirements for professional practice
    Fortifying your corporate environments with the power of open source
    Implementing, debugging, and reviewing project implementations
    Measuring, optimizing, and scaling applications at the enterprise level
    Preventing availability and security disasters with simple, practical changes
    Testing and documenting codebases for long-term maintenance
    Packaging and deploying optimally within your organization
    Winning autonomy by earning the confidence of your management and teammates

Whether you are currently at a large organization, hope to work in the
enterprise, or are just looking to further develop your skills,
Enterprise Software with Python will help you take your craft to the
next level.

## Proposal

### Who is this for?

Budding Python developers looking to turn pro. Beginners who know the
language and need direction in applying it in an organization.

### How does this help solve a problem or group of problems?

Python itself is very easy to learn in a hobby or academic setting,
but a lot of Python developers are set adrift after learning the
language. If they’re lucky they have some professional development
experience in other languages, but even then many of the paradigms
don’t translate well. Scaling, both development practices and
application architectures, is specific to every language. Illuminating
that dark art starts with teaching best practices that move a beginner
Pythonist to an intermediate Python engineer.

-->
