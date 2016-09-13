---
title: Python Packaging at PayPal
---

<!-- An Enterprise Python Packaging Story. Or, how I can finally stop
caring and love Anaconda. -->

<img src="/uploads/illo/snake_box_sm.png" align="right" width=300/>

Year after year, Pythonists all over are churning out more code than
ever. People are learning, the ecosystem is flourishing, and
everything is running smoothly, right up until packaging. Packaging
Python is fundamentally un-Pythonic. It can be a tough lesson to
learn, but across all environments and applications, there is no one
obvious, right way to deploy. Frankly, it's hard to think of an area
where [Python's Zen][zop] applies less.

[toowtdi]: https://wiki.python.org/moin/TOOWTDI
[zop]: https://www.python.org/dev/peps/pep-0020/

At PayPal, we write and deploy our fair share of Python, and we wanted
to devote a couple minutes to our story and give credit where credit
is due. For conclusion seekers, without doubt or further ado:
[Continuum Analytics' Anaconda Python distribution][anaconda] has made
our lives so much easier. For small- and medium-sized teams, no matter
the deployment scale, Anaconda has big implications. But let's talk
about how we got here.

[anaconda]: https://www.continuum.io/downloads

# Beginnings

Right now, PayPal Python Infrastructure provides equitable support for
Windows, OS X, Linux, and Solaris, supporting various combinations of
32-bit and 64-bit Python 2.6, Python 2.7, and [PyPy 5][pypy].

[pypy]: http://pypy.org/

Glossing over the primordial days, when [Kurt][kurt] and [I][mahmoud]
started building the Python platform at PayPal, we didn't know we
would be building the first cross-platform stack the company had ever
seen. It was December 2012, we just wanted to see every developer
unwrap a brand new laptop running PayPal Python services locally.

[kurt]: https://github.com/kurtbrose
[mahmoud]: https://github.com/mahmoud

What ensued was the most intense engineering sprint I had ever
experienced. We ported critical functionality previously only
available in [shared objects][sos] we had been calling into with
[ctypes][ctypes]. Several key parts were available in binary form only
and had to be disassembled. But with the New Year, 2013, we were
feeling like a whole new stack. All the PayPal-specific parts of our
framework were pure-Python and portable. Just needed to install a few
open-source libraries, like gevent, greenlet, maybe [lxml][lxml]. Just
`pip install`, right?

[sos]: https://en.wikipedia.org/wiki/Library_(computing)#Shared_libraries
[ctypes]: https://docs.python.org/2/library/ctypes.html
[lxml]: http://lxml.de/

# Up the hill

In an environment where Python is still a new technology to most,
`pip` is often not available, let alone understood. This learning
curve can represent a major hurdle to many. We wanted more people to
be able to write Python, and even more to be able to run it, as many
places as possible, regardless of whether they were career
Pythonists. So with a judicious shake of Python simplicity, we adopted
a policy of "vendoring in" all of our core dependencies, including
compiled extensions, like [gevent][gevent].

[gevent]: http://www.gevent.org/

This model yields <span title="nothing compared to Java">somewhat
larger repositories</a>, but the benefits outweighed a few extra seconds
of clone time. Of all the local development stories, there is still no
option more empowering than the fully self-contained repository. Clone
and run. A process so seamless, it's like a miniature demo that goes
perfect every time. In a world of multi-hour C++ and Java builds, it
might as well be magic.

*"So what's the problem?"*

Static builds. Every few months (or every [CVE][cve]) the Python team
would have to sit down to refresh, regression test, and certify a new
set of libraries. New libraries were added sparingly, which is great
for auditability, but not so great for flexibility. All of this is
fine for a tight set of networking, cryptography, and serialization
libraries, but no way could we support the dozens of dependencies
necessary for machine learning and other advanced Python use cases.

[cve]: https://en.wikipedia.org/wiki/Common_Vulnerabilities_and_Exposures

<img src="/uploads/anaconda_logo.png" align="right" width=300/>

And then came [Anaconda][anaconda_over]. With the Anaconda Python
distribution, Continuum is doing effectively what our team had been
doing, but for free, for everyone, for
[hundreds of libraries][anaconda_lib]. Finally, there was a standard
option that made Python even simpler for our developers.

[anaconda_over]: https://www.continuum.io/anaconda-overview
[anaconda_lib]: https://docs.continuum.io/anaconda/pkg-docs

# Adopting and adapting

As soon as we had the opportunity, we made Anaconda a supported
platform for development. From then on, regardless of platform, Python
beginners got one of two introductions: Install Anaconda, or visit our
shared [Jupyter Notebook][jupyter], also backed by Anaconda.

[jupyter]: http://jupyter.org/

<img src="/uploads/illo/snake_esc_sm.png" title="The good kind of
escalation" align="right" width=300/>

Today, Anaconda has gone beyond development environments to enable
production PayPal machine learning applications for the better part of
a year. And it's doing so with more optimizations than we can shake a
stick at, including running all the intensive numerical operations on
[Intel's MKL][imkl]. From now on, Python applications exist on a
moving walkway to production perfection.

[imkl]: https://software.intel.com/en-us/intel-mkl

This was realized through two Anaconda packaging models that work for
us. The first preinstalls a complete Anaconda on top of one of
PayPal's base [Docker][docker] images. This works, and is
buzzword-compliant, but for reasons outside the scope of this post,
also entails maintaining a single large Docker image with the
dependencies of all our downstream users.

[docker]: https://docs.docker.com/engine/security/security/

As with all packaging, there's always another way. One alternative
approach that has worked well for us involves a little Continuum
project known as [Miniconda][minic]. This minimalist distribution has
just enough to make Python and [conda][conda] work. At build time, our
applications package Miniconda, the bzip2 conda archives of the
dependencies, and a Python installer, wrapped up with a
[CalVer][calver] filename. At deploy time, we install Miniconda, then
[conda install the dependencies][conda_nonet]. No downloads, no
compilation, no outside dependencies. [The code][minic_code] is only a
little longer than the description of the process. Conda envs are more
powerful than virtualenvs, and have a better cross-platform,
cross-dev/prod story, as well. Developers enjoy the increased control,
smaller packages, and applicability across both standard and
containerized environments.

[conda]: https://docs.docker.com/engine/security/security/
[minic]: http://conda.pydata.org/miniconda.html
[calver]: http://calver.org/
[conda_nonet]: https://docs.continuum.io/anaconda/faq#how-do-i-install-packages-on-a-non-networked-machine
[minic_code]: https://github.com/paypal/support/blob/master/examples/miniconda/activate

# Packages to come

As stated in [*Enterprise Software with Python*][esp], packaging and
deployment is not the last step. The key to deployment success is
uniform, well-specified environments, with minimal variation between
development and production. Or use Anaconda and call it good enough!
We sincerely thank [the Anaconda contributors][anaconda_gh] for their open-source
contributions, and hope that their reach spreads to ever more
environments and runtimes.

[esp]: http://sedimental.org/esp.html
[anaconda_gh]: https://github.com/ContinuumIO
