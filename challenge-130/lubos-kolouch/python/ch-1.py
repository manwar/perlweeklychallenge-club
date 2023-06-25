#!/usr/bin/env python
# -*- coding: utf-8 -*-

from functools import reduce
from operator import xor

N = [2, 5, 4, 4, 5, 5, 2]
odd = reduce(xor, N)
print(odd)
