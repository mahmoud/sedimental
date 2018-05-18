---
title: "Announcing glom: Restructured Data for Python"
entry_root: glom_restructured_data
publish_date: 10:00am May 9, 2018
tags:
  - python
  - data
  - boltons
---

*This post introduces [**glom**][glom_gh],
Python's missing operator for nested objects and data.*

*If you're an easy sell, [full API docs][api_rtd] and
[tutorial][tut_rtd] are already available at
[glom.readthedocs.io][glom_rtd]. <br/>
Harder sells, this 5-minute post is for you.<br/>
Really hard sells [met me at PyCon][pycon_bofs],<br/>
where I gave [this 5-minute talk][pycon_talk].*

[glom_gh]: https://github.com/mahmoud/glom
[glom_rtd]: https://glom.readthedocs.io/
[api_rtd]: http://glom.readthedocs.io/en/latest/api.html
[tut_rtd]: http://glom.readthedocs.io/en/latest/tutorial.html
[pycon_talk]: https://www.youtube.com/watch?v=3aREXkfeWek

<img src="/uploads/illo/comet.png" align="right" width="30%">

# The Spectre of Structure

In the Python world, there's a saying: *"Flat is better than nested."*

Maybe times have changed or maybe that adage just applies more to code
than data. In spite of the warning, nested data continues to grow,
from document stores to RPC systems to structured logs to plain ol'
JSON web services.

After all, if "flat" was the be-all-end-all, why would namespaces be
[one honking great idea][pep20]? Nobody likes artificial flatness, nobody wants
to call a function with 40 arguments.

[pep20]: https://en.wikipedia.org/wiki/Zen_of_Python

Nested data is tricky though. Reaching into deeply structured data can
get you some ugly errors. Consider this simple line:

```python
value = target.a['b']['c']
```

That single line can result in at least four different exceptions,
each less helpful than the last:

```python
AttributeError: 'TargetType' object has no attribute 'a'
KeyError: 'b'
TypeError: 'NoneType' object has no attribute '__getitem__'
TypeError: list indices must be integers, not str
```

Clearly, we need our tools to catch up to our nested data.

Enter **glom**.

# Restructuring Data

[glom][glom_gh] is a new approach to working with data in Python, featuring:

* [Path-based access](http://glom.readthedocs.io/en/latest/tutorial.html#access-granted) for nested structures
* [Declarative data transformation](http://glom.readthedocs.io/en/latest/api.html#glom-func) using lightweight, Pythonic specifications
* Readable, meaningful [error messages](http://glom.readthedocs.io/en/latest/api.html#exceptions)
* Built-in [data exploration and debugging features](http://glom.readthedocs.io/en/latest/api.html#debugging)

A tool as simple and powerful as glom [attracts many
comparisons][analogy_rtd].

[analogy_rtd]: http://glom.readthedocs.io/en/latest/by_analogy.html

While similarities exist, and are often intentional, glom differs from
other offerings in a few ways:

## Going Beyond Access

Many nested data tools simply perform deep gets and searches, stopping
short after solving the problem posed above. Realizing that access
almost always precedes assignment, glom takes the paradigm further,
enabling total declarative transformation of the data.

By way of introduction, let's start off with space-age access, the
classic "deep-get":

<img src="/uploads/illo/mjc/jupiter_med.png" align="right" width="30%">

```python
from glom import glom

target = {'galaxy': {'system': {'planet': 'jupiter'}}}
spec = 'galaxy.system.planet'

output = glom(target, spec)
# output = 'jupiter'
```

Some quick terminology:

* *target* is our data, be it dict, list, or any other object
* *spec* is what we want *output* to be

With `output = glom(target, spec)` committed to memory, we're ready
for some new requirements.

Our astronomers want to focus in on the Solar system, and represent
planets as a list. Let's restructure the data to make a list of names:

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

spec = {'names': ('system.planets', ['name']),
        'moons': ('system.planets', ['moons'])}

glom(target, spec)
# {'names': ['earth', 'jupiter'], 'moons': [1, 69]}
```

We can react to changing data requirements as fast as the data itself
can change, naturally restructuring our results, despite the input's
nested nature. Like a list comprehension, but for nested data, our
code mirrors our output.

And we're just getting started.

## True Python-Native

Most other implementations are limited to a particular data format or
pure model, be it [jmespath][jmespath] or
[XPath][xpath]/[XSLT][xslt]. glom makes no such sacrifices of
practicality, harnessing the full power of Python itself.

[jmespath]: http://jmespath.org/
[xpath]: https://en.wikipedia.org/wiki/XPath
[xslt]: https://en.wikipedia.org/wiki/XSLT

Going back to our example, let's say we wanted to get an aggregate
moon count:

```python
target = {'system': {'planets': [{'name': 'earth', 'moons': 1},
                                 {'name': 'jupiter', 'moons': 69}]}}


glom(target, {'moon_count': ('system.planets', ['moons'], sum)})
# {'moon_count': 70}
```

With glom, you have full access to Python at any given moment. Pass
values to functions, whether built-in, imported, or defined inline
with `lambda`. But `glom` doesn't stop there.

Now we get to one of my favorite features by far. Leaning into
Python's power, we unlock the following syntax:

```python
from glom import T

spec = T['system']['planets'][-1].values()

glom(target, spec)
# ['jupiter', 69]
```

What just happened?

`T` stands for *target*, and [it acts as your data's stunt
double][t_rtd]. `T` records every key you get, every attribute you
access, every index you index, and every method you call. And out
comes a spec that's usable like any other.

[t_rtd]: http://glom.readthedocs.io/en/latest/api.html#object-oriented-access-and-method-calls-with-t

No more worrying if an attribute is `None` or a key isn't set. Take
that leap with `T`. `T` never raises an exception, so worst case you
get a [meaningful error message][exc_rtd] when you run `glom()` on it.

And if you're ok with the data not being there, just set a default:

```python
glom(target, T['system']['comets'][-1], default=None)
# None
```

Finally, [null-coalescing operators][ncop] for Python!

But so much more. This kind of dynamism is what made me fall in love
with Python. No other language could do it quite like this.

[ncop]: https://en.wikipedia.org/wiki/Null_coalescing_operator
[exc_rtd]: http://glom.readthedocs.io/en/latest/api.html#exceptions

That's why glom will always be a Python library first and a CLI
second. Oh, didn't I mention there was a CLI?

## Library first, then CLI

Tools like [jq][jq] provide a lot of value on the console, but leave a
dubious path forward for further integration. glom's full-featured
command-line interface is only a stepping stone to using it more
extensively inside application logic.

[jq]: https://stedolan.github.io/jq/

```bash
$ pip install glom
$ curl -s https://api.github.com/repos/mahmoud/glom/events \
  | glom '[{"type": "type", "date": "created_at", "user": "actor.login"}]'
```

Which gets us:

```json
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

Piping hot JSON into ``glom`` with a cool Python literal spec, with
pretty-printed JSON out. A great way to process and filter API calls,
and explore some data. Something genuinely enjoyable, because you know
you won't be stuck in this pipe dream.

Everything on the command line ports directly into production-grade
Python, complete with better error handling and limitless integration
possibilities.

<img src="/uploads/illo/comet_multi.png" align="right" width="40%">

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

* [Validation functionality][validation_i], in the vein of schema and cerberus
* [CLI robustness][cli_i], better error messages, etc.
* [Extension API][ext_i], clean up some internal code, open up extensions
* [Automatic default registration][autoreg_i] of default behaviors for co-installed packages (e.g., Django)

We'll be talking about all of this and more [at PyCon][pycon_bofs], so
swing by if you can. In either case, I hope you'll try glom out and
let us know how it goes!

[drf]: http://www.django-rest-framework.org/
[validation_i]: https://github.com/mahmoud/glom/issues/7
[cli_i]: https://github.com/mahmoud/glom/issues/8
[ext_i]: https://github.com/mahmoud/glom/issues/9
[autoreg_i]: https://github.com/mahmoud/glom/issues/10
[pycon_bofs]: https://twitter.com/mhashemi/status/994111054702522369

<!--

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

-->
