#!/usr/bin/env python3

def double_exist(n):
    for i in range(len(n) - 1):
        for j in range(i + 1, len(n)):
            if n[i] == 2 * n[j] or n[j] == 2 * n[i]:
                return True
    return False

import sys
print("true" if double_exist(list(map(int, sys.argv[1:]))) else "false")
