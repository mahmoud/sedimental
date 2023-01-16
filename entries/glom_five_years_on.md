---
title: Glom Five Years On
---

It's been almost five years since [the first release of glom](/glom_restructured_data.html), a Python-native data transformer. That version now looks quaint in comparison to the just-released glom 23.

Just how far has glom come? Let's take a quick tour.

[TOC]

# Data trace

The main motivation to use glom has always been succinct and robust data access and transformation. No single glom feature has gone quite as far toward this goal as the *data trace*.

Data traces took glom's errors beyond Python's built-in exception handling by eliminating the largely irrelevant default traceback, and replacing it with a custom stack trace. You don't see glom's internal stack frames; just you, your code, and your data:

```python

>>> target = {'planets': [{'name': 'earth', 'moons': 1}]}
>>> spec = ('planets', ['rings'])  # a spec we expect to fail
>>> glom(target, spec)
 Traceback (most recent call last):
   File "<stdin>", line 1, in <module>
   File "/home/mahmoud/projects/glom/glom/core.py", line 1787, in glom
     raise err
 glom.core.PathAccessError: error raised while processing, details below.
  Target-spec trace (most recent last):
  - Target: {'planets': [{'name': 'earth', 'moons': 1}]}
  - Spec: ('planets', ['rings'])
  - Spec: 'planets'
  - Target: [{'name': 'earth', 'moons': 1}]
  - Spec: ['rings']
  - Target: {'name': 'earth', 'moons': 1}
  - Spec: 'rings'
 glom.core.PathAccessError: could not access 'rings', part 0 of Path('rings'), got error: KeyError('rings')

```

<div style="float: right; width: 40%; margin-left: 10px; padding: 5px; border: 1px solid silver;">
<div style="width: 100%">
<img src="/uploads/data_trace_before_after.png" align="right" width="100%">
</div>
<div><i>See the before and after <a href="https://gist.github.com/mahmoud/a0923541c2c59c7cb167802c0d09a895">here</a>.</i></div>
</div>

One day I'll write a post about how tracebacks are an oft-neglected part of a library's interface. 

For now, see the doc with examples and more explanation [here][glom_exc].

[glom_exc]: https://glom.readthedocs.io/en/latest/debugging.html#reading-a-glom-exception
[data_trace_gist]: 

# Star path selectors

Years in the making, star selectors are glom's newest and historically most-requested feature. Glom now supports [glob][glob]-style `*` and `**` expansion. `*` is single-level, and `**` is recursive.

[glob]: https://docs.python.org/3/library/glob.html

Notably, this is one of the only breaking features in glom's history. It only affects paths that have stars as keys. We added star selectors as an option in glom 22, and let it bake a year before it became the default in glom 23.

# Pattern matching

While glom started as a data transformer, you often need to validate data before transforming it. Data validation also takes the form of specification, and so glom's [`Match` specifier][match_spec] was born.

Glom's pattern matching now features its own shorthand [`M` spec][m_spec], which is great for quick guards, and supports branching with the powerful [`Switch` specifier][switch]. The Switch spec in particular shows off the power of the glom data trace. Check out the error message when matching an integer against a spec built for strings.

<!--

In mid-2020, some combination of PEG and Python 2's deprecation lit a fire of innovation, one of the most ambitious of which is now captured in [PEP 634](https://peps.python.org/pep-0634/), and implemented in Python 3.10's [Structural Pattern Matching](https://docs.python.org/3/whatsnew/3.10.html#pep-634-structural-pattern-matching).

-->

[m_spec]: https://glom.readthedocs.io/en/latest/matching.html#m-expressions
[switch]: https://glom.readthedocs.io/en/latest/matching.html#control-flow-with-switch
[match_spec]: https://glom.readthedocs.io/en/latest/matching.html#validation-with-match

# Streaming

For datasets too large to fit in memory, glom grew an `Iter()` specifier in 2019 ([example][iter_ex], [docs][iter_docs]). `Iter()` offers a readable chaining API that lazily creates nesting generators.

```python
target = [1, 2, None, None, 3, None, 3, None, 2, 4]

spec = Iter().filter().unique().all()

glom(target, spec)
# [1, 2, 3, 4]
```

[iter_ex]: https://yak.party/glompad/#spec=Iter%28%29.split%28%29.flatten%28%29.unique%28%29.all%28%29&target=%5B1%2C+2%2C+None%2C+None%2C+3%2C+None%2C+3%2C+None%2C+2%2C+4%5D&v=1
[iter_docs]: https://glom.readthedocs.io/en/latest/streaming.html#streaming-iteration 

# Deep assignment and deletion

Some of the trickiest and most deeply-nested data is inherited data. 
Users quickly reminded us that when dealing with scraped DOMs, ancient XML, or idiosyncratic JSON wrappers, 
glom's default immutable approach isn't always a perfect fit.

So one of our earliest features, way back in 2018, 
was to enable declarative deep assignments that would work across virtually all mutable Python objects. 
First with `Assign()` and `assign()` ([example][assign_ex], [docs][assign_docs]):

```python
target = {'a': [{'b': 'c'}, {'d': None}]}
assign(target, 'a.1.d', 'e')  # let's give 'd' a value of 'e'
# {'a': [{'b': 'c'}, {'d': 'e'}]}
```

`Assign` also unlocked a super useful pattern of 
automatically creating nested objects without the need for `defaultdict` and friends ([example][assign_backfill_ex]):

```python
target = {}
assign(target, 'a.b.c', 'hi', missing=dict)
# {'a': {'b': {'c': 'hi'}}}
```

Then, in 2020, we added `Delete()` and `delete()` ([example][delete_ex], [docs][delete_docs]):

```python
target = {'a': [{'b': 'c'}, {'d': None}]}
delete(target, 'a.0.b')
# {'a': [{}, {'d': None}]}
```

Like glom's other path-based functionality, the nuances of Python `dict` keys, object attributes, and sequence indices are handled for you, with an [extension system][registration] for adding support for even the oddest types. 

Here's an example of adding simple iterable support for Django's ORM:

```python
import glom
import django.db.models

glom.register(django.db.models.Manager, iterate=lambda m: m.all())
glom.register(django.db.models.QuerySet, iterate=lambda qs: qs.all())
```


[assign_ex]: https://yak.party/glompad/#spec=%23+Modify+a+dictionary+in-place.%0AAssign%28Path%28%22a%22%2C+%22e%22%29%2C+%22new+value%22%29%0A&target=%7B%22a%22%3A+%7B%22b%22%3A+%7B%22c%22%3A+%22d%22%7D%7D%7D%0A&v=1
[assign_backfill_ex]: https://yak.party/glompad/#spec=%23+Automatically+create+dicts+for+missing+keys.%0AAssign%28Path%28%22user%22%2C+%22contact%22%2C+%22email%22%29%2C+%22foobar%40example.com%22%2C+missing%3Ddict%29%0A&target=%7B%0A++++%22user%22%3A+%7B%0A++++++++%22location%22%3A+%7B%22city%22%3A+%22Berlin%22%2C+%22country%22%3A+%22DE%22%7D%2C%0A++++++++%22username%22%3A+%22foobar%22%2C%0A++++++++%22created%22%3A+1672950417%2C%0A++++%7D%0A%7D%0A&v=1
[assign_docs]: https://glom.readthedocs.io/en/latest/mutation.html#assignment
[delete_ex]: https://yak.party/glompad/#spec=Delete%28%27a.b.1%27%29&target=%7B%27a%27%3A+%7B%27b%27%3A+%5B5%2C+6%2C+7%5D%7D%7D&v=1
[delete_docs]: https://glom.readthedocs.io/en/latest/mutation.html#deletion
[registration]: https://glom.readthedocs.io/en/latest/api.html#setup-and-registration

# Grouping

So much data revolves around iterables that in 2019 glom grew the ability to "reduce" those iterables to flatter values, with the introduction of `Flatten` ([example][flatten_ex], [docs][flatten_docs]):

```python
list_of_iterables = [{0}, [1, 2, 3], (4, 5)]
flatten(list_of_iterables)
# [0, 1, 2, 3, 4, 5]
```

Even a mix of iterables (iterators, lists, tuples) combines nicely.

[flatten_docs]: https://glom.readthedocs.io/en/latest/grouping.html#glom.flatten
[flatten_ex]: https://yak.party/glompad/#spec=Flatten%28%29&target=%5B%7B0%7D%2C+%5B1%2C+2%2C+3%5D%2C+%284%2C+5%29%5D&v=1)

With `Flatten` came the numeric `Sum` and the general `Fold`. 
A later release brought flattening to mappings, via `Merge` ([example][merge_ex], [docs][merge_docs]):

```python
target = [{'a': 'alpha'}, {'b': 'B'}, {'a': 'A'}]
merge(target)
# {'a': 'A', 'b': 'B'}
```

[merge_ex]: https://yak.party/glompad/#spec=Merge%28%29&target=%5B%7B%27a%27%3A+%27alpha%27%7D%2C+%7B%27b%27%3A+%27B%27%7D%2C+%7B%27a%27%3A+%27A%27%7D%5D&v=1
[merge_docs]: https://glom.readthedocs.io/en/latest/grouping.html#glom.merge

# Other core updates

The features above, and myriad others from the changelog, required multiple evolutions of the glom core. 
Mostly making it smaller so that glom's internals could be used for use cases we couldn't predict.

## Scope

Most glom usage only requires a target and spec. Most, but not all.

For cases that needed additional state, like aggregation and multi-target glomming, 
we added the glom `Scope` ([example][scope_ex], [docs][scope_docs]):

```python
count_spec = T.count(S.search)
glom(['a', 'c', 'a', 'b'], count_spec, scope={'search': 'a'})
# 2
```

[scope_ex]: https://yak.party/glompad/#spec=T.count%28S.search%29&target=%5B%27a%27%2C+%27c%27%2C+%27a%27%2C+%27b%27%5D&scope=%7B%27search%27%3A+%27a%27%7D&v=1
[scope_docs]: https://glom.readthedocs.io/en/latest/api.html#the-glom-scope

## Extensions

We strive to make glom as widely applicable as possible, but data takes too many forms to count. We solve this by making glom extensible in several ways:

* Registering new target types
* Registering new operations on the target
* Creating new type of Specifiers

By understanding glom's scope and [its internals][scope_internals], 
it becomes clear that most "built-in" glom functionality is implemented through these interfaces.

[scope_internals]: https://glom.readthedocs.io/en/latest/custom_spec_types.html#the-glom-scope

## Modes

As discussed in [pattern matching](#pattern-matching) above, in 2019, some applications seemed 
to be outgrowing glom's initial data transformation behavior. To handle these diverging behaviors, 
we took inspiration from emacs and introduced the concept of *modes*. 

Glom specs stay succinct by using Python literals, and modes allow changing the interpretation of those objects. 
Glom comes with two documented modes, the default `Auto()` and `Match()` ([example][modes_ex]), and we're working on adding more. 

You don't have to wait for us, though. If you have an idea for a new mode, the docs feature a guide to writing modes [here](https://glom.readthedocs.io/en/latest/modes.html).

[modes_ex]: https://yak.party/glompad/#spec=Auto%28%5BMatch%28int%2C+default%3DSKIP%29%5D%29&target=%5B1%2C+%27a%27%2C+2%2C+%27c%27%2C+%27a%27%2C+%27b%27%5D&scope=%7B%27search%27%3A+%27a%27%7D&v=1


# glompad

If you've made it this far, you may have noticed that some examples link to a site called glompad. Like so many regex and JS playgrounds, it's glom in the browser. Very much beta quality, I'll save the details for another post. In the meantime, try it out and let me know how it goes!