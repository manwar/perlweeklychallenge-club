#!/usr/bin/env python
# -*- coding: utf-8 -*-

def is_additive(s):
    for i in range(1, len(s)):
        for j in range(i + 1, len(s)):
            part1 = s[:i]
            part2 = s[i:j]
            if (len(part1) > 1 and part1[0] == '0') or (len(part2) > 1 and part2[0] == '0'):
                continue
            while j < len(s):
                part3 = str(int(part1) + int(part2))
                if not s.startswith(part3, j):
                    break
                j += len(part3)
                part1, part2 = part2, part3
            if j == len(s):
                return True
    return False


print(is_additive("112358"))  # Output: True
print(is_additive("12345"))   # Output: False
print(is_additive("199100199"))  # Output: True
