---
title: 'Remap: Nested Data Multitool for Python'
---

> *This entry is the first in a series of "cookbooklets" showcasing
> some of the more advanced [Boltons][boltons]. If all goes well, the
> next 5 minutes will literally save you 5 hours.*

[TOC]


[boltons]: https://boltons.readthedocs.org

# Intro

Data is everywhere, especially within itself. That's right, whether
it's public APIs, document stores, or plain old configuration files,
data *will* nest. And that nested data will find you.

[UI fads][flat_design] aside, developers have always liked
"flat". Even Python, so often turned to for data wrangling, only has
succinct built-in constructs for dealing with flat
data. [List comprehensions][list_comps],
[generator expressions][gen_exp], [map][map]/[filter][filter], and
[itertools][itertools] are all built for flat work. In fact, the
allure of flat data is likely a direct result of this common gap in
most programming languages.

<a href="https://commons.wikimedia.org/wiki/File:Russian-Matroshka2.jpg">
<img width="45%" src="/uploads/Russian-Matroshka2.jpg">
</a>

[flat_design]: https://en.wikipedia.org/wiki/Flat_design
[list_comps]: https://docs.python.org/2/tutorial/datastructures.html#list-comprehensions
[gen_exp]: https://docs.python.org/2/reference/expressions.html#generator-expressions
[map]: https://docs.python.org/2/library/functions.html#map
[filter]: https://docs.python.org/2/library/functions.html#filter
[itertools]: https://docs.python.org/2/library/itertools.html

So let's meet this nested adversary. Provided you overlook my taste in
media, it's hard to fault nested data when it reads as well as this [YAML][yaml]:

[yaml]: https://en.wikipedia.org/wiki/YAML

```yaml
reviews:
  shows:
    - title: Star Trek - The Next Generation
      rating: 10
      review: Episodic AND deep. <3 Data.
      tags: ['space']
    - title: Monty Python's Flying Circus
      rating: 10
      tags: ['comedy']
  movies:
    - title: The Hitchiker's Guide to the Galaxy
      rating: 6
      review: So great to see Mos Def getting good work.
      tags: ['comedy', 'space', 'life']
    - title: Monty Python's Meaning of Life
      rating: 7
      review: Better than Brian, but not a Holy Grail, nor Completely Different.
      tags: ['comedy', 'life']
      prologue:
        title: The Crimson Permanent Assurance
        rating: 9
```

And yet even this very straightforwardly nested data can be a real
hassle to manipulate. How would one add a default review for entries
without one? How would one convert the ratings to a 5-star scale? And
what does all of this mean for more complex real-world cases,
exemplified by this excerpt from [a real GitHub API][events_api]
response:

[events_api]: https://api.github.com/users/mahmoud/events

<a id="github_event_data"></a>

```json
[{
    "id": "3165090957",
    "type": "PushEvent",
    "actor": {
      "id": 130193,
      "login": "mahmoud",
      "gravatar_id": "",
      "url": "https://api.github.com/users/mahmoud",
      "avatar_url": "https://avatars.githubusercontent.com/u/130193?"
    },
    "repo": {
      "id": 8307391,
      "name": "mahmoud/boltons",
      "url": "https://api.github.com/repos/mahmoud/boltons"
    },
    "payload": {
      "push_id": 799258895,
      "size": 1,
      "distinct_size": 1,
      "ref": "refs/heads/master",
      "head": "27a4bc1b6d1da25a38fe8e2c5fb27f22308e3260",
      "before": "0d6486c40282772bab232bf393c5e6fad9533a0e",
      "commits": [
        {
          "sha": "27a4bc1b6d1da25a38fe8e2c5fb27f22308e3260",
          "author": {
            "email": "mahmoud@hatnote.com",
            "name": "Mahmoud Hashemi"
          },
          "message": "switched reraise_visit to be just a kwarg",
          "distinct": true,
          "url": "https://api.github.com/repos/mahmoud/boltons/commits/27a4bc1b6d1da25a38fe8e2c5fb27f22308e3260"
        }
      ]
    },
    "public": true,
    "created_at": "2015-09-21T10:04:37Z"
}]
```

The astute reader will spot some inconsistency and general complexity,
but don't run away.

<big>**Remap**, the [recursive][recursive] [map][map], is here to save the day.</big>

[recursive]: https://en.wikipedia.org/wiki/Recursion_(computer_science)
[map]: https://docs.python.org/2/library/functions.html#map

Remap is a Pythonic traversal utility that creates a transformed copy
of your nested data. It uses three callbacks -- `visit`, `enter`, and
`exit` -- and is designed to accomplish the vast majority of tasks by
passing only one function, usually `visit`. [The API docs have full
descriptions][remap_rtd], but the basic rundown is:

  * `visit` transforms an individual item
  * `enter` controls how container objects are created and traversed
  * `exit` controls how new container objects are populated

It may sound complex, but the examples shed a lot of light. So let's
get remapping!

[remap_rtd]: http://boltons.readthedocs.org/en/latest/iterutils.html#boltons.iterutils.remap

# Normalize keys and values

First, let's import the modules and data we'll need.

```python
import json
import yaml  # https://pypi.python.org/pypi/PyYAML
from boltons.iterutils import remap  # https://pypi.python.org/pypi/boltons

review_map = yaml.load(media_reviews)

event_list = json.loads(github_events)
```

Now let's turn back to that GitHub API data. Earlier one may have been
annoyed by the inconsistent type of `id`. `event['repo']['id']` is an
integer, but `event['id']` is a string. When sorting events by ID, you
would not want [string ordering][string_order].

With remap, fixing this sort inconsistency couldn't be easier:

```python
def visit(path, key, value):
    if key == 'id':
        return key, int(value)
    return key, value

remapped = remap(event_list, visit=visit)

assert remapped[0]['id'] == 3165090957

# You can even do it in one line:
remap(event_list, lambda p, k, v: (k, int(v)) if k == 'id' else (k, v))
```

By default, `visit` gets called on every item in the root structure,
including [lists][list], [dicts][dict], and other containers, so let's take a closer
look at its signature. `visit` takes three arguments we're going to
see in all of remap's callbacks:

[list]: https://docs.python.org/2/tutorial/datastructures.html#more-on-lists
[dict]: https://docs.python.org/2/tutorial/datastructures.html#dictionaries
[tuple]: https://docs.python.org/2/tutorial/datastructures.html#tuples-and-sequences

  * `path` is a [tuple][tuple] of keys leading up to the current item
  * `key` is the current item's key
  * `value` is the current item's value

`key` and `value` are exactly what you would expect, though it may
bear mentioning that the `key` for a list item is its index. `path`
refers to the keys of all the parents of the current item, not
including the `key`. Looking at
[the GitHub event data](#github_event_data), for the commit author's
name the path is `(0, 'payload', 'commits', 0, 'author')`, because the
key, `name`, is located in the author of the first commit in the
payload of the first event.

As for the return signature of `visit`, it's very similar to the
input. Just return the new `(key, value)` you want in the remapped
output.

[string_order]: https://en.wikipedia.org/wiki/Lexicographical_order

# Drop empty values

Next up, GitHub's move away from [Gravatars][gravatar] left an
artifact in their API: a blank `'gravatar_id'` key. We can get rid of
that item, and any other blank strings, in a jiffy:

[gravatar]: https://en.wikipedia.org/wiki/Gravatar

```python

drop_blank = lambda p, k, v: v != ""
remapped = remap(event_list, visit=drop_blank)

assert 'gravatar_id' not in remapped[0]['actor']
```

Unlike the previous example, instead of a `(key, value)` pair, this
`visit` is returning a `bool`. For added convenience, when `visit`
returns `True`, `remap` carries over the original item
unmodified. Returning `False` drops the item from the remapped structure.

With the ability to arbitrarily transform items, pass through old
items, and drop items from the remapped structure, it's clear that the
`visit` function makes the majority of recursive transformations
trivial. So many tedious and error-prone lines of traversal code turn
into one-liners that usually `remap` with a `visit` callback is all
one needs. With that said, the next recipes focus on `remap`'s more
advanced callable arguments, `enter` and `exit`.

# Convert dictionaries to OrderedDicts

So far we've looked at actions on remapping individual items, using
the `visit` callable. Now we turn our attention to actions on
containers, the parent objects of individual items. We'll start doing
this by looking at the `enter` argument to `remap`.

```python
# from collections import OrderedDict
from boltons.dictutils import OrderedMultiDict as OMD

def enter(path, key, value):
    if isinstance(value, dict):
        return OMD(), sorted(value.items())
    return default_enter(path, key, value)

remapped = remap(review_list, enter=enter)
assert remapped['reviews'].keys()[0] == 'movies'
# True because 'reviews' is now ordered and 'movies' comes before 'shows'
```

The `enter` callable controls both if and how an object is
traversed. Like `visit`, it accepts `path`, `key`, and `value`. But
instead of `(key, value)`, it returns a tuple of `(new_parent,
items)`. `new_parent` is the container that will receive items
remapped by the `visit` callable. `items` is an iterable of `(key,
value)` pairs that will be passed to `visit`. Alternatively, `items`
can be `False`, to tell remap that the current value should not be
traversed, but that's getting pretty advanced. The API docs have some
other `enter` details to consider.

Also note how this code builds on the default remap logic by calling
through to the `default_enter` function, imported from the same place
as `remap` itself. Most practical use cases will want to do this, but
of course the choice is yours.

# Sort all lists

The last example used `enter` to interact with containers before they
were being traversed. This time, to sort all lists in a structure,
we'll use the `remap`'s final callable argument: `exit`.

```python

from boltons.iterutils import remap, default_exit

def exit(path, key, old_parent, new_parent, new_items):
    ret = default_exit(path, key, old_parent, new_parent, new_items)
    if isinstance(ret, list):
        ret.sort()
    return ret

remap(review_list, exit=exit)
```

Similar to the `enter` example, we're building on `remap`'s default
behavior by importing and calling `default_exit`. Looking at the
arguments passed to `exit` and `default_exit`, there's the `path` and
`key` that we're used to from `visit` and `enter`. `value` is there,
too, but it's named `old_parent`, to differentiate it from the new
value, appropriately called `new_parent`. At the point `exit` is
called, `new_parent` is just an empty structure as constructed by
`enter`, and `exit`'s job is to fill that new container with
`new_items`, a list of `(key, value)` pairs returned by `remap`'s
calls to `visit`. Still with me?

Either way, here we don't interact with the arguments. We just call
`default_exit` and work on its return value, `new_parent`, sorting it
in-place if it's a `list`. Pretty simple! In fact, *very* attentive
readers might point out this can be done with `visit`, because
`remap`'s very next step is to call `visit` with the
`new_parent`. You'll have to forgive the contrived example and let it
be a testament to the rarity of overriding `exit`. Without going into
the details, `enter` and `exit` are most useful when teaching `remap`
how to traverse nonstandard containers, such as non-iterable Python
objects. As mentioned in the ["drop empty values"](#drop_empty_values)
example, `remap` is designed to maximize the mileage you get out of
the `visit` callback. Let's look at an advanced usage reason that's
true.

# Collect interesting values

Sometimes you just want to traverse a nested structure, and you don't
need the result. For instance, if we wanted to collect the full set of
tags used in media reviews. Let's create a `remap`-based function,
`get_all_tags`:

```python

from boltons.iterutils import remap

def get_all_tags(root):
    all_tags = set()

    def visit(path, key, value):
        all_tags.update(value['tags'])
        return False

    remap(root, visit=visit, reraise_visit=False)

    return all_tags

print(get_all_tags(review_map))
# set(['space', 'comedy', 'life'])
```

Like the first recipe, we've used the `visit` argument to `remap`, and
like the second recipe, we're just returning `False`, because we don't
actually care about contents of the resulting structure.

What's new here is the `reraise_visit=False` keyword argument, which
tells `remap` to **keep** any item that causes a `visit` exception. This
practical convenience lets `visit` functions be shorter, clearer, and
just more <acronym title="Easier to Ask Forgiveness than
Permission">[EAFP][eafp]</acronym>. Reducing the example to a
one-liner is left as an exercise to the reader.

[eafp]: https://en.wikipedia.org/wiki/Python_syntax_and_semantics#Exceptions

# Add common keys

As a final advanced `remap` example, let's look at adding items to
structures. Through the examples above, we've learned that `visit` is
best-suited for 1:1 transformations and dropping values. This leaves
us with two main approaches for addition. The first uses the `enter`
callable and is suitable for making data consistent and adding data
which can be overridden.

```python

base_review = {'title': '',
               'rating': None,
               'review': '',
               'tags': []}

def enter(path, key, value):
    new_parent, new_items = default_enter(path, key, value)
    try:
        new_parent.update(base_obj)
    except:
        pass
    return new_parent, new_items

remapped = remap(review_list, enter=enter)

assert review_list['shows'][1]['review'] == ''
# True, the placeholder review is holding its place
```

The second method uses the `exit` callback to override values and
calculate new values from the new data.

```python
def exit(path, key, old_parent, new_parent, new_items):
    ret = default_exit(path, key, old_parent, new_parent, new_items)
    try:
        ret['review_length'] = len(ret['review'])
    except:
        pass
    return ret

remapped = remap(review_list, exit=exit)

assert remapped['shows'][0]['review_length'] == 27
assert remapped['movies'][0]['review_length'] == 42
# True times two.
```

By now you might agree that `remap` is making such feats positively
routine. Come for the nested data manipulation, stay for the
[number jokes][forty_two].

[forty_two]: https://en.wikipedia.org/wiki/Phrases_from_The_Hitchhiker's_Guide_to_the_Galaxy#Answer_to_the_Ultimate_Question_of_Life.2C_the_Universe.2C_and_Everything_.2842.29

# Corner cases

This whole guide has focused on data that came from "real-world"
sources, such as JSON API responses. But there are certain rare cases
which typically only arise from within Python code:
[self-referential objects][self_ref_loops]. These are objects that
contain references to themselves or their parents. Have a look at this
trivial example:

```python

self_ref = []
self_ref.append(self_ref)
```

The experienced programmer has probably seen this before, but most
Python coders might even think the second line is an error. It's a
list containing itself, and it has the rather cool [repr][repr]:
`[[...]]`.

Now, this is pretty rare, but reference loops do come up in
programming. The *good* news is that remap handles these just fine:

```python
print(repr(remap(self_ref)))
# prints "[[...]]"
```

The more common corner case that arises is that of duplicate
references, which remap also handles with no problem:

```python
my_set = set()

dupe_ref = (my_set, [my_set])
remapped = remap(dupe_ref)

assert remapped[0] is remapped[-1][-1]
# True, of course
```

Two references to the same set go in, two references to a copy of that
set come out. That's right: only one copy is made, and then used
twice, preserving the original structure.

[self_ref_loops]: http://pythondoeswhat.blogspot.com/2015/09/loopy-references.html
[repr]: https://docs.python.org/2/reference/datamodel.html#object.__repr__

# Wrap-up

If you've made it this far, then I hope you'll agree that `remap` is
useful enough to be your new friend. If that wasn't enough detail,
then there's always [the docs][remap_rtd]. `remap` is
[well-tested][iterutils_tests], but making something this
general-purpose is a tricky area. Please
[file bugs and requests][issues]. Don't forget about [pprint][pprint]
and [repr][repr_mod]/[reprlib][reprlib], which can help with reading
large structures.

<a href="https://commons.wikimedia.org/wiki/File:First_matryoshka_museum_doll_open.jpg">
<img src="/uploads/First_matryoshka_museum_doll_open.jpg">
</a>

[iterutils_tests]: https://github.com/mahmoud/boltons/blob/master/tests/test_iterutils.py
[issues]: https://github.com/mahmoud/boltons/issues
[pprint]: https://docs.python.org/2/library/pprint.html
[repr_mod]: https://docs.python.org/2/library/repr.html
[reprlib]: https://docs.python.org/3/library/reprlib.html


<!-- TODO: closing matroska image -->

<!--
"""The marker approach to solving self-reference problems in remap
won't work because we can't rely on exit returning a
traversable, mutable object. We may know that the marker is in the
items going into exit but there's no guarantee it's not being
filtered out or being made otherwise inaccessible for other reasons.

On the other hand, having enter return the new parent instance
before it's populated is a pretty workable solution. The division of
labor stays clear and exit still has some override powers. Also
note that only mutable structures can have self references (unless
getting really nasty with the Python C API). The downside is that
enter must do a bit more work and in the case of immutable
collections, the new collection is discarded, as a new one has to be
created from scratch by exit. The code is still pretty clear
overall.

Not that remap is supposed to be a speed demon, but here are some
thoughts on performance. Memorywise, the registry grows linearly with
the number of collections. The stack of course grows in proportion to
the depth of the data. Many intermediate lists are created, but for
most data list comprehensions are much faster than generators (and
generator expressions). The ABC isinstance checks are going to be dog
slow. As soon as a couple large enough use case cross my desk, I'll be
sure to profile and optimize. It's not a question of if isinstance+ABC
is slow, it's which pragmatic alternative passes tests while being
faster.

## Remap design principles

Nested structures are common. Virtually all compact Python iterative
interaction is flat (list comprehensions, map/filter, generator
expressions, itertools, even other iterutils). remap is a succinct
solution to both quick and dirty data wrangling, as well as expressive
functional interaction with nested structures.

* visit() should be able to handle 80% of my pragmatic use cases, and
  the argument/return signature should be similarly pragmatic.
* enter()/exit() are for more advanced use cases and the signature can
  be more complex.
* 95%+ of applications should be covered by passing in only one
  callback.
* Roundtripping should be the default. Don't repeat the faux pas of
  HTMLParser where, despite the nice SAX-like interface, it is
  impossible (or very difficult) to regenerate the input. Roundtripped
  results compare as equal, realistically somewhere between copy.copy
  and copy.deepcopy.
* Leave streaming for another day. Generators can be handy, but the
  vast majority of data is of easily manageable size. Besides, there's
  no such thing as a streamable dictionary.

"""

-->
