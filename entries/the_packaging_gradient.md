---
title: The Many Layers of Packaging
entry_root: the_packaging_gradient
tags:
  - python
  - packaging
  - boltons
publish_date: 1:47pm May 9, 2017
---

*The packaging gradient, and why PyPI isn't an app store.*

One lesson threaded throughout
[*Enterprise Software with Python*][esp] is that deployment is not the
last step of development. The mark of an experienced engineers is to
work backwards from deployment, planning and designing for the reality
of production environments.

You could learn this the hard way. Or you could come on a journey into
what I call *the packaging gradient*. It's a quick and easy decision
tree to figure out what you need to ship. You'll gain a trained eye,
and an understanding as to why there seem to be so many conflicting
opinions about how to package code.

The first lesson on our adventure is:

> *Implementation language does not define packaging solutions.*

<img align="right" width="40%" src="/uploads/illo/snake_box_sm.png">

Packaging is all about target environment and deployment
experience. Python will be used in examples, but the same decision
tree applies to most general-purpose languages.

Python was designed to be cross-platform and runs in countless
environments. But don't take this to mean that Python's built-in tools
will carry you anywhere you want to go. I can
[write a mobile app in Python][kivy_android], does it make sense to
install it on my phone with [pip][pip_wp]? As you'll see, a language's
built-in tools only scratch the surface.

So, one by one, I'm going to describe some code you want to ship,
followed by the simplest acceptable packaging process that provides
that repeatable deployment process we crave. We save the most involved
solutions for last, right before [the short version](#closing). Ready?
Let's go!

[esp]: http://shop.oreilly.com/product/0636920047346.do
[kivy_android]: https://kivy.org/docs/guide/android.html
[pip_wp]: https://en.wikipedia.org/wiki/Pip_(package_manager)

[TOC]

# Prelude: The Humble Script

Everyone's first exposure to Python deployment was something so
innocuous you probably wouldn't remember. You copied a script from
point *A* to point *B*. Chances are, whether *A* and *B* were separate
directories or computers, your days of "just use `cp`" didn't last
long.

Because while a single file is the ideal format for copying, it
doesn't work when that file has unmet dependencies at the destination.

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

Python library code comes in two sizes, [module][module] and package,
practically corresponding to files and directories on disk. Packages
can contain modules and packages, and in some cases can grow to be
quite sprawling. The module, being a single file, is much easier to
redistribute.

[module]: https://docs.python.org/2/tutorial/modules.html

In fact, if a pure-Python module imports nothing but the standard
library itself, you have the unique option of being able to distribute
it by simply copying the single file into your codebase.

This type of inclusion, known as vendoring, is often glossed over, but
bears many advantages. [Simple is better than complex][pep20]. No extra
commands or formats, no build, no install. Just copy the
code[^licenses] and roll.

[pep20]: https://www.python.org/dev/peps/pep-0020/

For examples of libraries doing this, see [bottle.py][bottle.py],
[ashes][ashes], [schema][schema.py], and, of course,
[boltons][boltons], which also has
[an architectural statement][boltons_architecture] on the topic.

[^licenses]: Don't forget to include respective free software licenses, where applicable.

[bottle.py]: https://bottlepy.org/docs/dev/
[ashes]: https://github.com/mahmoud/ashes
[boltons]: https://github.com/mahmoud/boltons
[boltons_architecture]: http://boltons.readthedocs.io/en/latest/architecture.html
[schema.py]: https://github.com/keleshev/schema


# The pure-Python Package

Packages are the larger unit of redistributable Python. Packages are
directories of code containing an `__init__.py`. Provided they contain
only pure-Python modules, they can also be vendored, similar to the
module above. Even very popular packages
[like requests][requests_vendor] can be found with `vendor`, `lib`,
and `packages` directories.

[requests_vendor]: https://github.com/kennethreitz/requests/tree/master/requests/packages

Because these packages nest and sprawl, vendoring can lead to
codebases that feel unwieldy. While it may seem awkward to have `lib`
directories many times larger than your application, it's more common
than some less-experienced devs might expect. That said, having worked
on some very large codebases, I can definitely understand why core
Python developers created other options for distributing Python
libraries.

For libraries that only contain Python code, whether single-file or
multi-file, Python's original built-in solution still works today:
[sdists][sdist], or "source distributions". This early format has
worked for well over a decade and is still supported by `pip` and the
[Python Package Index][pypi] (PyPI)[^pypi].

[sdist]: https://docs.python.org/2/distutils/sourcedist.html
[pypi]: https://pypi.python.org/pypi

# The Python Package

Python is a great language, and one which is made all the greater
by its power to integrate.

Many libraries contain [C][c], [Cython][cython], and other
statically-compiled languagess that need build tools. If we distribute
such code using sdists, installation will trigger a build that will
fail without the tools, will take time and resources if it succeeds,
and generally involved more intermediary languages and four-letter
keywords than Python devs thought should be necessary.

[c]: https://www.paypal-engineering.com/2016/09/22/python-by-the-c-side/
[cython]: https://en.wikipedia.org/wiki/Cython

When you have a library that requires compilation, then it's
definitely time to look into [the wheel format][wheel].

[wheel]: http://pythonwheels.com/

Wheels are named after wheels of cheese, found in
[the proverbial cheese shop][cheese_shop]. Aptly named, wheels really
help get development rolling. Unlike source distributions like sdists,
the publisher does all the building, resulting in a system-specific
binary.

[cheese_shop]: https://wiki.python.org/moin/CheeseShop

The install process just decompresses and copies files into
place. It's so simple that even pure-Python code gets installed [faster][faster_wheels]
when packaged as a wheel instead of an sdist.

[faster_wheels]: https://hynek.me/articles/sharing-your-labor-of-love-pypi-quick-and-dirty/

Now even when you upload wheels, I still recommend uploading sdists as
a fallback solution for those occasions when a wheel won't work. It's
simply not possible to prebuild wheels for all configurations in all
environments. If you're curious what that means, check out
[the design rationale behind Linux wheels](https://github.com/pypa/manylinux/blob/master/pep-513.rst#rationale).

# Milestone: Outgrowing our roots

<img align="right" width="40%" src="/uploads/illo/legatree_med.png">

Now, three approaches in, we've hit our first milestone. So far,
everything has relied on built-in Python tools. pip, PyPI, the wheel
and sdist formats, all of these were designed _by_ developers, _for_
developers, to distribute code and tools _to_ other developers.

In other words:

> *PyPI is not an app store.*

PyPI, pip, wheels, and the underlying setuptools machinations are all
designed for *libraries*. Code for developer reuse.

Going back to our first example, a "script" is more accurately
described as a command-line *application*. Command-line applications
can have a Python-savvy audience, so it's not totally unreasonable to
host them on PyPI and install them with pip (or [pipsi][pipsi]). But
understand that we're approaching the limit for a good production and
user-facing experience.

[pipsi]: https://github.com/mitsuhiko/pipsi

So let's get explicit. By default, the built-in packaging tools are
designed to depend on:

  * A working Python installation
  * A network connection, probably to the Internet
  * Pre-installed system libraries
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
prefixing with a `./`, anywhere on a Python-enabled
host. [The PEX format][pex] gets us exactly this.

[pex]: https://pex.readthedocs.io/en/stable/

The PEX, or Python EXecutable, is a carefully-constructed ZIP archive,
with just a hint of bootstrapping. PEXs can be built for Linux, Mac,
and Windows. Artifacts relies on the system Python, but unlike pip, it
does not install itself or otherwise affect system state. It uses
mature, [standard features][zipimport] of Python, successfully
iterating on a [broadly][zipapp]-[used][superzippy] approach.

[zipimport]: https://www.python.org/dev/peps/pep-0273/
[zipapp]: https://docs.python.org/3/library/zipapp.html
[superzippy]: https://github.com/brownhead/superzippy

A lot can be done with Python and Python libraries alone. If your
project follows this approach, PEX is an easy
choice. [See this 15-minute video for a solid introduction][pex_video].

[pex_video]: https://www.youtube.com/watch?v=NmpnGhRwsu0

# Depending on a new Python/ecosystem

Plain old vanilla Python leaving you wanting? That factory-installed
system software can leave a lot to be desired. Lucky for us there's an
upgrade well within grasp.

[Anaconda][anaconda] is a Python distribution with expanded support
for distributing libraries and applications. It's cross-platform, and
has supported binary packages since before the wheel. Anaconda
packages and ships system libraries like [libxml2][libxml2], as well
as applications like [PostgreSQL][postgres], which fall outside the
purview of default Python packaging tools. That's because while
Anaconda might seem like an innocent Python distribution from the
outside, internally Anaconda blends in characteristics of a full-blown
operating system, complete with its own package manager, [conda][conda].

[anaconda]: https://www.continuum.io/downloads
[libxml2]: https://anaconda.org/anaconda/libxml2
[postgres]: https://anaconda.org/anaconda/postgresql

If you look inside of an Anaconda installation, or at the screenshot
below, you'll find something that looks a lot like
[a root Linux filesystem][unix_filesystem] (`lib`, `bin`, `include`,
`etc`), with some extra Anaconda-specific directories.

[unix_filesystem]: https://en.wikipedia.org/wiki/Unix_File_System

<img width="75%" src="/uploads/anaconda_internals.png">

What's remarkable is that the underlying operating system can be
Windows, Mac, or basically any flavor of Linux. Just like that,
Anaconda unassumingly blends Python libraries and system libraries,
convenience and power, development and data science. And it does it
all by using features built into Python and target operating
systems.

Conda may not get enough credit, as evidenced by
[common misunderstandings][conda_myths], but it does have some room to
improve. For instance, transactional package installation and upgrades
is at the top of my conda wishlist. Still, with only [Steam][steam],
[Nix][nix], and [pkgsrc][pkgsrc] as peers, cross-platform,
language-agnostic package managers like [conda][conda] are a rare
breed. [Unlike pip][pip_depres], conda does its dependency resolution
up front (using [a SAT solver][pycosat]), and otherwise
[compares favorably to the pip + virtualenv combination][conda_pip_compare].

In practice, Anaconda makes a compelling and effective case, even
[in production server environments][paypal_conda].

[conda]: https://conda.io/docs/
[steam]: https://en.wikipedia.org/wiki/Steam_(software)
[nix]: https://en.wikipedia.org/wiki/Nix_package_manager
[pkgsrc]: https://en.wikipedia.org/wiki/Pkgsrc
[conda_pip_compare]: https://conda.io/docs/_downloads/conda-pip-virtualenv-translator.html
[paypal_conda]: https://www.paypal-engineering.com/2016/09/07/python-packaging-at-paypal/

[pip_depres]: https://github.com/pypa/pip/issues/988
[pycosat]: https://github.com/ContinuumIO/pycosat
[conda_myths]: https://jakevdp.github.io/blog/2016/08/25/conda-myths-and-misconceptions/

# Bringing your own Python

<img align="right" width="40%" src="/uploads/illo/snake_freeze_sm.png">

Can you imagine deploying to an environment without Python? It's a
hellish scenario, I know. Luckily, your code can still bring your own,
and it's ice cold. Freezing, in fact.

When I wrote my first Python program, I naturally shared news of the
accomplishment with my parents, who naturally wanted to experience
this taste of *The Future* firsthand.

Of course all I had a .py file I wrote on [Knoppix][knoppix], and they
were halfway around the world on a Windows 2000 machine. Luckily, this
new software called [cx_Freeze][cx_freeze] was
[just announced a couple months earlier][cx_freeze_announce]. Unluckily,
no one told me, and the better part of a decade would pass before I
learned how to use it.

[knoppix]: https://en.wikipedia.org/wiki/Knoppix
[cx_freeze]: https://anthony-tuininga.github.io/cx_Freeze/
[cx_freeze_announce]: https://mail.python.org/pipermail/python-announce-list/2002-November/001824.html

Fifteen years later, the process has evolved, but retained the same
general shape. [Dropbox][dropbox_analysis], [EVE Online][eve],
[Civilization IV][civ_iv], [kivy][kivy], and countless other
applications and frameworks rely on freezing to ship applications,
generally to personal computing devices. Interpreter, libraries, and
application logic, all rolled into an independent artifact.

[dropbox_analysis]: http://www.openwall.com/presentations/WOOT13-Security-Analysis-of-Dropbox/
[dropbox_analysis_repo]: https://github.com/kholia/dedrop
[eve]: https://en.wikipedia.org/wiki/Eve_Online
[civ_iv]: https://en.wikipedia.org/wiki/Civilization_IV
[kivy]: https://kivy.org/

These days the list of open-source tools has expanded beyond
[cx_Freeze][cx_freeze] to include [PyInstaller][pyinstaller],
[osnap][osnap], [bbFreeze][bbfreeze], [py2exe][py2exe],
[py2app][py2app], and more. A partial feature matrix can be found
[here][freezer_matrix].

[pyinstaller]: http://www.pyinstaller.org/
[osnap]: https://github.com/jamesabel/osnap
[bbfreeze]: https://pypi.python.org/pypi/bbfreeze
[py2exe]: http://www.py2exe.org/
[py2app]: https://py2app.readthedocs.io/en/latest/
[freezer_matrix]: http://python-guide.readthedocs.io/en/latest/shipping/freezing/

Most of these systems give you some latitude to determine exactly how
independent an executable to generate. Frozen artifacts almost always
ends up depending somewhat on the host operating system. See
[this py2exe tutorial discussion of Windows system libraries][py2exe_tutorial]
for a taste of the fun.

[py2exe_tutorial]: http://www.py2exe.org/index.cgi/Tutorial#Step5

If you're wondering about the chilly moniker, freezers owe their name
to their reliance on the "frozen module" functionality built into
Python. It's
[sparsely](https://docs.python.org/2/c-api/import.html#c.PyImport_ImportFrozenModule)
[documented](https://docs.python.org/2/library/imp.html#imp.init_frozen),
but basically Python code is precompiled into bytecode and frozen into
the interpreter.
[As of Python 3.3](https://docs.python.org/3/whatsnew/3.3.html),
Python's import system
[was ported](http://sayspy.blogspot.com/2012/02/how-i-bootstrapped-importlib.html)
from C to a frozen pure-Python implementation.

## Servers ride the bus

<img align="right" width="40%" src="/uploads/illo/omnibus_med.jpg">

Freezing tends to be targeted more toward client software. They're
great for GUIs and CLI applications run by a single user on a single
machine at a time. When it comes to deploying server software bundled
with its own Python, there is a very notable alternative: the
[Omnibus][omnibus].

Omnibus builds "full-stack" installers designed to deploy applications
to servers. It supports RedHat and Debian-based Linux distros, as well
as Mac and Windows. A few years back, DataDog saw the light and
[made the switch][datadog_refactor] for their Python-based
agent. [GitLab][gitlab]'s [on-premise solution][gitlab_ce] is perhaps the
largest open-source usage, and has been a joy to install and upgrade.

[gitlab]: https://about.gitlab.com/
[gitlab_ce]: https://about.gitlab.com/downloads/

Unlike our multitude of freezers, Omnibus is uniquely elegant and
mature. No other system has natively shipped
multi-component/multi-service packages as sleekly for as long.

[omnibus]: https://github.com/chef/omnibus
[datadog_refactor]: https://www.datadoghq.com/blog/new-datadog-agent-omnibus-ticket-dependency-hell/

# Bringing your own userspace

Probably the newest and fastest-growing class of solution has actually
been a long time coming. You may have heard it referenced by its
buzzword: containerization, sometimes crudely described as
"lightweight virtualization".

[Better descriptions exist][jess_desc], but the important part is
this: Unlike other options so far, these packages establish a firm
border between their dependencies and the libraries on the host
system. This is a huge win for environmental independence and
deployment repeatability.

[jess_desc]: https://blog.jessfraz.com/post/containers-zones-jails-vms/

## In our own image

Let's illustrate with one of the simplest and most mature
implementations, [AppImage][appimage].

<div style="text-align:center;"><img width="60%" src="/uploads/illo/snake_image_sm.png"></div>

[appimage]: https://en.wikipedia.org/wiki/AppImage
[klik]: https://en.wikipedia.org/wiki/AppImage#klik

Since 2004, the aptly-named AppImage (and its predecessor
[klik][klik]) have been providing distro-agnostic, installation-free
application distribution to Linux end users, without requiring root or
touching the underlying operating system. AppImages only rely on the
kernel and CPU architecture.

An AppImage is perhaps the most aptly-named solution in this whole
post. It is literally an [ISO9660][iso9660] image containing an
entrypoint executable, plus a snapshot of a filesystem comprising a
userspace, full of support libraries and other dependencies. Looking
inside a mounted [Kdenlive][kdenlive] image, it's easy to recognize
the familiar structure of a Unix filesystem:

<img width="75%" src="/uploads/kdenlive_appimage_internals.png">

[iso9660]: https://en.wikipedia.org/wiki/ISO_9660
[kdenlive]: https://kdenlive.org/

Dozens of headlining Linux applications ship like this now. Download
the AppImage, make it executable, double-click, and voila.

If you're reading this on a Mac, you've probably had a similar
experience. This is one of those rare cases where there's some
consensus: Apple was one of the pioneers in image-based deployments,
with [DMGs][dmg] and [Bundles][bundle].

[dmg]: https://en.wikipedia.org/wiki/Apple_Disk_Image
[bundle]: https://en.wikipedia.org/wiki/Bundle_(macOS)

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
the hardest. What else would you do when you've got
[$180 million of VC][docker_vc] breathing down your neck.

[docker_vc]: https://www.crunchbase.com/organization/docker

Docker lets you make an application as self-contained as AppImage, but
exceeds even Snapcraft and Flatpak in the assumptions it makes. Images
are managed and run by [yet another service][dockerd] with a lot of
capabilities and tightly coupled components.

[dockerd]: https://docs.docker.com/engine/reference/commandline/dockerd/

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

It's not hard to imagine instances where the complexity of a runtime
can overrun the advantages of self-containment. To quote Jessie
Frazelle's [blog post][jessfraz_nocont] again, **"Complexity ==
Bugs"**. This dynamic leads some to skip straight to our next option,
but as AppImage simply demonstrates, this is not an impeachment of all
image-based approaches.

[jessfraz_nocont]: https://blog.jessfraz.com/post/containers-zones-jails-vms/

<!-- If I have time: 2D scatterplot of relative inclusivity and
execution dependability. -->

# Bringing your own kernel

Now we're really packing heavy. If having your Python code, libraries,
runtime, and necessary system libraries isn't enough, you can add one
more piece of machinery: the operating system [kernel][kernel] itself.

[kernel]: https://en.wikipedia.org/wiki/Kernel_(operating_system)

While this type of distribution never really caught on for consumers,
there is a rich ecosystem of tools and formats for VM-based server
deployment, from [Vagrant][vagrant] to [AMIs][ami] to
[OpenStack][openstack]. The whole dang cloud.

[vagrant]: https://en.wikipedia.org/wiki/Vagrant_(software)
[ami]: https://en.wikipedia.org/wiki/Amazon_Machine_Image
[openstack]: https://en.wikipedia.org/wiki/OpenStack

Like our more complex container examples above, the images used to run
virtual machines are not runnable executables, and require a mediating
runtime, called a [hypervisor][hypervisor]. The images themselves come
in a [few][vmdk] [formats][ovf], all of which are mature and
dependable, if large. Size and build time may be the only deterrent
for smaller projects prioritizing development time. Thanks to years of
kernel and [processor advancement][hav], virtualization is not as slow
as many developers would assume. If you can get your software shipped
faster on images, then I say go for it.

[hav]: https://en.wikipedia.org/wiki/Hardware-assisted_virtualization
[hypervisor]: https://en.wikipedia.org/wiki/Hypervisor
[ovf]: https://en.wikipedia.org/wiki/Open_Virtualization_Format
[vmdk]: https://en.wikipedia.org/wiki/VMDK

Larger organizations save a lot from even small reductions to
deployment and runtime overhead, but have to balance that against half
a dozen other concerns worthy of
[a much longer discussion elsewhere][esp_9he].

[esp_9he]: https://player.oreilly.com/videos/9781491943755

# Bringing your own hardware

In a software-driven Internet obsessed with lighter and lighter weight
solutions, it can be easy to forget that a lot of software is
[literally packaged][appliance].

If your application calls for it, you can absolutely slap it on a
rackable server, [Raspberry Pi][raspberry_pi], or even a
[micropython][micropython] and physically ship it. It may seem absurd
at first, but hardware is the most sensible option for countless
cases. And not limited to just consumer and IoT use cases,
either. Especially where infrastructure and security are concerned,
hardware is made to fit software like a glove, and can minimize
exposure for all parties.

[appliance]: https://en.wikipedia.org/wiki/Computer_appliance
[raspberry_pi]: https://www.raspberrypi.org/
[micropython]: https://micropython.org/

<div style="text-align:center;"><img width="40%" src="/uploads/illo/snake_esc_sm.png"></div>

# But what about...

Before concluding, there are some usual suspects that may be
conspicuously absent, depending on how long you've been packaging
code.

## OS packages

Where do OS packages like [deb][deb] and [RPM][rpm] fit into all of
this? They can fit anywhere, really. If you are very sure what
operating system(s) you're targeting, these packaging systems can be
powerful tools for distributing and installing code. There are reasons
beyond popularity that almost all production container and VM
workflows rely on OS package managers. They are mature, robust, and
capable of doing dependency resolution, transactional installs, and
custom uninstall logic. Even systems as powerful as
[Omnibus](#servers_ride_the_bus) target OS packages.

[deb]: https://en.wikipedia.org/wiki/Deb_(file_format)
[rpm]: https://en.wikipedia.org/wiki/RPM_Package_Manager

In [ESP][esp]'s packaging segment, I touch on how we leveraged RPMs as
a delivery mechanism for Python services in PayPal's production RHEL
environment. One detail, that would have been minor and confusing in
that context, but should make sense to readers now, is that PayPal
didn't use the vanilla operating system setup. Instead, all machines
used a separate rpmdb and install path for PayPal-specific packages,
maintaining a clear divide between application and base system.

## virtualenv

Where do [virtualenvs][virtualenvs] fit into all of this? Virtualenvs
are indispensible for many Python development workflows, but I
discourage direct use of virtualenvs for deployment. Virtualenvs are
fine to use behind the scenes, of course. Maybe make a virtualenv in
an RPM post-install step, or by virtue of using an installer like
[osnap][osnap]. The key is that the artifact and its install process
should be self-contained, minimizing the risk of partial installs.

This isn't virtualenv-specific, but lest it go unsaid, do not
pip-install things, especially from the Internet, during production
deploys. [Scroll up and read about PEX](#depending_on_pre_installed_python).

[virtualenvs]: http://python-guide.readthedocs.io/en/latest/dev/virtualenvs/

## Security

The further down the gradient you come, the harder it gets to update
components of your package. Everything is more tightly bound
together. This doesn't necessarily mean that it's harder to update in
general, but it is still a consideration, when for years the approach
has been to have system administrators and other technicians handle
certain kinds of infrastructure updates.

For example, if a kernel security issue emerges, and you're deploying
containers, the host system's kernel can be updated without requiring
a new build on behalf of the application. If you deploy VM images,
you'll need a new build. Whether or not this dynamic makes one option
more secure is still a bit of an old debate, going back to the
still-unsettled matter of
[static versus dynamic linking][static_dynamic].

[static_dynamic]: https://www.google.com/search?channel=fs&q=static+vs+dynamic+linking

# Closing

Packaging in Python has a bit of a reputation for being a bumpy
ride. This is mostly a confused side effect of Python's
versatility. Once you understand the natural boundaries between each
packaging solution, you begin to realize that the varied landscape is
a small price Python programmers pay for using the most balanced,
flexible language available.

A summary of our lessons along the way:

1. Language does not define packaging, environment does. Python is
   general-purpose, PyPI is not.
2. Application packaging must not be confused with library
   packaging. Python is for both, but pip is for libraries.
3. Self-contained artifacts are the key to repeatable deploys.
4. Containment is a spectrum, from executable to installer to userspace
   image to virtual machine image to hardware. "Containers" are not
   just one thing, let alone the only option.

Now, with map in hand, you can safely navigate the rich terrain. The
Python packaging landscape is converging, but don't let that narrow
your focus. Every year seems to open new frontiers, challenging
existing practices for shipping Python.

<div style="text-align:center;"><img width="60%" src="/uploads/illo/snake_c_med.png"></div>

[^pypi]: Despite being called the Python Package Index, PyPI does not
         index packages. PyPI indexes distributions, which can contain
         one or more packages. For instance, pip installing Pillow
         allows you to import PIL. Pillow is the distribution, PIL is
         the package. The Pillow-PIL example also demonstrates how the
         distribution-package separation enables multiple
         implementations of the same API. Pillow is a fork of the
         original PIL package. Still, as most distributions only
         provide one package, please name your distribution after the
         package for consistency's sake.
