---
title: Cruising through complex data 
entry_root: cruising_through_data
---

*This post is a showcase of data wrangling techniques in Python, using [glom][glom]. 
If you haven't heard of glom, it's a data transformation library and CLI designed for Python. 
Think HTML templating, but for objects, dicts, and other data structures.*

It's been almost five years since [the first release of glom](/glom_restructured_data.html). 
That version now looks quaint in comparison to the just-released glom 23. 
Out of all the new functionality, we're going to take a look at six techniques 
that'll level up your complex data handling.


[glom]: https://glom.readthedocs.io/en/latest/

[TOC]

*NB: Throughout the post, you'll note examples linking to a site called [glompad][glompad]. 
Like so many regex and JS playgrounds, glompad is glom in the browser. 
Very much an alpha, I'll save the details for another post. 
In the meantime, try it out and let me know how it goes!*

[glompad]: https://yak.party/glompad/

# Star path selectors

Years in the making, glom's newest feature is one of the longest anticipated.
Since its first release, glom's deep get has excelled at fetching single values:

```python
target = {'a': {'b': {'c': 'd'}}}
glom(target, 'a.b.c')
# 'd'
```

As of the latest release, glom now does [glob][glob]-style `*` and `**` as path segments, 
aka wildcard expansion:

```python
glom({'a': [{'k': 'v1'}, {'k': 'v2'}]}, 'a.*.k')  # * is single-level
# ['v1', 'v2']

glom({'a': [{'k': 'v3'}, {'k': 'v4'}]}, '**.k')  # ** is recursive
# ['v3', 'v4']
```

[glob]: https://docs.python.org/3/library/glob.html

Notably, this is one of the only breaking features in glom's history. 
Star selectors were added as an option in glom 22, and baked for a year 
(with warnings for any users with stars in their paths) 
before becoming the default in glom 23.

# Deep assignment and deletion

By default, glom makes and returns new data structures. But glom's default immutable 
approach isn't always a perfect fit for the messy, deeply-nested structures one gets 
from scraped DOMs, ancient XML, or idiosyncratic API wrappers.

So one of glom's earliest additions, way back in 2018, 
enabled declarative deep assignments that would work across virtually all mutable Python objects. 
First with `Assign()` and the `assign()` [convenience function][conv_func] ([example][assign_ex], [docs][assign_docs]):

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

And for something more destructive, there's `Delete()` and `delete()` ([example][delete_ex], [docs][delete_docs]):

```python
target = {'a': [{'b': 'c'}, {'d': None}]}
delete(target, 'a.0.b')
# {'a': [{}, {'d': None}]}
```

`Assign()` and `Delete()` both shine when manipulating ElementTree-style documents from [etree][etree], [lxml][lxml], [html5lib][html5lib], and the like.

Like glom's other path-based functionality, the nuances of assigning Python `dict` keys, object attributes, and sequence indices are handled for you.
There's also an [extension system][registration] for adding support especially unique types.

[conv_func]: https://glom.readthedocs.io/en/latest/faq.html#what-s-a-convenience-function
[assign_ex]: https://yak.party/glompad/#spec=%23+Modify+a+dictionary+in-place.%0AAssign%28Path%28%22a%22%2C+%22e%22%29%2C+%22new+value%22%29%0A&target=%7B%22a%22%3A+%7B%22b%22%3A+%7B%22c%22%3A+%22d%22%7D%7D%7D%0A&v=1
[assign_backfill_ex]: https://yak.party/glompad/#spec=%23+Automatically+create+dicts+for+missing+keys.%0AAssign%28Path%28%22user%22%2C+%22contact%22%2C+%22email%22%29%2C+%22foobar%40example.com%22%2C+missing%3Ddict%29%0A&target=%7B%0A++++%22user%22%3A+%7B%0A++++++++%22location%22%3A+%7B%22city%22%3A+%22Berlin%22%2C+%22country%22%3A+%22DE%22%7D%2C%0A++++++++%22username%22%3A+%22foobar%22%2C%0A++++++++%22created%22%3A+1672950417%2C%0A++++%7D%0A%7D%0A&v=1
[assign_docs]: https://glom.readthedocs.io/en/latest/mutation.html#assignment
[delete_ex]: https://yak.party/glompad/#spec=Delete%28%27a.b.1%27%29&target=%7B%27a%27%3A+%7B%27b%27%3A+%5B5%2C+6%2C+7%5D%7D%7D&v=1
[delete_docs]: https://glom.readthedocs.io/en/latest/mutation.html#deletion
[registration]: https://glom.readthedocs.io/en/latest/api.html#setup-and-registration
[etree]: https://docs.python.org/3/library/xml.etree.elementtree.html
[lxml]: https://lxml.de/
[html5lib]: https://github.com/html5lib/html5lib-python

# The Data Trace

The main appeal of glom has always been succinct and robust data access and transformation. 
No single glom feature showcases this quite as much as the *data trace*.

Data traces make glom's errors far more debuggable than Python's default exceptions. 
You don't see internal glom or Python stack frames; just you, your code, and your data:

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
<a target="_blank" href="/uploads/data_trace_before_after.png"><img src="/uploads/data_trace_before_after.png" align="right" width="100%"></a>
</div>
<div><i>Failures before and after the data trace. Full text <a href="https://gist.github.com/mahmoud/a0923541c2c59c7cb167802c0d09a895">here</a>.</i></div>
</div>

One day I'll write a post about how tracebacks are an oft-neglected part of a library's interface.
The right traceback can turn an all-night debugging session into a quick fix anyone can push. 

For now, see the doc with examples and more explanation [here][glom_exc].

[glom_exc]: https://glom.readthedocs.io/en/latest/debugging.html#reading-a-glom-exception


# Pattern matching

While glom started as a data transformer, you often need to validate data before transforming it. 
Data validation fits nicely into spec format, and so glom's [`Match` specifier][match_spec] was born:

```python
# load some data
target = [{'id': 1, 'email': 'alice@example.com'}, 
          {'id': 2, 'email': 'bob@example.com'}]

# let's validate the data matches
spec = Match([{'id': int, 'email': str}])

result = glom(target, spec)
# result here is equal to the data itself
```

Glom's pattern matching now features its own shorthand [`M` spec][m_spec], which is great for quick guards, 
and a `Regex` helper, too:

```python
# using the example data above, we can be more specific
spec = Match([{'id': And(M > 0, int), 'email': Regex('[^@]+@[^@]+')}])

result = glom(target, spec)
# result here is again equal to the target data
```

Even a simple pattern matching example shows the power of the glom data trace. 
Check out the error message when some bad data gets added:

```python
>>> target.append({'id': '3', 'email': 'charlie@example.com'})
>>> result = glom(target, spec)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "../glom/core.py", line 2294, in glom
    raise err
glom.matching.TypeMatchError: error raised while processing, details below.
 Target-spec trace (most recent last):
 - Target: [{'email': 'alice@example.com', 'id': 1}, {'email': 'bob@example.com', 'id': 2}, {'ema... (len=3)
 - Spec: Match([{'email': str, 'id': int}])
 - Spec: [{'email': str, 'id': int}]
 - Target: {'email': 'charlie@example.com', 'id': '3'}
 - Spec: {'email': str, 'id': int}
 - Target: 'id'
 - Spec: 'id'
 - Target: '3'
 - Spec: int
glom.matching.TypeMatchError: expected type int, not str
```

The data trace gets even sweeter when we introduce flow control with Switch. 
See the data trace in action in [this example][switch_err_ex].
YUsers of shape-based typecheckers like [Flow][flow] will especially appreciate 
the specificity of glom's error messages in these validation cases.

[switch_err_ex]: https://yak.party/glompad/#spec=%23+let%27s+classify+vowels+vs+consonants+to+show+off+Switch%27s+error+handling%0AMatch%28Switch%28%5B%28Or%28%27a%27%2C+%27e%27%2C+%27i%27%2C+%27o%27%2C+%27u%27%29%2C+Val%28%27vowel%27%29%29%2C%0A++++++++++++++%28And%28str%2C+M%2C+M%28T%5B2%3A%5D%29+%3D%3D+%27%27%29%2C+Val%28%27consonant%27%29%29%5D%29%29&target=%23+An+integer+will+cause+the+expected+failure%0A3&v=1
[flow]: https://flow.org/

<!--

In mid-2020, some combination of PEG and Python 2's deprecation lit a fire of innovation, one of the most ambitious of which is now captured in [PEP 634](https://peps.python.org/pep-0634/), and implemented in Python 3.10's [Structural Pattern Matching](https://docs.python.org/3/whatsnew/3.10.html#pep-634-structural-pattern-matching).

-->

[m_spec]: https://glom.readthedocs.io/en/latest/matching.html#m-expressions
[switch]: https://glom.readthedocs.io/en/latest/matching.html#control-flow-with-switch
[match_spec]: https://glom.readthedocs.io/en/latest/matching.html#validation-with-match

# Streaming

For datasets too large to fit in memory, glom grew an `Iter()` specifier in 2019 ([example][iter_ex], [docs][iter_docs]). 
`Iter()` offers a readable chaining API that lazily creates nesting generators.

```python
target = [1, 2, None, None, 3, None, 3, None, 2, 4]

spec = Iter().filter().unique()  # this gives a streaming generator when evaluated
glom(target, spec.all())  # .all() converts the generator to a list
# [1, 2, 3, 4]
```

`Iter()`'s built-in methods also include [`.split()`][split_docs], [`.flatten()`][flatten_docs], [`.chunked()`][chunked_docs], [`.slice()`][slice_docs], [`.limit()`][limit_docs] among others. 
In short, endless possibilities for endless data.

[iter_ex]: https://yak.party/glompad/#spec=Iter%28%29.split%28%29.flatten%28%29.unique%28%29.all%28%29&target=%5B1%2C+2%2C+None%2C+None%2C+3%2C+None%2C+3%2C+None%2C+2%2C+4%5D&v=1
[iter_docs]: https://glom.readthedocs.io/en/latest/streaming.html#streaming-iteration 
[slice_docs]: https://glom.readthedocs.io/en/latest/streaming.html#glom.Iter.slice
[chunked_docs]: https://glom.readthedocs.io/en/latest/streaming.html#glom.Iter.chunked
[flatten_docs]: https://glom.readthedocs.io/en/latest/streaming.html#glom.Iter.flatten
[split_docs]: https://glom.readthedocs.io/en/latest/streaming.html#glom.Iter.split
[limit_docs]: https://glom.readthedocs.io/en/latest/streaming.html#glom.Iter.limit

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

With `Flatten` came the numeric [`Sum`][sum_docs], not unlike the builtin:

```python
glom(range(5), Sum())
# 15
```

And the generic [`Fold`][fold_docs], useful for some rare cases:
```
target = [set([1, 2]), set([3]), set([2, 4])]
result = glom(target, Fold(T, init=frozenset, op=frozenset.union))
# frozenset([1, 2, 3, 4])
```

A later release brought flattening to mappings, via `Merge` ([example][merge_ex], [docs][merge_docs]):

```python
target = [{'a': 'alpha'}, {'b': 'B'}, {'a': 'A'}]
merge(target)
# {'a': 'A', 'b': 'B'}
```

`Merge()` is great for deduping documents with a simple last-value-wins strategy.

[merge_ex]: https://yak.party/glompad/#spec=Merge%28%29&target=%5B%7B%27a%27%3A+%27alpha%27%7D%2C+%7B%27b%27%3A+%27B%27%7D%2C+%7B%27a%27%3A+%27A%27%7D%5D&v=1
[merge_docs]: https://glom.readthedocs.io/en/latest/grouping.html#glom.merge
[fold_docs]: https://glom.readthedocs.io/en/latest/grouping.html#glom.Fold
[sum_docs]: https://glom.readthedocs.io/en/latest/grouping.html#glom.Sum

# Other core updates

The features above, and myriad others from [the changelog][changelog], required multiple evolutions of the glom core. 
Underneath glom's hood is a loop that interprets the spec against the target. 
A simple, early version is preserved [here in the docs][glom_core]. 

However, the inner workings of the core are not part of glom's API, which limited extensibility. 
A lot of progress has been made in opening up glom internals for those use cases we couldn't predict.

[glom_core]: https://glom.readthedocs.io/en/latest/faq.html#how-does-glom-work
[changelog]: https://github.com/mahmoud/glom/blob/master/CHANGELOG.md

## Scope

Most glom usage only requires a target and spec. Most, but not all.

For cases that needed additional state, like aggregation and multi-target glomming, 
we added the glom `Scope` ([example][scope_ex], [docs][scope_docs]):

```python
count_spec = T.count(S.search)
glom(['a', 'c', 'a', 'b'], count_spec, scope={'search': 'a'})
# 2
```

Here, the scope is used to pass in a `search` parameter which will be used against the target (`T`).
Scope usage can get quite advanced, ([example][scope_update_ex]):

```python
target = {'data': {'val': 9}}

spec = (S(value=T['data']['val']), {'result': S['value']})

glom(target, spec)
# {'result': 9}
```

Here we grab `'val'`, save it to the scope as `'value'`, then finally build our new result.

[scope_ex]: https://yak.party/glompad/#spec=T.count%28S.search%29&target=%5B%27a%27%2C+%27c%27%2C+%27a%27%2C+%27b%27%5D&scope=%7B%27search%27%3A+%27a%27%7D&v=1
[scope_docs]: https://glom.readthedocs.io/en/latest/api.html#the-glom-scope
[scope_update_ex]: https://yak.party/glompad/#spec=%23+save+val+to+the+scope%2C+then+build+a+new+result+dict%0A%28S%28value%3DT%5B%27data%27%5D%5B%27val%27%5D%29%2C+%7B%27result%27%3A+S%5B%27value%27%5D%7D%29&target=%7B%27data%27%3A+%7B%27val%27%3A+9%7D%7D&v=1

## Modes

As discussed in [pattern matching](#pattern-matching) above, in 2019, some applications seemed 
to be outgrowing glom's initial data transformation behavior. 
To handle these diverging behaviors, glom introduced the concept of *modes*.

Glom specs stay succinct by using Python literals, and modes allow changing the interpretation of those objects. 
Glom comes with two documented modes, the default `Auto()` and `Match()` ([example][modes_ex]), and we're working on adding more. You can easily add your own, too.

[modes_ex]: https://yak.party/glompad/#spec=Auto%28%5BMatch%28int%2C+default%3DSKIP%29%5D%29&target=%5B1%2C+%27a%27%2C+2%2C+%27c%27%2C+%27a%27%2C+%27b%27%5D&v=1

## Extensions

We strive to make glom as widely applicable as possible, but data takes too many forms to count.
We solve this by making glom extensible in several ways:

* [Registering][register_docs] new target types and new operations on the target
* [Creating new Spec types][spec_type_docs]
* [Adding new modes][mode_docs]

By understanding glom's scope and [its internals][scope_internals], 
it becomes clear that most built-in glom functionality is implemented through these public interfaces.

[scope_internals]: https://glom.readthedocs.io/en/latest/custom_spec_types.html#the-glom-scope
[mode_docs]: https://glom.readthedocs.io/en/latest/modes.html
[spec_type_docs]: https://glom.readthedocs.io/en/latest/custom_spec_types.html
[register_docs]: https://glom.readthedocs.io/en/latest/api.html#setup-and-registration

------

Not bad for five years, and still, so much more to talk about. 
Hopefully the next showcase won't be quite so far out. 