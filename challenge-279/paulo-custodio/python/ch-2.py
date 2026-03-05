#!/usr/bin/env python3

import sys

str_input = " ".join(sys.argv[1:])
vowels = sum(1 for char in str_input if char in "aeiouAEIOU")
print("true" if vowels % 2 == 0 else "false")
