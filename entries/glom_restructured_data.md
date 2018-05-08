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

## Beyond Access

Many nested data tools simply perform deep gets and searches, stopping
short after solving the problem posed above. Realizing that access
almost always precedes assignment, glom takes the paradigm further,
enabling total declarative transformation of the data.

Starting with access:

```python
from glom import glom

target = {'ohio': {'farm': {'dogs': 2, 'cows': 1}}}

glom(target, 'ohio.farm.dogs')
# 2
```

Let's say we the MacDonalds expand their Ohio farm empire, and `farm`
becomes a list, `farms`:

```python
target = {'ohio': {'farms': [{'dogs': 2, 'cows': 1}, {'dogs': 3, 'cows': 2}]}}

glom(target, ('ohio.farms', ['dogs']))
# [2, 3]
```

And let's say we want to capture counts for `dogs` and `cows`:

```
glom(target, {'cows': ('ohio.farms', ['cows']), 'dogs': ('ohio.farms', ['dogs'])})
# {'cows': [1, 2], 'dogs': [2, 3]}
```

And this is just the beginning.

## Python-Native

Most other implementations are limited to a particular data format or
pure model. glom makes no such sacrifices of practicality, harnessing
the full power of Python itself.

Going back to our example, let's say we wanted to get an aggregate cow
count:

```
glom(target, {'cows': ('ohio.farms', ['cows'], sum)})
# {'cows': 3}
```


## Library first

Tools like jq focus on the console, with a dubious path forward for
further integration. glom's full-featured CLI is only a stepping stone
to using it more extensively inside application logic.




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
