#!/usr/bin/env python
# -*- coding: utf-8 -*-


def add_10(x):
    return x + 10


def multiply_2(x):
    return x * 2


def compose(f, g):
    return lambda x: f(g(x))


h = compose(add_10, multiply_2)

print(h(5))  # 20
