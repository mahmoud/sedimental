---
title: 'Remap: Nested Data Multitool for Python'
---

> *This entry is the first in a series of "cookbooklets" showcasing
> some of the more advanced [Boltons][boltons]. If all goes well, the
> next 5 minutes minutes will literally save you 5 hours.*

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
      tags: ['comedy', 'space', 'life']
    - title: Monty Python's Meaning of Life
      rating: 7
      review: Better than Brian, but not a Holy Grail, nor Completely Different.
      tags: ['comedy', 'life']
```

And yet even this very straightforwardly nested data can be a hassle
to manipulate. So what does one do with a more complex real-world
case, exemplified by this excerpt from [a real GitHub API][events_api]
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

The astute reader will spot multiple inconsistencies and general complexity,
but don't run away.

<big>**Remap**, the [recursive][recursive] [map][map], is here to save the day.</big>

[recursive]: https://en.wikipedia.org/wiki/Recursion_(computer_science)
[map]: https://docs.python.org/2/library/functions.html#map

# Normalize keys and values

First, let's create some Python references from the above.

```python
import json
import yaml  # https://pypi.python.org/pypi/PyYAML

review_map = yaml.load(media_reviews)

event_list = json.loads(github_events)
```

The keen-eyed reader may have been noticed (and subsequently annoyed)
by the inconsistent type of `id` in GitHub's
API. `event['repo']['id']` is an integer, but `event['id']` is a
string. In the event you wanted to compare two events' IDs, you would
definitely not want to do [string comparison][string_cmp].

With remap this sort of operation couldn't be easier:

```python
def visit(path, key, value):
    if key == 'id':
        return key, int(value)
    return key, value

remap(event_list, visit=visit)

# You can even do it in one line:
remap(event_list, lambda p, k, v: (k, int(v)) if k == 'id' else (k, v))
```

[string_cmp]: https://en.wikipedia.org/wiki/Lexicographical_order

# Drop empty values

# Convert dictionaries to OrderedDicts

# Sort all lists

# Collect interesting values

# Add a common key

# Corner cases

This whole guide has focused on data that came from "real-world"
sources, such as JSON API responses. But there are certain rare cases
which typically only arise from within Python code. Have a look:

```python

self_ref = []
self_ref.append([])
```

The experienced programmer has probably seen this before, but most
Python coders might even thinnk the second line is an error. It's a
list containing itself, and it has the rather cool [`repr`][repr]:
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
my_obj = object()

dupe_ref = (my_obj, [my_obj])
remapped = remap(dupe_ref)

assert remapped[0] is remapped[-1][-1]
# True
```

[repr]: https://docs.python.org/2/reference/datamodel.html#object.__repr__

# Wrap-up
