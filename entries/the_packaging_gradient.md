---
title: The Many Shades of Packaging
entry_root: the_packaging_gradient
---

*The packaging gradient, and why PyPI isn't an app store.*

One, if not *the*, mantra threaded throughout *Enterprise Software
with Python* is that deployment is not the last step of writing
software. Experienced engineers can be identified by their ability to
plan and design for deployment to a variety of software environments.

This is why we need an adventure. A journey into what I've long called
"the packaging gradient". A quick and easy decision tree to figure out
what you need to ship. You'll gain a trained eye, and begin to
understand why there seem to be so many conflicting opinions about how
to package code.

The first thing to learn is:

> *Implementation language does not define packaging solutions.*

Packaging is all about target environment and deployment
experience. I'll demonstrate this using Python as an example, but the
same lessons apply to most software.

Python was designed to be cross-platform and runs in countless
environments. Don't take this to mean that Python's built-in tools
will carry you anywhere you want to go. I can
[write a mobile app in Python][kivy_android], does it make sense to
install it on my phone with [pip][pip_wp]? As you'll see, Python's
tools only scratch the surface.

So, one by one, I'm going to describe some code you want to ship,
followed by the simplest acceptable packaging process that provides a
repeatable deployment process. We save the most involved solutions for
last. Ready? Let's go!

[kivy_android]: https://kivy.org/docs/guide/android.html
[pip_wp]: https://en.wikipedia.org/wiki/Pip_(package_manager)

[TOC]

# Prelude: The Humble Script

Everyone's first exposure to Python deployment was something so
innocuous you probably wouldn't remember. You copied a script from
point A to point B. Chances are, whether A and B were separate
directories or computers, your days of "just use `cp`" didn't last
long.

Because while a single file is the ideal format for copying, it
doesn't work when that file has dependencies that are unmet at the
destination.

Even simple scripts end up depending on:

* Python libraries - [boltons][boltons], [requests][requests], [NumPy][numpy]
* Python, the runtime - [CPython][cpython], [PyPy][pypy]
* System libraries - [glibc][glibc], [zlib][zlib], [libxml2][libxml2]
* Operating system - [Ubuntu][ubuntu], [FreeBSD][freebsd], [Windows][windows]

[boltons]: https://github.com/mahmoud/boltons
[requests]: https://github.com/kennethreitz/requests
[numpy]: https://github.com/numpy/numpy
[cpython]: https://en.wikipedia.org/wiki/CPython
[pypy]: https://en.wikipedia.org/wiki/PyPy
[glibc]: https://en.wikipedia.org/wiki/GNU_C_Library
[zlib]: http://zlib.net/
[libxml2]: http://xmlsoft.org/
[ubuntu]: https://en.wikipedia.org/wiki/Ubuntu_(operating_system)
[freebsd]: https://www.freebsd.org/
[windows]: http://68.media.tumblr.com/e846f7ed786ead5cee6e4097b254b181/tumblr_mqfh4b0rV61sydj82o1_250.gif


So every good packaging adventure always starts with the question:

> **Where is your code going, and what can we depend on being there?**

First, let's look at libraries. Virtually every project these days
begins with library package management, a little `pip install`. It's
worth a closer look!

# The Python Module

Python library code comes in two sizes, the module and the package,
corresponding to the file and the directory. Packages can contain
modules and packages, and in some cases can grow to be quite
sprawling. The module, being a single file, is much easier to
redistribute.

In fact, if the pure-Python module in question imports nothing but the
standard library itself, you have the unique option of being able to
distribute it by simply copying it into your codebase.

This type of inclusion, known as vendoring, is often glossed over, but
bears many advantages. Simple is better than complex. No extra
commands or formats, no build, no install. Just copy the
code[^licenses] and roll.

For examples of libraries doing this, see bottle.py, ashes, and, of
course, boltons, which also has an architectural statement on the
topic.

[^licenses]: Don't forget to include respective free software licenses, where applicable.

# The pure-Python Package

Packages are the larger unit of redistributable Python. Packages are
directories of code containing an `__init__.py`. Provided they contain
only pure-Python modules, they can be vendored, similar to the module
above, and even very popular packages like requests can be found with
`vendor`, `lib`, and `packages` directories.

Because these packages nest and sprawl, vendoring can lead to
codebases that feel unwieldy. While it may seem awkward to have lib
directories many times larger than your application, it's not as
uncommon as some less-experienced devs might expect. That said, having
worked on some very large codebases, I can definitely understand why
core Python developers created other options for distributing Python
libraries.

For multi-file libraries that only contain Python code, Python's
original built-in solution still works today: sdists, or "source
distributions". This early format worked for well over a decade and is
still supported by `pip` and the Python Package Index (PyPI).

Of course, our single-file modules from above work, too.

# The Python Package

Python is a great language, and one which is made all the greater
by its power to integrate.

Many libraries contain C, Cython, and other statically compiled
languagess that need build tools. If we use sdists, this will trigger
a build that will fail without the tools, will take time and resources
if it succeeds, and generally involved more intermediary languages and
four-letter keywords than Python devs thought should be necessary.

When you have a library that requires compilation, then it's
definitely time to look into the wheel format.

Wheels are named after wheels of cheese, found in the proverbial
cheese shop. Aptly named, wheels really help get development
rolling. Unlike source distributions like sdists, the publisher does
all the building, resulting in a system-specific binary.

The install process just decompresses and copies files into
place. It's so simple that even pure-Python code gets installed faster
when packaged as a wheel instead of an sdist.

It's still recommended to upload sdists because wheels cannot be
prebuilt for all configurations in all environments. If you're curious
what that means, check out
[the design rationale behind Linux wheels](https://github.com/pypa/manylinux/blob/master/pep-513.rst#rationale).

# Milestone: Outgrowing our roots

Now, three forms in, we've hit our first milestone. So far, everything
has relied on built-in Python tools. pip, PyPI, the wheel and sdist
formats, all of these were designed _by_ developers, _for_ developers,
to distribute code and tools _to_ other developers.

PyPI is not an app store.

PyPI, pip, wheels, and the underlying setuptools machinations are all
designed for *libraries*.

Going back to our first example, a "script" is more accurately
described as a command-line *application*. Command-line applications
can have a Python-savvy audience, so it's not totally unreasonable to
host them on PyPI and install them with pip. But understand that we're
approaching the limit for a good production and user-facing
experience.

So let's get explicit. By default, the built-in packaging tools are
designed to depend on:

  * A working Python installation
  * A network connection, probably to the Internet
  * Preinstalled system libraries
  * A developer who is willing to sit and watch dependencies
    recursively download at install-time, and debug version conflicts,
    build errors, and myriad other issues.

These are fine, and expected for development environments.
Professionals are paid to do it, students pay to learn it, and there
are even a few oddballs who enjoy this sort of thing.

Going into our next options, notice how we have shifted gears to
support *applications*. Remember that distributing applications is
more a function of target platform than of implementation
language. This is harder than library distribution because we stop
depending on layers of the stack, and the developer who would be there
to ensure the setup works.

# Depending on pre-installed Python

For our first foray into application distribution, we're going to
maintain the assumption that Python exists in the target
environment. This isn't the wildest assumption, CPython 2 is available
on virtually every Linux and Mac machine.

Taking Python for granted, we can turn to bundling up all of the
Python libraries on which our code depends. We want a single
executable file, the kind that you can double click or run by
prefixing with a `./`, anywhere on a Python-enabled host. The PEX
format gets us exactly this.

The PEX, or Python EXecutable, is essentially a ZIP archive, with a
little bit of bootstrapping. It works on Linux, Mac, and Windows. It
relies on the system Python, but unlike pip, it does not install
itself or otherwise affect system state. It uses mature,
[standard features][zipimporter] of Python, successfully interating on
a broadly used approach, such as [superzippy][superzippy].

A lot can be done with Python and Python libraries alone. If your
project follows this approach, PEX is an easy
choice. [See this 15-minute video for a solid introduction][pex_video].

[pex_video]: https://www.youtube.com/watch?v=NmpnGhRwsu0

# Depending on a new Python/ecosystem

So the primary Python distribution only ships with tools for shipping
developer tools and libraries written in Python. Might there be a
different approach?

Anaconda is a Python distribution with expanded support for
distributing libraries and applications. It's cross-platform, and has
supported binary packages since before the wheel. Anaconda packages
and ships system libraries like
[libxml2](https://anaconda.org/anaconda/libxml2), as well as
applications like
[PostgreSQL](https://anaconda.org/anaconda/postgresql), which fall
outside the purview of default Python packaging tools. That's because
internally Anaconda blends characteristics of a Python distribution
and a full operating system.

If you look inside of an Anaconda installation, what you'll find looks
a lot like a root Linux filesystem, with some extra Anaconda-specific
directories, of course. I like to refer to this pattern as
distro-on-distro. And it's a remarkable implementation because the
same approach has been designed to work on Windows, Mac, and Linux,
with broad compatibility between versions and flavors, more than one
can say for any of the other options below, short of virtualization.

Anaconda blends power and convenience in such a way that
non-developers can use facilities normally reserved for
developers. Plus, Python developers can leverage tools for data
scientists and outside the Python ecosystem. All by using features
built into Python and target operating systems. It's a next-level
ecosystem with a compelling approach, one that I've been using
[in production server environments](https://www.paypal-engineering.com/2016/09/07/python-packaging-at-paypal/)
for over a year now.

<!-- cross-platform, language-agnostic package managers are a rare
thing. Conda is among an elite crew whose ranks include NixOS and
Steam. (and pkgsrc) -->

<!-- conda vs pip+virtualenv: https://conda.io/docs/_downloads/conda-pip-virtualenv-translator.html -->

# Bringing your own Python

Imagine an environment without Python. Hellish right? Luckily, you can
still bring your own, and it's ice cold. Freezing, in fact.

When I wrote my first Python program, I naturally shared news of the
accomplishment with my parents, who naturally wanted to experience the
achievement first hand. Of course all I had a .py file I wrote on
Knoppix, and they were halfway around the world on a Windows 2000
machine. Lucky for me, cx_Freeze had come out a couple months
earlier. Unlucky for me, I took one look at it and knew I had a few
years to go before I could call myself a real programmer.

Fifteen years later, the process has evolved, but retained the same
general approach. Freezers owe their name to their reliance on the
"frozen module" functionality built into Python. It's
[sparsely](https://docs.python.org/2/c-api/import.html#c.PyImport_ImportFrozenModule)
[documented](https://docs.python.org/2/library/imp.html#imp.init_frozen),
but basically Python code is precompiled into bytecode and frozen into
the interpreter.
[As of Python 3.3](https://docs.python.org/3/whatsnew/3.3.html),
Python's import system
[was ported](http://sayspy.blogspot.com/2012/02/how-i-bootstrapped-importlib.html)
from C to a frozen pure-Python implementation. Dropbox, EVE Online,
Civilization IV, kivy, and countless other applications and frameworks
rely on freezing to ship applications, generally to personal computing
devices.

If you are also building a Python application and want to bundle your
own Python, you can use cx_Freeze, PyInstaller,
[osnap](https://github.com/jamesabel/osnap), bbFreeze, py2exe, or
py2app. A feature matrix can be found
[here](http://python-guide.readthedocs.io/en/latest/shipping/freezing/).

That's far from the whole story, but the direction is the same: all
the business logic and dependencies rolled into an independent
artifact. Most of these systems enable you to tune exactly how
independent this executable is.  See
[this py2exe tutorial discussion of Windows system libraries](http://www.py2exe.org/index.cgi/Tutorial#Step5)
for a taste of the fun.

## More than one way to ship a Python

Freezing tends to be targeted more toward client software. GUIs and
CLI applications run by a single user on a single machine at a
time. When it comes to deploying server software bundled with its own
Python, there is a notable alternative: the Omnibus.

Omnibus builds "full-stack" installers designed to deploy applications
to servers. It supports RedHat and Debian-based Linux distros, as well
as Mac and Windows. A few years back, DataDog saw the light and
[made the switch](https://www.datadoghq.com/blog/new-datadog-agent-omnibus-ticket-dependency-hell/)
for their Python-based agent.

* TODO: omnibus (also works with RPM/deb). The giveaway is that
  omnibus packages frequently have different versions of the same OS,
  indicating that they do rely on some parts of the existing system's
  userspace. RPATH searches somewhere first, then falls back to system
  paths.

<!-- I'm mostly server-side, but desktop installers and mobile packages
tend to fall into this category. -->

# Bringing your own userspace

Probably the newest and fastest-growing class of solution has actually
been a long time coming. You may have heard it referenced by its
buzzword: containerization, sometimes crudely described as
"lightweight virtualization".

(TODO: link to Jess Frazelle)

Unlike other options so far, these packages establish a firm border
between their dependencies and the libraries on the host system. This
is a huge win for environmental independence and deployment
repeatability.

## In our own image

Let's illustrate with one of the simplest and most mature
implementations, [AppImage][appimage].

[appimage]: https://en.wikipedia.org/wiki/AppImage

Since 2004, the aptly-named AppImage (and its predecessor klik) have
been providing distro-agnostic, installation-free application
distribution to end users, without requiring root or touching the
underlying operating system. AppImages only rely on the kernel and CPU
architecture.

An AppImage is perhaps the most aptly-named solution in this whole
post. It is literally an [ISO9660][iso9660] image containing an
entrypoint executable, plus a snapshot of a filesystem comprising a
userspace, full of support libraries and other dependencies. Looking
inside, it's easy to recognize the familiar structure of a Unix
filesystem:

<!-- TODO: filesystem -->

[iso9660]: https://en.wikipedia.org/wiki/ISO_9660

Dozens of headlining Linux applications ship like this now. Download
the AppImage, make it executable, double-click, and voila.

If you're reading this on a Mac, you've probably had a similar
experience. This is one of those rare cases where there's some
consensus: Apple was one of the pioneers in image-based deployments,
with [DMGs][dmg] and [Bundles][bundle].

[dmg]: https://en.wikipedia.org/wiki/Apple_Disk_Image
[bundle]: https://en.wikipedia.org/wiki/Bundle_(macOS)
-->

## An image by any other name

No class of formats would be complete without
[a war][format_war]. AppImage [inspired][appimage_flatpak] the
[Flatpak][flatpak] format, which was adopted by RedHat/Fedora, but was
of course insufficient for Canonical/Ubuntu, who were also targeting
mobile, and created [Snappy][snappy]. A shiny update to our deb-rpm
split tradition.

[format_war]: https://en.wikipedia.org/wiki/Format_war
[flatpak]: https://en.wikipedia.org/wiki/Flatpak
[appimage_flatpak]: https://en.wikipedia.org/wiki/AppImage#Reception_and_usage
[snappy]: https://en.wikipedia.org/wiki/Snappy_(package_manager)

Both of these formats introduce more features, as well as more
complexity and dependence on the operating system. Both Snaps and
Flatpaks expect the host to support their runtime, which can include
[dbus, a systemd user session, and more][flatpak_server]. A lot of
work is put into increased [namespacing][namespaces] to isolate
running applications into separate [sandboxes][jessfraz_sandboxes].

[namespaces]: https://en.wikipedia.org/wiki/Linux_namespaces#Mount_.28mnt.29
[jessfraz_sandboxes]: https://blog.jessfraz.com/post/getting-towards-real-sandbox-containers/

[flatpak_server]: http://flatpak.org/faq.html#Can_Flatpak_be_used_on_servers_too_

I haven't actually seen these formats used for deploying server
software. Flatpak might never support servers, Snappy is trying, but
personally, I would really like to hear about or experiment with
server-oriented AppImages.

## The whale in the room

Some call the technology sphere a marketplace of ideas, and that
metaphor is certainly felt in this case. Whether you've heard good
things or bad, we can all agree [Docker][docker] is the format sold
the hardest. What else would you do when you've got $180 million of VC
breathing down your neck.

Docker lets you make an application as self-contained as AppImage, but
exceeds even Snapcraft and Flatpak in the assumptions it makes. Images
are managed and run by yet another service with a lot of capabilities
and tightly coupled components.

Docker's packaging abstraction reflects this complexity. Take for
instance how Docker applications default to running as `root`, despite
[their documentation][docker_bp] recommending against this. Default
`root` is particularly unfriendly because namespacing is still not a
reliable guard against malicious actors attacking the host
system. [Root inside the container is root outside the container][root_inside]. Always
check the [CVEs][namespace_cves]. The Docker
[security documentation][docker_sec_doc] also includes some good,
frank discussion of what one is getting into.

[docker_bp]: https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#user
[root_inside]: http://blog.dscpl.com.au/2015/12/don-run-as-root-inside-of-docker.html
[docker]: https://en.wikipedia.org/wiki/Docker_(software)
[namespace_cves]: https://www.google.com/search?q=namespace+site:cve.mitre.org&client=ubuntu&hs=55V&channel=fs&source=lnt&tbs=qdr:y&sa=X
[docker_sec_doc]: https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface

Checking in with our trendline, so far we have been shipping larger
larger, more-inclusive artifacts for more independent, reliable
deployments. Some container systems present us with our first clear
departure from this pattern. We no longer have a single executable
that runs or installs our code. Technically we have a self-contained
application, but we're also back to requiring an interpreter other
than the OS and CPU.

[jessfraz_nocont]: https://blog.jessfraz.com/post/containers-zones-jails-vms/

It's not hard to imagine instances where the complexity of a runtime
can overrun the advantages of self-containment. To quote Jessie
Frazelle's [blog post][jessfraz_nocont] again, "Complexity ==
Bugs". This dynamic leads some to skip straight to our next option,
but as AppImage simply demonstrates, this is not an impeachment of all
image-based approaches.

<!-- If I have time: 2D scatterplot of relative inclusivity and
execution dependability. -->

# Bringing your own kernel

Now we're really packing heavy. If having your Python code, libraries,
runtime, and necessary system libraries isn't enough, you can add one
more piece of machinery: the operating system [kernel][kernel] itself.

[kernel]: https://en.wikipedia.org/wiki/Kernel_(operating_system)

While this type of distribution never really caught on for consumers,
there is a rich ecosystem of tools and formats for VM-based server
deployment, from Vagrant to AMIs to OpenStack. The whole cloud.

Like our more complex container examples above, the images used to run
virtual machines are not runnable executables, and require a mediating
runtime, called a hypervisor. The images themselves come in a few
formats, all of which are mature and dependable, if large. Size and
build time may be the only deterrent for smaller projects prioritizing
development time. Thanks to years of kernel and processor advancement,
virtualization is not as slow as many developers would assume. If you
can make images work faster than other options, go for it.

Larger organizations save a lot from even small reductions to
deployment and runtime overhead, but have to balance that against half
a dozen other concerns worthy of a much longer discussion elsewhere.

# Bringing your own hardware

Slap it on a rackable server, Raspberry Pi, or even a micropython and
literally ship it! It may seem absurd at first, but hardware is the
most sensible option for countless cases. It's not just consumer and
IoT use cases, either. Especially where infrastructure and security
are concerned, hardware is made to fit software like a glove, to
eliminate exposure for all parties.

# But what about

Before concluding, there are some usual suspects that may be
conspicuously absent, depending on how long you've been packaging
code.

## OS packages

Where do OS packages like deb and rpm fit into all of this? They can
fit anywhere, really. If you are very sure what operating system(s)
you're targeting, these packaging systems can be powerful tools for
distributing and installing code. These systems are mature and robust,
capable of doing dependency resolution, transactional installs, and
custom uninstall logic.

In ESP's packaging segment, I touch on how we leveraged RHEL's RPM
packages. One detail, not relevant then, but relevant now, is how
PayPal used a separate rpmdb for PayPal-specific packages, maintaining
a clear divide between application and base system.

## virtualenv

Where do virtualenvs fit into all of this? Virtualenvs are
indispensible for many Python development workflows, but I discourage
direct use of virtualenvs for deployment. Virtualenvs can be used
behind the scenes, of course. Feel free to create a virtualenv in an
RPM post_install step, or by virtue of using an installer like
osnap. The key is that the artifact and its install process should be
self-contained, minimizing the risk of disruption by network failure.

## Security

The further down the list you come, the harder it gets to update
components of your package. This doesn't mean that it's harder to
update in general, but it is still a consideration, when for years the
approach has been to have system administrators and other technicians
handle certain kinds of infrastructure updates.

For example, if a kernel security issue emerges, and you're deploying
containers, the host system's kernel can be updated without requiring
a new build on behalf of the application. If you deploy VM images,
you'll need a new build. Whether or not this dynamic makes one option
more secure is still a matter of debate.

<!-- Earlier note about containers: At some level, these are all the
equivalent of static linking, with all of the added convenience and
security risks. If a component is broken or compromised inside an
application image, there's generally not a good way to find out, let
alone upgrade just that component.
-->

-----

# In brief

The goal of packaging is to reduce one's code to a redistributable
unit, generally a single file, which can reliably run the code as
tested prior to deployment.

1. Have a single Python module that only uses the standard library? .py + cp.
   No extra format necessary, Python modules are portable and
   installable with a simple copy command.
2. Have a package with no compiled artifacts (i.e., pure-Python), and
   you're ok with downloading dependencies at install time? sdist +
   pip.
3. Have a package with compiled artifacts of its own, and
   you're ok with downloading dependencies at install time? wheel + pip.
4. Have a package (possibly with compiled artifacts), can't use
   virtualenv, and want no install-time downloads? .tar + cp. With
   Python it's possible to put all of your dependencies, including
   compiled libraries (statically linked), into a fully self-contained
   directory. Just don't deploy with git.
5. Have a package (possibly with compiled artifacts) and you want no
   install-time downloads? pex + pants. pex, pants, and virtualenv
   standardize the path munging and packaging of the method above so
   you don't have to. PEX is quite a step up in complexity from the
   method above, but much of that is inherited from virtualenv design
   choices.

In production environments, I strongly recommend against downloading
dependencies at install time. Packages need to be self-contained for
reliable installs, even if you own the artifact repository. This is
why I recommend against pip as an installer for applications and
services.

If you have control over your systems and can have them set up
consistently, either through imaging, configuration management
(Puppet/Chef), or by painstaking handiwork, then this is often as far
as you need to go. Environmental consistency is trivial for smaller
organizations, which have a small number of machines and little
environmental variation and conflict.

The main reason to move to the next tier is when you cannot preinstall
system libraries and binaries and need to provide them through deployment.

# Dependable Operating System

The operating system is your playground. The kernel and userspace are
fairly dependable.

* want a statically built executable with minimal reliance on system
  libraries and binaries (including python)? cx_Freeze and similar
* need python and other system libraries and binaries, ok with
  triggering extra installs and compilation? conda/anaconda, or rpm/deb/etc.
* need your own userspace, want self-contained install? container
* need your own userspace and kernel, with self-contained install? image

Development can be quite different than deployment. even if you're ok
with compiling your own stuff for development, you basically never
want that at prod deployment time.

PyPI is for libraries, simple frameworks, and simple command-line
utilities.

AppImage (and Flatpak)

You could ship your website on a MicroPython board, but you don't,
because it's overkill.

## The End

In the end, packaging is a balancing act. Where do you want to draw
the line between what is in your package and what is on the target
system. There are no universally right answers, but the equation is
simple enough that you can design a balanced process.

The Python packaging landscape is converging, but don't let that
narrow your focus. Every year seems to open new frontiers, challenging
existing practices for shipping Python.

## Notes

* One of the major drawbacks of pip and conda compared to OS package
  managers is that RPMs and deb have transactional installs, capable
  of rolling back if an error occurs in the middle of
  installation. conda and pip do not attempt any such rollback or
  recovery.

<!-- Installable vs. Frozen vs. Image. (Target Python, vs target OS, vs target virtualization) -->

## Closing / Summary

Packaging in Python has a bit of a reputation for being a
madhouse. But I assure you that this is a small price Python
programmers pay for using the most balanced, versatile language
available. Python's innumerable applications mean that there are
dozens of packaging options, and now, with map in hand, you can safely
navigate the rich terrain.

Python is general-purpose, PyPI is not.


<!-- If writing software was like taking a test, ignoring packaging and
deployment wouldn't be leaving a question blank; it would be
forgetting to turn in the exam. Of course, with today's maze of
deployment practices, sometimes turning in the test can feel like the
real test.

-->

([mount namespace](http://man7.org/linux/man-pages/man7/mount_namespaces.7.html)
is the successor to chroot)
