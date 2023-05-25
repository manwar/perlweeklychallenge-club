#!/usr/bin/env python
# -*- coding: utf-8 -*-

from itertools import permutations

numbers = [1, 2, 3, 4, 5, 6, 7]

for perm in permutations(numbers):
    a, b, c, d, e, f, g = perm
    if sum([a, b]) == sum([b, c, d]) == sum([d, e, f]) == sum([f, g]):
        print(f"a = {a}\nb = {b}\nc = {c}\nd = {d}\ne = {e}\nf = {f}\ng = {g}\n")
        break
