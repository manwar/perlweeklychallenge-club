#!/usr/bin/env python
# -*- coding: utf-8 -*-

def count_operations(lst):
    count = 0
    while lst:
        if lst[0] == min(lst):
            lst.pop(0)
        else:
            lst.append(lst.pop(0))
        count += 1
    return count


print(count_operations([3, 4, 2]))  # Output: 5
print(count_operations([1, 2, 3]))  # Output: 3
