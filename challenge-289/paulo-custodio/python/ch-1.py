#!/usr/bin/env python3

import sys

nums = sorted(set(map(int, sys.argv[1:])), reverse=True)
print(nums[2] if len(nums) > 2 else nums[0])
