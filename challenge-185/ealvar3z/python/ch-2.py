# -*- coding: utf-8 -*-
#!/usr/bin/env python3
"""
You are given a list of codes in many random format.

Write a script to mask first four characters (a-z,0-9) and keep the rest as it is.

Example 1
Input: @list = ('ab-cde-123', '123.abc.420', '3abc-0010.xy')
Output: ('xx-xxe-123', 'xxx.xbc.420', 'xxxx-0010.xy')

Example 2
Input: @list = ('1234567.a', 'a-1234-bc', 'a.b.c.d.e.f')
Output: ('xxxx567.a', 'x-xxx4-bc', 'x.x.x.x.e.f')
"""

import argparse
import re

p = argparse.ArgumentParser(description='Perl Weekly Challenge 185')
p.add_argument(
        "-s",
        nargs="?",
        type=str,
        default="1234567.a")

args = p.parse_args()

mask = re.compile(r"[a-z0-9]")

print(re.sub(mask, 'x', args.s, count=4))
