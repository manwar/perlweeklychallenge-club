#!/usr/bin/env python
# -*- coding: utf-8 -*-

def calculate(expression):
    return eval(expression)


print(calculate("10 + 20 - 5"))  # Outputs: 25
print(calculate("(10 + 20 - 5) * 2"))  # Outputs: 50
