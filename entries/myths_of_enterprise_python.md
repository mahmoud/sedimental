---
title: 10 Myths of Enterprise Python
publish_date: August 25, 2015
tags:
  - code
  - work
  - python
edits:
  - ['2015-08-25', 'Retired eBay Now link and swapped Balanced link for Venmo']
---

*(Originally posted [on the PayPal Engineering blog][orig_post], reproduced here
 with minor updates, link fixes, etc.)*

[orig_post]: https://www.paypal-engineering.com/2014/12/10/10-myths-of-enterprise-python/

PayPal enjoys a remarkable amount of linguistic pluralism in its
programming culture. In addition to the long-standing popularity of C++
and Java, an increasing number of teams are choosing JavaScript and
Scala, and [Braintree][braintree]'s acquisition has introduced a
sophisticated Ruby community.

One language in particular has both a long history at eBay and PayPal
and a growing mindshare among developers: [Python][python].

Python has enjoyed many years of grassroots usage and support from
developers across eBay. Even before official support from management,
technologists of all walks went the extra mile to reap the rewards of
developing in Python. I joined PayPal a few years ago, and chose
Python to work on internal applications, but I've personally found
production PayPal Python code from nearly **15 years ago**.

Today, Python powers **over 50 projects**, including:

  * **Features and products**, such as **eBay Now** and [RedLaser][redlaser]
  * **Operations and infrastructure**, both [OpenStack][openstack] and proprietary
  * **Mid-tier services and applications**, like the one used to set
    PayPal's prices and check customer feature eligibility
  * **Monitoring agents and interfaces**, used for several deployment and
    security use cases
  * **Batch jobs for data import**, price adjustment, and more
  * And far too many developer tools to count

In the coming series of posts I'll detail the initiatives and
technologies that led the eBay/PayPal Python community to grow from
just under 25 engineers in 2011 to **over 260** in 2014. For this
introductory post, I'll be focusing on the 10 myths I've had to
debunk the most in eBay and PayPal's enterprise environments.

[braintree]: https://www.braintreepayments.com/
[python]: https://www.python.org/
[ebay_local]: http://www.ebay.com/lcl/
[redlaser]: http://redlaser.com/
[openstack]: http://www.openstack.org/


<a name="#myth-1"></a>
## <a href="#python-is-new" name="python-is-new">Myth #1</a>: Python is a new language

What with all the startups using it and [kids learning it
these days][python_kids], it's easy to see how this myth still
persists. Python is actually [over 23 years old][python_history_wp],
originally released in 1991, 4 years before Java. A now-famous early
usage of Python was in 1996: [Google's first successful web
crawler][google_crawler].

If you're curious about the long history of Python, [Guido van Rossum][guido_wp],
Python's creator, [has taken the care to tell the whole
story][python_history].

[python_history_wp]: https://en.wikipedia.org/wiki/Python_(programming_language)#History
[google_crawler]: https://news.ycombinator.com/item?id=8587697
[guido_wp]: https://en.wikipedia.org/wiki/Guido_van_Rossum
[python_history]: http://python-history.blogspot.com/2009/01/introduction-and-overview.html


<a name="myth-2"></a>
## <a href="#python-is-not-compiled" name="python-is-not-compiled">Myth #2</a>: Python is not compiled

While not requiring a separate compiler toolchain like C++, Python is
in fact compiled to bytecode, much like Java and many other compiled
languages. Further compilation steps, if any, are at the discretion of
the runtime, be it CPython, PyPy, Jython/JVM, IronPython/CLR, or some
other process virtual machine. See [Myth #6](#myth-6) for more info.

The general principle at PayPal and elsewhere is that the compilation
status of code should not be relied on for security. It is much more
important to secure the runtime environment, as virtually every
language [has][python_dis] [a][c_decompiler]
[decompiler][java_decompiler], or [can][python_intercept]
[be][c_intercept] [intercepted][java_intercept] to dump protected
state. See the next myth for even more Python security implications.

[python_dis]: https://docs.python.org/2/library/dis.html
[c_decompiler]: http://boomerang.sourceforge.net/
[java_decompiler]: http://jd.benow.ca/
[python_intercept]: https://docs.python.org/2/library/site.html
[c_intercept]: http://www.opensourceforu.com/2011/08/lets-hook-a-library-function/
[java_intercept]: http://docs.oracle.com/javase/6/docs/api/java/lang/instrument/Instrumentation.html


<a name="myth-3"></a>
## <a href="#python-is-not-secure" name="python-is-not-secure">Myth #3</a>: Python is not secure

Python's affinity for the lightweight may not make it seem formidable,
but the intuition here can be misleading. One central tenet of
security is to present as small a target as possible. Big systems are
anti-secure, as they tend to [overly centralize
behaviors][jwz_tk_security], as well as [undercut developer
comprehension][schneier_simplicity]. Python keeps these demons at bay
by encouraging simplicity. Furthermore, [CPython][cypython] addresses
these issues by being a simple, stable, and easily-auditable virtual
machine. In fact, a recent analysis by [Coverity] Software [resulted
in CPython receiving their highest quality rating][coverity_python].

Python also features an extensive array of open-source,
industry-standard security libraries. At PayPal, where we take
security and trust very seriously, we find that a combination of
[hashlib][hashlib], [PyCrypto][pycrypto], and [OpenSSL][openssl], via
[PyOpenSSL][pyopenssl] and our own custom bindings, cover all of
PayPal's diverse security and performance needs.

For these reasons and more, Python has seen some of its fastest
adoption at PayPal (and eBay) within the application security
group. Here are just a few security-based applications utilizing
Python for PayPal's security-first environment:

  * Creating security agents for facilitating key rotation and
    consolidating cryptographic implementations
  * Integrating with industry-leading
    <acronym title="Hardware Security Module">[HSM][hsm]</acronym> technologies
  * Constructing TLS-secured wrapper proxies for less-compliant stacks
  * Generating keys and certificates for our internal mutual-authentication schemes
  * Developing active vulnerability scanners

Plus, myriad Python-built operations-oriented systems with security
implications, such as firewall and connection management. In the
future we'll definitely try to put together a deep dive on PayPal
Python security particulars.

[openssl]: https://www.openssl.org/
[jwz_tk_security]: http://www.jwz.org/xscreensaver/toolkits.html
[schneier_simplicity]: https://www.schneier.com/essays/archives/1999/11/a_plea_for_simplicit.html
[coverity]: http://www.coverity.com/why-coverity/
[coverity_python]: http://www.coverity.com/press-releases/coverity-finds-python-sets-new-level-of-quality-for-open-source-software/
[pyopenssl]: https://github.com/pyca/pyopenssl
[pycrypto]: https://github.com/dlitz/pycrypto
[hashlib]: https://docs.python.org/2/library/hashlib.html
[hsm]: https://en.wikipedia.org/wiki/Hardware_security_module


<a name="myth-4"></a>
## <a href="#python-is-for-scripting" name="python-is-for-scripting">Myth #4</a>: Python is a scripting language

Python can indeed be used for scripting, and is one of the forerunners
of the domain due to its simple syntax, cross-platform support, and
ubiquity among Linux, Macs, and other Unix machines.

In fact, Python may be one of the most flexible technologies among
general-use programming languages. To list just a few:

  1. Telephony infrastructure ([Twilio][twilio])
  2. Payments systems ([PayPal][paypal], [Venmo](venmo))
  3. Neuroscience and psychology ([citation][neuroscience])
  4. Numerical analysis and engineering ([numpy][numpy], [numba][numba], and [many more][numerical])
  5. Animation ([LucasArts][lucasarts], [Disney][disneytech], [Dreamworks][dreamworks])
  6. Gaming backends ([Eve Online][eve_online], [Second Life][second_life], [Battlefield][battlefield], and [so many others][other_games])
  7. Email infrastructure ([Mailman][mailman], [Mailgun][mailgun])
  8. Media storage and processing ([YouTube][youtube], [Instagram][instagram], [Dropbox][dropboxtech])
  9. Operations and systems management ([Rackspace][rackspace], [OpenStack][openstack])
  10. Natural language processing ([NLTK][nltk])
  11. Machine learning and computer vision ([scikit-learn][scikit], [Orange][orange], [SimpleCV][simplecv])
  12. Security and penetration testing ([so many][pentest])
  13. Big Data ([Disco][disco], [Hadoop support][hadoop])
  14. Internet infrastructure (DNS) ([BIND 10][bind10])

Not to mention websites and web services aplenty. In fact, PayPal
engineers seem to have a penchant for going on to start Python-based
web properties. [YouTube][youtube] and [Yelp][yelp], for instance.

[twilio]: https://en.wikipedia.org/wiki/Twilio
[neuroscience]: http://www.frontiersin.org/neuroinformatics/researchtopics/Python_in_neuroscience/8
[paypal]: https://en.wikipedia.org/wiki/PayPal
[balanced]: https://www.balancedpayments.com/
[numpy]: https://en.wikipedia.org/wiki/NumPy
[numba]: http://numba.pydata.org/
[numerical]: https://wiki.python.org/moin/NumericAndScientific
[lucasarts]: https://en.wikipedia.org/wiki/LucasArts
[disneytech]: http://www.disneyanimation.com/technology/opensource
[dreamworks]: https://en.wikipedia.org/wiki/DreamWorks_Animation
[eve_online]: https://en.wikipedia.org/wiki/Eve_Online
[second_life]: https://en.wikipedia.org/wiki/Second_Life
[battlefield]: https://en.wikipedia.org/wiki/Battlefield_(series)
[other_games]: https://wiki.python.org/moin/PythonGames
[mailman]: https://en.wikipedia.org/wiki/GNU_Mailman
[mailgun]: http://www.rackspace.com/mailgun
[youtube]: https://en.wikipedia.org/wiki/YouTube
[instagram]: http://instagram-engineering.tumblr.com/post/13649370142/what-powers-instagram-hundreds-of-instances
[dropboxtech]: https://tech.dropbox.com/
[rackspace]: https://en.wikipedia.org/wiki/Rackspace
[nltk]: http://www.nltk.org/
[scikit]: http://scikit-learn.org/stable/
[orange]: http://orange.biolab.si/
[simplecv]: http://simplecv.org/
[pentest]: https://github.com/dloss/python-pentest-tools
[bind10]: http://www.isc.org/blogs/programming-languages-for-bind-10/
[disco]: http://discoproject.org/
[hadoop]: http://blog.cloudera.com/blog/2013/01/a-guide-to-python-frameworks-for-hadoop/
[yelp]: http://yelp.com


<a name="myth-5"></a>
## <a href="#python-is-weakly-typed" name="python-is-weakly-typed">Myth #5</a>: Python is weakly-typed

Python's type system is characterized by strong, dynamic
typing. [Wikipedia can explain more][type_systems].

Not that it is a competition, but as a fun fact, Python is more
strongly-typed than Java. Java has a split type system for primitives
and objects, with ``null`` lying in a sort of gray area. On the other
hand, modern Python has a unified strong type system, where the type
of ``None`` is well-specified. Furthermore, the JVM itself is also
dynamically-typed, as it [traces its roots back][jvm_history] to an
implemention of a Smalltalk VM acquired by Sun.

[Python's type system][python_data_model] is very nice, but for
enterprise use there are much bigger concerns at hand.

[type_systems]: https://en.wikipedia.org/wiki/Type_system
[jvm_history]: https://en.wikipedia.org/wiki/HotSpot#History
[python_data_model]: https://docs.python.org/2/reference/datamodel.html


<a name="myth-6"></a>
## <a href="#python-is-slow" name="python-is-slow">Myth #6</a>: Python is slow

First, a critical distinction: Python is a programming language, not a
runtime. There are several Python implementations:

  1. [**CPython**][cpython] is the reference implementation, and also the most widely
     distributed and used.
  2. [**Jython**][jython] is a mature implementation of Python for usage with the JVM.
  3. [**IronPython**][ironpython] is Microsoft's Python for the Common Language Runtime, aka .NET.
  4. [**PyPy**][pypy] is an up-and-coming implementation of Python, with advanced
     features such as JIT compilation, incremental garbage collection,
     and more.

Each runtime has its own performance characteristics, and none of them
are slow per se. The more important point here is that it is a mistake
to assign performance assessments to a programming languages. Always
assess an application runtime, most preferably against a particular
use case.

Having cleared that up, here is a small selection of cases where
Python has offered significant performance advantages:

  1. Using [NumPy][numpy] as [an interface to Intel's MKL SIMD][intel_mkl]
  2. [PyPy][pypy]'s JIT compilation [achieves faster-than-C performance][pypy_c]
  3. [Disqus][disqus] scales from [250 to 500 million users on the same 100 boxes][disqus_scale]

Admittedly these are not the newest examples, just my favorites.  It
would be easy to get side-tracked into the wide world of
high-performance Python and the unique offerings of runtimes. Instead
of addressing individual special cases, attention should be drawn to
the generalizable impact of developer productivity on end-product
performance, especially in an enterprise setting.

Given enough time, a disciplined developer can execute the only proven
approach to achieving accurate and performant software:

  1. **Engineer** for correct behavior, including the development of respective tests
  2. **Profile** and measure performance, identifying bottlenecks
  3. **Optimize**, paying proper respect to the test suite and [Amdahl's Law][amdahls],
  and taking advantage of Python's strong roots in C.

It might sound simple, but even for seasoned engineers, this can be a
very time-consuming process. Python was designed from the ground up
with developer timelines in mind. In our experience, it's not uncommon
for Python projects to undergo three or more iterations in the time it
C++ and Java to do just one. Today, PayPal and eBay have seen multiple
success stories wherein Python projects outperformed their C++ and
Java counterparts, all thanks to fast development times enabling
careful tailoring and optimization. You know, the fun stuff.

[cpython]: https://en.wikipedia.org/wiki/CPython
[jython]: https://en.wikipedia.org/wiki/Jython
[ironpython]: https://en.wikipedia.org/wiki/IronPython
[pypy]: https://en.wikipedia.org/wiki/PyPy
[pypy]: http://pypy.org/
[pypy_c]: http://morepypy.blogspot.com/2011/08/pypy-is-faster-than-c-again-string.html
[disqus]: https://disqus.com/
[disqus_scale]: http://www.slideshare.net/zeeg/pycon-2011-scaling-disqus-7251315
[intel_mkl]: https://software.intel.com/en-us/articles/numpyscipy-with-intel-mkl
[amdahls]: https://en.wikipedia.org/wiki/Amdahl%27s_law


<a name="myth-7"></a>
## <a href="python-does-not-scale" name="python-does-not-scale">Myth #7</a>: Python does not scale

Scale has many definitions, but by any definition, [YouTube is a web
site at scale][youtube_scale]. More than 1 billion unique visitors per
month, over 100 hours of uploaded video per minute, and going on 20%
of peak Internet bandwidth, all with Python as a core
technology. [Dropbox][dropbox_scale], [Disqus][disqus_scale],
[Eventbrite][eventbrite_scale], [Reddit][reddit_scale],
[Twilio][twilio_scale], [Instagram][instagram_scale],
[Yelp][yelp_scale], [EVE Online][eve_scale], [Second
Life][second_life_scale], and, yes, eBay and PayPal all have Python
scaling stories that prove scale is more than just possible: it's a
pattern.

The key to success is simplicity and consistency. CPython, the primary
Python virtual machine, maximizes these characteristics, which in turn
makes for a very predictable runtime. One would be hard pressed to
find Python programmers concerned about garbage collection pauses or
application startup time. With strong platform and networking support,
Python naturally lends itself to smart horizontal scalability, as
manifested in systems like [BitTorrent][bittorrent].

Additionally, scaling is all about measurement and iteration. Python
is built with [profiling][profilers] and optimization in mind. See
[Myth #6](#myth-6) for more details on how to vertically scale Python.

[dropbox_scale]: http://techcrunch.com/2013/07/11/how-did-dropbox-scale-to-175m-users-a-former-engineer-details-the-early-days/
[youtube_scale]: https://www.youtube.com/yt/press/statistics.html
[disqus_scale]: http://blog.disqus.com/post/62187806135/scaling-django-to-8-billion-page-views
[eventbrite_scale]: http://www.infoworld.com/article/2608078/application-development/expert-interview--how-to-scale-django.html
[reddit_scale]: http://highscalability.com/blog/2013/8/26/reddit-lessons-learned-from-mistakes-made-scaling-to-1-billi.html
[twilio_scale]: http://www.slideshare.net/twilio/asynchronous-architectures-for-implementing-scalable-cloud-services-evan-cooke-gluecon-2012
[instagram_scale]: http://www.slideshare.net/twilio/asynchronous-architectures-for-implementing-scalable-cloud-services-evan-cooke-gluecon-2012
[yelp_scale]: http://www.slideshare.net/YelpEngineering/scale-presentation-michael-stoppelman-oct-2014
[eve_scale]: http://highscalability.com/eve-online-architecture
[second_life_scale]: http://highscalability.com/second-life-architecture-grid
[bittorrent]: http://bittorrent.cvs.sourceforge.net/viewvc/bittorrent/BitTorrent/
[profilers]: https://docs.python.org/2/library/profile.html


<a name="myth-8"></a>
## <a href="#python-lacks-concurrency" name="python-lacks-concurrency">Myth #8</a>: Python lacks good concurrency support

Occasionally debunking [performance](#myth-6) and [scaling](myth-7)
myths, and someone tries to get technical, "Python lacks concurrency,"
or, "What about the GIL?" If dozens of counterexamples are
insufficient to bolster one's confidence in Python's ability to scale
vertically and horizontally, then an extended explanation of a
[CPython][cpython] implementation detail probably won't help, so I'll
keep it brief.

Python has great concurrency primitives, including
[generators][gen_concurrency], [greenlets][greenlet],
[Deferreds][deferred], and [futures][futures]. Python has great
concurrency frameworks, including [eventlet][eventlet],
[gevent][gevent], and [Twisted][twisted]. Python has had some amazing
work put into customizing runtimes for concurrency, including
[Stackless][stackless] and [PyPy][pypy]. All of these and more show
that there is no shortage of engineers effectively and
unapologetically using Python for concurrent programming. Also, all of
these are officially support and/or used in enterprise-level
production environments. For examples, refer to [Myth #7](#myth-7).

The Global Interpreter Lock, or GIL, is a performance optimization for
most use cases of Python, and a development ease optimization for
virtually all CPython code. The GIL makes it much easier to use OS
threads or [green threads][greenthreads] (greenlets usually), and does
not affect using multiple processes. For more information, [see this
great Q&A on the topic][why_gil] and [this overview from the Python
docs][conc_overview].

Here at PayPal, a typical service deployment entails multiple
machines, with multiple processes, multiple threads, and a very large
number of greenlets, amounting to a very robust and scalable
concurrent environment. In most enterprise environments, parties tends
to prefer a fairly high degree of overprovisioning, for general
prudence and disaster recovery. Nevertheless, in some cases Python services
still see millions of requests per machine per day, handled with ease.

[gen_conc]: http://www.slideshare.net/dabeaz/an-introduction-to-python-concurrency
[greenlet]: https://greenlet.readthedocs.org/en/latest/
[deferred]: https://twistedmatrix.com/documents/14.0.0/core/howto/defer.html
[futures]: http://pythonhosted.org/futures/
[eventlet]: http://eventlet.net/
[gevent]: http://www.gevent.org/
[greenthreads]: https://en.wikipedia.org/wiki/Green_threads
[twisted]: https://twistedmatrix.com/trac/
[stackless]: http://www.stackless.com/

[why_gil]: http://programmers.stackexchange.com/questions/186889/why-was-python-written-with-the-gil
[conc_overview]: https://docs.python.org/3/library/concurrency.html


<a name="myth-9"></a>
## <a href="#python-programmers-scarce" name="python-programmers-scarce">Myth #9</a>: Python programmers are scarce

There is some truth to this myth. There are not as many Python web
developers as PHP or Java web developers. This is probably mostly due
to a combined interaction of industry demand and education, though
[trends in education suggest that this may change][python_education].

That said, Python developers are far from scarce. There are millions
worldwide, as evidenced by the dozens of Python conferences, tens of
thousands of StackOverflow questions, and companies like YouTube, Bank
of America, and LucasArts/Dreamworks employing Python developers by
the hundreds and thousands. At eBay and PayPal we have hundreds of
developers who use Python on a regular basis, so what's the trick?

Well, why scavenge when one can create? Python is exceptionally easy
to learn, and is a first programming language [for
children][python_kids], [university students][python_university], and
[professionals][python_google_class] alike. At eBay, it only takes one
week to show real results for a new Python programmer, and they often
really start to shine as quickly as 2-3 months, all made possible by
the Internet's rich cache of interactive tutorials, books,
documentation, and open-source codebases.

Another important factor to consider is that projects using Python
simply do not require as many developers as other projects. As
mentioned in Myth #7, lean, effective teams like Instagram are a
common trope in Python projects, and this has certainly been our
experience at eBay and PayPal.

[python_education]: http://cacm.acm.org/blogs/blog-cacm/176450-python-is-now-the-most-popular-introductory-teaching-language-at-top-us-universities/fulltext
[python_university]: http://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-189-a-gentle-introduction-to-programming-using-python-january-iap-2011/
[python_kids]: http://www.nostarch.com/pythonforkids
[python_google_class]: https://developers.google.com/edu/python/?csw=1


<a name="myth-10"></a>
## <a href="#python-not-for-big-projects" name="python-not-for-big-projects">Myth #10</a>: Python is not for big projects

[Myth #7](#myth-7) discussed running Python projects at scale, but
what about *developing* Python projects at scale? As mentioned in
[Myth #9](#myth-9), most Python projects tend not to be
people-hungry. while Instagram reached hundreds of millions of hits a
day at the time of their [billion dollar acquisition][instagram_acq],
the whole company was [still only a group of a dozen or so
people][instagram]. Dropbox in 2011 [only had 70
engineers][dropbox_lean], and other teams were similarly lean. So, can
Python scale to large teams?

Bank of America actually has [over 5,000 Python
developers, with over 10 million lines of Python in one
project alone][bofa_scale]. JP Morgan underwent [a similar
transformation][jpmorgan_scale]. YouTube also has engineers in the
thousands and lines of code [in the millions][youtube_hiscale]. Big
products and big teams use Python every day, and while it has excellent
modularity and packaging characteristics, beyond a certain point
much of the general development scaling advice stays the same.
Tooling, strong conventions, and code review are what make big
projects a manageable reality.

Luckily, Python starts with a good baseline on those fronts as
well. We use [PyFlakes][pyflakes] and [other tools][flake8] to perform
static analysis of Python code before it gets checked in, as well as
adhering to [PEP8][pep8], Python's language-wide base style guide.

Finally, it should be noted that, in addition to the scheduling
speedups mentioned in [Myth #6](#myth-6) and [#7](#myth-7), projects
using Python generally require fewer developers, as well. Our most
common success story starts with a Java or C++ project slated to take
a team of 3-5 developers somewhere between 2-6 *months*, and ends with
a single motivated developer completing the project in 2-6
**weeks**. It's not unheard of for some projects to take hours instead
of weeks, as well.

A miracle for some, but a fact of modern development, and often a
necessity for a competitive business.

[instagram_acq]: http://www.slate.com/blogs/business_insider/2013/11/14/facebook_s_1_billion_instagram_buy_did_kevin_systrom_sell_too_soon.html
[youtube_hiscale]: http://highscalability.com/blog/2012/3/26/7-years-of-youtube-scalability-lessons-in-30-minutes.html
[bofa_scale]: http://news.efinancialcareers.com/us-en/173476/investment-banking-tech-guru-quits-starts-firm/
[jpmorgan_scale]: http://www.quora.com/When-why-and-to-what-extent-did-Bank-of-America-rebuild-its-entire-tech-stack-with-Python
[dropbox_lean]: http://www.forbes.com/sites/victoriabarret/2011/10/18/dropbox-the-inside-story-of-techs-hottest-startup/
[pep8]: https://www.python.org/dev/peps/pep-0008/
[pyflakes]: https://github.com/pyflakes/pyflakes/
[flake8]: https://pypi.python.org/pypi/flake8

## A clean slate

Mythology can be a fun pastime. Discussions around these myths remain
some of the most active and educational, both internally and
externally, because implied in every myth is a recognition of Python's
strengths. Also, remember that the appearance of these seemingly tedious
and troublesome concerns is a sign of steadily growing interest, and
with steady influx of interested parties comes the constant job of
education.  Here's hoping that this post manages to extinguish a flame
war and enable a project or two to talk about the real work that can
be achieved with Python.

Keep an eye out for future posts where I'll dive deeper into the
details touched on in this overview. If you absolutely must have
details before then, shoot me an email at mahmoud@paypal.com. Until
then, happy coding!
