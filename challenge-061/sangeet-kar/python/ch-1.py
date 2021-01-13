#!/usr/bin/env python

from functools import reduce
from itertools import islice


def maxprod(lst):
    return max((lst[i:j+1]
                for i in range(len(lst)) for j in range(i, len(lst))),
               key=prod)


def prod(lst):
    return reduce(lambda x, y: x * y, lst, 1)


print(maxprod([2, 3, -5, 1]))

