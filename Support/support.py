#!/usr/bin/env python
# support.py -*- python -*-
# General functional support
from __future__ import print_function
from collections import Counter
from functools import partial, reduce, wraps
from itertools import *
from itertools import starmap as istarmap
from operator import add, eq, not_

# MARK: - constants

empty_str = ''
empty_list = []

# MARK: - base

""" The identity function returns its argument. """
id = lambda x: x

""" The constant func yields its initial arg no matter what's given. """
const = lambda x: lambda _: x

""" Compose a list of unary functions.

use:
  compose(f, g, h)(x)  # = f(g(h(x)))
example:
  >>> chradd = lambda i: compose(chr, partial(add, i), ord)
  >>> chradd('a', 1) # = 'b'
  >>> alphabet = [map(addchr(i), ("A", "a")) for i in range(26)]
  [['A', 'a'], ['B', 'b'], ['C', 'c'], ..., ['Z', 'z']]
"""
compose = lambda *fs: reduce(lambda f, g: lambda x: f(g(x)), fs, id)

""" Compose a list of polyadic functions of the same arity. """
starcompose = lambda *fs: reduce(lambda f, g: lambda *t: f(g(*t)), fs, id)

""" Returns the given function in curried form. Use the `@curry`
decorator to define an implicitly curried function.

example:
  >>> cfunc = curry(func)
example using decorator:
  >>> @curry
  ... def add(x, y):
  ...  return x + y
  >>> twoPlus = add(2)
  >>> twoPlus(3)
  5
"""
def curry(func):
  def f(*args, **kws):
    if len(args) + len(kws) >= func.__code__.co_argcount:
      return func(*args, **kws)
    return lambda *_args, **_kws: f(*(args + _args), **dict(kws, **_kws))
  return f

# MARK: - Functions

""" Apply f to every element in an iterable. """
imap = lambda f, iter: map(f, iter)
cmap = curry(map)
cimap = curry(imap)

""" map a function to the "pre-zipped" contents in a list. """
starmap = lambda f, seq: list(istarmap(f, seq))
cstarmap = curry(starmap)

""" map a function to the "pre-zipped" contents in an iterable. """
cistarmap = curry(istarmap)

""" apply a function to the given "pre-zipped" packed container. """
@curry
def cstarapply(f, seq):
  return f(*seq)

""" Reverses the arguments of a function """
flip = lambda f: lambda *x: f(*reversed(x))

# MARK: - Lists

""" check whether a container is empty or not. """
empty = lambda x: not x or False

""" check whether a container is has elements or not. """
nonempty = compose(not_, empty)

""" get the nth element from a list or the last one. """
nth_or_last = lambda i, xs: xs[i] if len(xs) == i+1 else xs[-1]

""" generate a list with the elements satisfying a given predicate. """
cfilter = lambda p: lambda seq: filter(p, seq)

""" compact the lists of a list removing any falsy elements. """
compact = lambda list: [truthy for truthy in list if truthy]

""" concatenates a list of strings intercalating the given separator. """
join = lambda seq, sep='': sep.join(seq)
cjoin = curry(join)

""" removes the first and last elements from a sequence. """
strip = lambda seq: seq[1:-1]
istrip = compose(strip, list)

""" returns the sequence sliced from the start to the given index. """
prefix = lambda seq, end: seq[:end]
iprefix = lambda iter, end: islice(iter, end)
cprefix = curry(prefix)
ciprefix = curry(iprefix)

""" returns the sequence sliced from the given index to the end. """
suffix = lambda seq, start: seq[start:]
isuffix = lambda iter, start: islice(iter, start, None)
csuffix = curry(suffix)
cisuffix = curry(isuffix)

""" flattens a nested iterable. """
flatten = lambda iter: chain.from_iterable(iter)

""" zips `seq` by repeating `scalar` `len(seq)` times. """
zip_scalar = lambda scalar, seq: [(item, scalar) for item in seq]
czip_scalar = curry(zip_scalar)

# MARK: - Relation

""" compares two objects for equality. """
ceq = lambda l: lambda r: eq(l, r)
noteq = lambda l, r: not_(eq(l, r))
cnoteq = lambda l: lambda r: not_(eq(l, r))

# MARK: - Arithmetic

""" return the sum of the two given numbers. """
cadd = curry(add)

# MARK: - Characters

""" return the sum of a character plus the given number number. """
addchr  = lambda n, c: chr(add(n, ord(c)))
caddchr = curry(addchr)
chradd  = flip(addchr)
cchradd = curry(chradd)

# MARK: - combinatorics

""" the sum of all the elements in a "pre-zipped" packed container. """
starsum = lambda pack: sum(*pack)

""" the product of the elements in a "pre-zipped" packed container. """
starproduct = lambda pack: product(*pack)

""" find the r length subsequences of elements of an iterable. """
ccombinations = curry(combinations)

""" calculate the unique permutations of an iterable """
def permutations_uniq(iter):
  def permute(uniq, result, i):
    if i < 0:
      yield tuple(result)
    else:
      for item in uniq:
        if uniq[item] <= 0: continue
        result[i] = item
        uniq[item] -= 1
        for x in permute(uniq, result, i - 1): yield x
        uniq[item] += 1
  uniq = Counter(iter)
  length = sum(uniq.values())
  return permute(uniq, [None] * length, length - 1)

""" the powerset of a list. """
powerset = lambda xs: flatten(combinations(xs, r) for r in range(len(xs) + 1))
ipowerset = compose(powerset, list)

# MARK: - Debug

""" perform side effect. """
@curry
def tap(f, x):
  f(x)
  return x

""" Print sequence with format. """
dump = lambda seq: map(lambda item: print(':'.join(item), ''), seq)
