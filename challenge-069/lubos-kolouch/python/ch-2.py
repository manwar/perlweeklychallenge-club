#!/usr/bin/env python
# -*- coding: utf-8 -*-

def generate_string(n: int) -> str:
    if n == 0:
        return ""
    if n == 1:
        return "0"
    s_n_1 = generate_string(n - 1)
    return s_n_1 + "0" + "".join('0' if c == '1' else '1' for c in s_n_1[::-1])


print(generate_string(30))
