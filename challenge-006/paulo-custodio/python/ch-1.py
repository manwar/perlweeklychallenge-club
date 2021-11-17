#!/usr/bin/env python3

# Challenge 006
#
# Challenge #1
# Create a script which takes a list of numbers from command line and print the
# same in the compact form. For example, if you pass "1,2,3,4,9,10,14,15,16"
# then it should print the compact form like "1-4,9,10,14-16".

import sys

nums = sorted([int(x) for x in sys.argv[1].split(",")])
output = ""
while nums:
    n = nums.pop(0)
    output += str(n)
    if len(nums)>1 and nums[0]==n+1 and nums[1]==n+2:
        while len(nums)>0 and nums[0]==n+1:
            n = nums.pop(0)
        output += "-"+str(n)
    if nums:
        output += ","
print(output)
