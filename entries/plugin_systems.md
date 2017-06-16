---
title: Plugin Systems
---

*"What are plugins?" and other proceedings of the PyCon 2017
 Comparative Plugin Systems BoF*

Within the programming world, and with Python in particular, there are
a lot of presumptions around plugins. Maybe it's just the diminutive
name making plugins sound so small, but we take them for granted. "Oh,
it's just a plugin," they say, as we all roll our eyes. But the effect
and necessity of plugins is profound.

Revisiting plugins may be the best programming decision I've made this
year.

For all manner of growing software, open-source or otherwise, scaling
development poses a problem long before scaling performance. Involving
more developers and more teams creates code contention and bugs. Too
many cooks is all it takes to spoil the broth.

What all growing projects need is an API for code integration. Call
them plugins, or extensions, they are *the* widely successful
solution. The only thing wider than plugin systems' success is the
variety of their implementations.

The dynamism of Python in particular seems to encourage
inventiveness. More is usually merrier, but not when it further clouds
a tricky space. How wide is the range of functionalities, really? How
different could these plugin systems be?  How does one choose the
right one for them? For that matter, what is a plugin system anyway?
No one I talked to had clear answers.

So when PyCon 2017 rolled around, I knew exactly what I wanted to do:
call together a team of developers to get to the bottom of the
matter. We would answer the questions the above, or at least answer
the question, "What happens when you ask a group of 20 veteran Python
programmers about plugins?"

# Setting examples

Our group started by listing off plugin systems as fast as we could:

* stevedore
* twisted.plugin
* pytest plugins (pluggy)
* gather
* venussian
* pluginbase
* straight.plugin
* pylint plugins
* flake8 plugins
* pyramid configurator includes
* raw setuptools entrypoints
* zope.component
* Django command extensions
* SQLAlchemy driver system
* Sphinx
* Buildout extensions
* Pike
* Others that came and went a little too fast to jot down

With a list like this, we were ready to start getting into our big
questions.

# Taxonomizing

For our first bit of analysis, we asked: What are the practical and
fundamental attributes that differentiate these approaches?

## Discovery

Plugin systems' first job is locating plugins to load. The split here
is whether plugins are individually specified, or automatically
discovered based on paths and patterns.

In either case, paths are required. By providing search functionality,
automatic discovery trades explicitness for an amount of convenience
that often justifies the complexity.

## Generalizability

You'll notice plugin systems did not have to be generalizable to be
included. Many projects simply use a specialized, or even internal,
plugin system to achieve better factoring. Bespoke plugin systems are
still relevant as reference for anyone looking to discover patterns
and maybe build their own system, generic or not. We wanted to cast
the widest net possible for valuable lessons in code factoring.

The first attribute that jumped out was quite practical: Whether the
system designed for reuse outside of a project. For instance, gather
is, but pylint's system isn't.

## Install location

Our next key differentiator was the degree to which the plugin system
leveraged Python's own package management systems. Some systems, like
gather, were designed to encourage `pip install`-ing plugins, locating
them in a `site-packages` directory alongside the plugin system
itself.

Other systems have their own search paths, putting plugins in the
application tree, as is the case with Django apps, or set paths in the
user directory, and elswhere on the filesystem.

## Plugin independence

One of the most challenging parts of plugin development is finding
ways of independently reusing and testing code, while keeping in mind
its role as an optional component of another application.

In some systems, the tailoring is so tightly coupled that reusability
doesn't make sense. But others are more targeted at being
independently reusable. For instance, a command-line tool with
subcommands that are themselves independently usable, as seen with
conda and conda-build (TODO).

## Dependency registration

Almost all plugins work by providing some set of *hooks* or data, the
core knows to look for and use when appropriate. Another
differentiator we found had to do with whether and how plugins could
request resources from the core, and even other plugins. Not all
systems support this, but many that do simply pass the whole core
state, with access to everything, at the time of hook invocation. More
advanced systems allow plugins to publish an inventory of
requirements. More structure here leads to tighter and cleaner
architecture for the application as a whole.

# Drawing a line

Feeling like we were getting closer to the nature of things, we asked
the question: What is a plugin system? And to answer it, we had to
ask: What _isn't_ a plugin system? Establishing explicit boundaries
and specific counterexamples proved instrumental to producing a final
definition.

Is `eval()` a plugin system? We thought maybe, at first. But the more
we thought about it, no, because the code itself was not sufficiently
abstracted through a loading or namespacing system.

Is DNS a plugin system? It has names and namespaces galore. But no,
because code is not being loaded *in*. Remote services in general are
beyond the boundary of what a plugin can be. They exist out there, and
we call out to them. They're plugins, not callouts.

# A definition

So with our boundaries established, we were ready to offer a
definition: A plugin system is a software facility that enables
identifying and subsequent loading of code into a running program.

But wait, by this definition, isn't Python's built-in "import"
functionality a plugin system? Why, yes! Python's import system is an
import system. A quite extensible and powerful one.

For discovery it uses the PYTHONPATH, various "site" directories and
files, and much more, especially where custom loaders are concerned.

For installation, it uses site-packages, users' `.local` trees, and more.

As far as independence, virtually every script is trivially its own
entrypoint.

And when it comes to registration, the Python core doesn't offer much
beyond the base import system. Your module is loaded and tossed into
`sys.modules` with the others.

# Motivation

And yet, this proximate cause still doesn't provide an ultimate
motivation behind plugins. To complete the circle, we return to one of
the software fundamentals: Separation of concerns.

We want to reason about our software. We want to know what state it is
in. What we all want is the ability to say, "the core is ready,
proceeding to load modules/extensions/plugins." We want to defer
loading _some_ code so that we can add extra instrumentation, checks,
resiliency, and error messages to that loading process.

Because we have no choice but to reach for the Python import system as
soon as we open a new file, `import`'s capacity as a deferred
code-loading abstraction has already been somewhat diminished. The
more a system piggybacks on the Python import system, the more it
smudges the boundary that separates our concerns and the harder it can
be to add our extra instrumentation.

# In conclusion

So now we have achieved a complete view of the Python plugin system
ecosystem, from motivation to manifestation.

By sheer numbers it may seem like there is no shortage of Python
plugin systems. But looking at the basic taxonomy above, it's clear
that there are several gaps still waiting to be filled.

By taking a holistic look at the implementations and motivations, the
PyCon 2017 Plugins open session reached a conclusion that even this
wide selection merits additional expansion. So go forth and build, and
continue to build! The future of well-factored code depends on it.[^further]

[^further]: For additional reading, I recommend doing what we did
            after our discussion, finding and reading
            [this post from Eli Bendersky][bender_post]. While it
            focuses more on specific implementations and less about
            generalized systems, Eli's post overlaps in many very
            reaffirming ways, much to our relief and
            gratifications. The worked example of building
            ReStructured Text plugins is a perfect complement to the
            post above.

[bender_post]: http://eli.thegreenplace.net/2012/08/07/fundamental-concepts-of-plugin-infrastructures


<!-- Resiliency? Whether or not loading a failed plugin load was fatal
to the rest of the application -->
