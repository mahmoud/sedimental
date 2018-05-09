---
title: "Announcing glom: Restructured Data for Python"
entry_root: glom_restructured_data
---

[TOC]

# The Spectre of Structure

In the Python world, there's a saying: "Flat is better than nested."

Well, maybe times have changed or maybe that adage just applies more
to code than data. In any case, despite the warning, nested data
continues to grow, from document stores to RPC systems to structured
logs to plain ol' JSON.

Besides, if "flat" had been all that great, Python wouldn't have
modules and namespaces.

Nested data is tricky though. If you're not careful, picking and
choosing from deep inside structured data you can get some ugly
errors. Consider this simple line:

```python
value = target.a['b']['c']
```

That single, simple line can result in at least four different
exceptions, each less helpful than the last:

```python
AttributeError: 'TargetType' object has no attribute 'a'
KeyError: 'b'
TypeError: 'NoneType' object has no attribute '__getitem__'
TypeError: list indices must be integers, not str
```

Clearly, we need our tools to catch up to our nested data.

Enter **glom**.

# Restructuring Data

glom is a new approach to working with data in Python featuring:

* [Path-based access](http://glom.readthedocs.io/en/latest/tutorial.html#access-granted) for nested structures
* [Declarative data transformation](http://glom.readthedocs.io/en/latest/api.html#glom-func) using lightweight, Pythonic specifications
* Readable, meaningful [error messages](http://glom.readthedocs.io/en/latest/api.html#exceptions)
* Built-in [data exploration and debugging features](http://glom.readthedocs.io/en/latest/api.html#debugging)

A tool as simple and powerful as glom attracts many comparisons. While
similarities exist, and are often intentional, glom differs from other
offerings in a few ways:

## Going Beyond Access

Many nested data tools simply perform deep gets and searches, stopping
short after solving the problem posed above. Realizing that access
almost always precedes assignment, glom takes the paradigm further,
enabling total declarative transformation of the data.

By way of introduction, let's start off with access, the classic
"deep-get":

```python
from glom import glom

target = {'galaxy': {'system': {'planet': 'earth'}}}
spec = 'galaxy.system.planet'

output = glom(target, spec)
# output = 'earth'
```

Some quick terminology:

* *target* is our data, be it dict, list, or any other object
* *spec* is what we want *output* to be

With `output = glom(target, spec)` committed to memory, we've got some
new requirements.

Our astronomers want to focus in on the solar system, and represent
planets as a list. We need a list of names:

```python
target = {'system': {'planets': [{'name': 'earth'}, {'name': 'jupiter'}]}}

glom(target, ('system.planets', ['name']))
# ['earth', 'jupiter']
```

And let's say we want to capture a parallel list of moon counts with
the names as well:

```python
target = {'system': {'planets': [{'name': 'earth', 'moons': 1},
                                 {'name': 'jupiter', 'moons': 69}]}}

glom(target, {'names': ('system.planet', ['names']), 'moons': ('system.planet', ['moons'])})
# {'planets': ['earth', 'jupiter'], 'moons': [1, 69]}
```

We can react to changing data requirements as fast as the data itself
can change, despite its nested nature. And we're just getting started.

## True Python-Native

Most other implementations are limited to a particular data format or
a pure model, be it jmespath or XPath/XSLT. glom makes no such
sacrifices of practicality, harnessing the full power of Python
itself.

Going back to our example, let's say we wanted to get an aggregate
moon count:

```python
glom(target, {'moon_count': ('system.planet', ['moons'], sum)})
# {'moon_count': 70}
```

With glom, you have full access to Python at any given moment. Pass
values to functions, whether built-in, imported, or an inline
lambda. But we don't stop there.

Now we get to one of my favorite features by far. Leaning into
Python's power, we unlock the following syntax:

```python
from glom import T

spec = T['system']['planets'][-1].values()

glom(target, spec)
# ['jupiter', 69]
```

`T` stands for *target*, and it is your data's stunt double. `T`
records every key you get, every index you index, every attribute you
access, and every method you call into a spec that's usable like any
other.

No more worrying if an attribute is `None` or a key isn't set. Take
that leap with `T`, and if you're ok with the data not being there,
just set a default:

```python
glom(target, T['system']['comets'][-1], default=None)
```

This kind of dynamism is what made me fall in love with Python. No
other language could do it quite like this.

That's why glom will always be a Python library first and a CLI
second. Oh, didn't I mention there was a CLI?

## Library first, then CLI

Tools like jq provide a lot of value on the console, but leave a
dubious path forward for further integration. glom's full-featured
command-line interface is only a stepping stone to using it more
extensively inside application logic.

```text
$ pip install glom
$ curl -s https://api.github.com/repos/mahmoud/glom/events \
  | glom '[{"type": "type", "date": "created_at", "user": "actor.login"}]'

####

[
  {
    "date": "2018-05-09T03:39:44Z",
    "type": "WatchEvent",
    "user": "asapzacy"
  },
  {
    "date": "2018-05-08T22:51:46Z",
    "type": "WatchEvent",
    "user": "CameronCairns"
  },
  {
    "date": "2018-05-08T03:27:27Z",
    "type": "PushEvent",
    "user": "mahmoud"
  },
  {
    "date": "2018-05-08T03:27:27Z",
    "type": "PullRequestEvent",
    "user": "mahmoud"
  }
...
]
```

Piping hot JSON into glom with a cool JSON spec, with pretty-printed
JSON out. A great way to process and filter API calls, and explore
some data. Something genuinely enjoyable, because you know you won't
be stuck in this pipe dream.

Everything on the command line ports directly into production-grade
Python, complete with better error handling and limitless integration
possibilities.

# Next steps

Never before glom have I put a piece of code into production so quickly.

Within two weeks of the first commit, glom has paid its weight in
gold, with glom specs replacing [Django Rest Framework][drf] code 2x
to 5x their size, making the codebase faster and more
readable. Meanwhile, glom's core is so tight that we're on pace to
have more docs and tests than code very soon.

The `glom()` function is stable, along with the rest of the API,
unless otherwise specified.

A lot of other features are baking or in the works. For now, we'll
be focusing on the following growth areas:

* Validation functionality, in the vein of schema and cerberus
* CLI robustness, better error messages, etc.
* Extension API, clean up some internal code, open up extensions
* Automatic default registration of default behaviors for co-installed packages (e.g., Django)

I hope you'll try glom out and let us know how it goes!

[drf]: http://www.django-rest-framework.org/


# The Story of glom

* A couple years ago I built `remap`, a `map()` function for trees of Python objects
* It didn't solve all my problems because it's mostly for cases where
  you don't know much about the structure of data
* While building Montage, we tried using the "fat model" approach of
  teaching objects to serialize themselves, but this didn't compose
  well. Every API endpoint needed slightly different data
* Then it dawned on me, what we needed was templating, but for basic
  objects like dicts, lists, etc., so that we could declaratively
  create JSON-serializable API responses.
* Taking inspiration from lightweight templating languages like
  `gofmt` and `ashes`, we built the first version of glom.
