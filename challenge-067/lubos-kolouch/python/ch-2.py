#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def letter_combinations(s: str) -> List[str]:
    phone = {
        '2': ['a', 'b', 'c'],
        '3': ['d', 'e', 'f'],
        '4': ['g', 'h', 'i'],
        '5': ['j', 'k', 'l'],
        '6': ['m', 'n', 'o'],
        '7': ['p', 'q', 'r', 's'],
        '8': ['t', 'u', 'v'],
        '9': ['w', 'x', 'y', 'z'],
    }

    result = ['']

    for digit in s:
        new_result = []
        for res in result:
            for letter in phone[digit]:
                new_result.append(res + letter)
        result = new_result

    return result


s = '35'
combinations_list = letter_combinations(s)
print("[", ", ".join(f'"{comb}"' for comb in combinations_list), "]")
