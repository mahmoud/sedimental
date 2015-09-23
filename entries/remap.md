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

UI fads aside, developers have always liked flat. Even Python, so
often turned to for data wrangling, only has succinct constructs for
dealing with flat data. List comprehension, generator expressions,
map/filter, and itertools are all built for working with flat. In
fact, the allure of "flat" data is likely a direct result of this
common gap in most programming languages.

So let's meet this adversary. Provided you overlook my taste in media,
it's hard to fault nested data when it reads as well as this YAML:

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
would definitely not want to do [string ordering][string_order].

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

[string_order]: https://en.wikipedia.org/wiki/Lexicographical_order

# Drop empty values

Next up, GitHub's dropping of Gravatars left an artifact in their API:
a blank `'gravatar_id'` key. We can get rid of that item, and any
other blank strings, in a jiffy:

```python

drop_blank = lambda p, k, v: v != ""
remapped = remap(event_list, visit=drop_blank)

assert 'gravatar_id' not in remapped[0]['actor']
```

When `visit` returns a single `bool` instead of a `(key, value)` pair,
`True` carries over the original item unmodified and `False` drops the
item from the remapped structure.

# Convert dictionaries to OrderedDicts

```python
# from collections import OrderedDict
from boltons.dictutils import OrderedMultiDict as OMD

def enter(path, key, value):
    if isinstance(value, dict):
        return OMD(), sorted(value.items())
    return default_enter(path, key, value)
```

# Sort all lists

```python
def exit(*a, **kw):
    ret = default_exit(*a, **kw)
    if isinstance(ret, list):
        ret.sort()
    return ret

remap(review_list, exit=exit)
```

# Collect interesting values

```python
all_tags = set()

def enter(path, key, value):
    try:
        all_tags.update(value['tags'])
    except:
        pass
    return default_enter(path, key, value)

remap(review_map, enter=enter)

print(all_tags)
# set(['space', 'comedy', 'life'])
```

# Add common keys

There are two ways to add to structures within your target. The first
uses the `enter` callable and is suitable for making data consistent
and adding data which can be overriden.

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

# Corner cases

This whole guide has focused on data that came from "real-world"
sources, such as JSON API responses. But there are certain rare cases
which typically only arise from within Python code:
[self-referential objects][self_ref_loops]. These are objects that
contain references to themselves or their parents. Have a look at this
trivial example:

```python

self_ref = []
self_ref.append([])
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

Go nuts. File bugs. pprint is your friend.

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

TODO Examples:

  * sort all lists
  * normalize all keys
  * convert all dicts to OrderedDicts
  * drop all Nones

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
