#!/usr/bin/env python
# -*- coding: utf-8 -*-


def is_self_descriptive(num):
    str_num = str(num)
    length = len(str_num)

    for i in range(length):
        if str_num.count(str(i)) != int(str_num[i]):
            return False

    return True


def find_self_descriptive(n):
    found = 0
    num = 0
    while found < n:
        if is_self_descriptive(num):
            print(num)
            found += 1
        num += 1


find_self_descriptive(3)
