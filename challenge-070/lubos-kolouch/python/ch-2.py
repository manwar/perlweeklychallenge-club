#!/usr/bin/env python
# -*- coding: utf-8 -*-

N = 4
gray_code = ["0", "1"]

for i in range(2, N + 1):
    rev_gray_code = gray_code[::-1]
    gray_code = ["0" + x for x in gray_code]
    rev_gray_code = ["1" + x for x in rev_gray_code]
    gray_code += rev_gray_code

gray_code = [int(x, 2) for x in gray_code]
print(gray_code)
