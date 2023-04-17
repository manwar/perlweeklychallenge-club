#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List, Union


def find_noble_integer(lst: List[int]) -> Union[int, None]:
    lst.sort()

    for i in range(len(lst) - 1):
        if lst[i] == lst[i + 1]:
            continue
        if lst[i] == len(lst) - i - 1:
            return lst[i]
    return None


if __name__ == "__main__":
    L = [2, 6, 1, 3]
    noble_integer = find_noble_integer(L)

    if noble_integer is not None:
        print("Noble Integer:", noble_integer)
    else:
        print("No Noble Integer found")
