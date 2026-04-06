#!/usr/bin/env python3

# Perl Weekly Challenge 170 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-170/

import sys
import re

def parse_matrix(line):
    mx = []
    while re.match(r'^\s*$', line):
        line = sys.stdin.readline()
    line, count = re.subn(r'^\s*\w+\s*=\s*', '', line)
    if count == 0:
        raise ValueError("assignment expected")
    while found := re.match(r'^\s*\[([\d\s]+)\]\s*$', line):
        row = [int(x) for x in found.group(1).split()]
        mx.append(row)
        line = sys.stdin.readline()
    return mx, line

def parse_input():
    line = sys.stdin.readline()
    a, line = parse_matrix(line)
    b, line = parse_matrix(line)
    return a, b

def print_matrix(mx):
    for i in range(len(mx)):
        row = mx[i]
        pfx = "[" if i==0 else " "
        sfx = "," if i<len(mx)-1 else "]"
        print(pfx+"[ "+ ", ".join([str(x) for x in row]) +" ]"+sfx)

def kronecker_product(a, b):
    wa = len(a[0])
    ha = len(a)
    wb = len(b[0])
    hb = len(b)
    prod = [[0 for _ in range(wa*wb)] for _ in range(ha*hb)]
    for ar in range(ha):
        for ac in range(wa):
            for br in range(hb):
                for bc in range(wb):
                    tr = ar*hb + br
                    tc = ac*wb + bc
                    prod[tr][tc] = a[ar][ac] * b[br][bc]
    return prod

a, b = parse_input()
p = kronecker_product(a, b)
print_matrix(p)
