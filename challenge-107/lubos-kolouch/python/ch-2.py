#!/usr/bin/env python
# -*- coding: utf-8 -*-

import inspect


class Calc:
    def add(self):
        pass

    def mul(self):
        pass

    def div(self):
        pass


# Get all methods in class Calc
methods = inspect.getmembers(Calc, predicate=inspect.isfunction)
for method in methods:
    print(method[0])
