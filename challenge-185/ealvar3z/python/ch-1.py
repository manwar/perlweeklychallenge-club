#!/usr/bin/env python3

import argparse
import re

"""
You are given MAC address in the form i.e. hhhh.hhhh.hhhh.

Write a script to convert the address in the form hh:hh:hh:hh:hh:hh.
Example 1

Input:  1ac2.34f0.b1c2
Output: 1a:c2:34:f0:b1:c2

Example 2

Input:  abc1.20f1.345a
Output: ab:c1:20:f1:34:5a
"""

if __name__ == '__main__':
    p = argparse.ArgumentParser(description='Perl Weekly Challenge 185')
    p.add_argument(
        "-m",
        nargs="?",
        type=str,
        default="1ac2.34f0.b1c2",
        help="MAC address"
    )

    args = p.parse_args()

    print(":".join(re.findall('..', '%012s' % args.m)))