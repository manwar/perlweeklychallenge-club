#!/usr/bin/env python
# -*- coding: utf-8 -*-

S = "perlandraku"
C = 3
O = 4
N = len(S)
S = list(S)

for i in range(1, C + 1):
    x = i % N
    y = (i + O) % N
    S[x], S[y] = S[y], S[x]

S = "".join(S)
print(S)
