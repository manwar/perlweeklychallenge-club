#!/usr/bin/env python
# -*- coding: utf-8 -*-

def count_deletions(strings):
    count = 0
    for s in strings:
        if s != ''.join(sorted(s)) and s != ''.join(sorted(s, reverse=True)):
            count += 1
    return count


str1 = ["abc", "bce", "cae"]
print(count_deletions(str1))  # Output: 1

str2 = ["yxz", "cba", "mon"]
print(count_deletions(str2))  # Output: 2
