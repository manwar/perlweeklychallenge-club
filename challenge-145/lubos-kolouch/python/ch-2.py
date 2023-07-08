#!/usr/bin/env python
# -*- coding: utf-8 -*-


def palindromic_tree(s):
    result = []
    for i in range(len(s)):
        for j in range(i + 1, len(s) + 1):
            substring = s[i:j]
            if substring == substring[::-1]:
                result.append(substring)
    return result


s = "redivider"
print(
    palindromic_tree(s)
)  # Output: ['r', 'redivider', 'e', 'edivide', 'd', 'divid', 'i', 'ivi', 'v']

s = "deific"
print(palindromic_tree(s))  # Output: ['d', 'e', 'i', 'ifi', 'f', 'c']
