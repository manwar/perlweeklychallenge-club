#!/usr/bin/env python
# -*- coding: utf-8 -*-


def pythagorean_triples(N):
    found = False
    for a in range(1, N + 1):
        for b in range(a, N + 1):
            c = (a**2 + b**2) ** 0.5
            if c.is_integer():
                c = int(c)
                if a == N or b == N or c == N:
                    print((a, b, c))
                    found = True
    if not found:
        print(-1)


pythagorean_triples(5)
pythagorean_triples(13)
pythagorean_triples(1)
