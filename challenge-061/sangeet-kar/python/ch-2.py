#!/usr/bin/env python

import sys
from itertools import product


def to_ipv4(str):
    return [".".join(xs)
            for xs
            in ([str[:i], str[i:i+j], str[i+j:i+j+k], str[i+j+k:]]
                for i, j, k
                in product([1, 2, 3], repeat=3))
            if all(is_valid(x) for x in xs)]


def is_valid(s):
    return s and (s == "0" or not s.startswith("0")) and (0 <= int(s) <= 255)


input_str = "25525511135" if len(sys.argv) < 2 else sys.argv[1]

for addr in to_ipv4(input_str):
        print(addr)

