#!/usr/bin/python3

# Challenge 141
#
# TASK #2 > Like Numbers
# Submitted by: Mohammad S Anwar
# You are given positive integers, $m and $n.
#
# Write a script to find total count of integers created using the digits
# of $m which is also divisible by $n.
#
# Repeating of digits are not allowed. Order/Sequence of digits can't be
# altered. You are only allowed to use (n-1) digits at the most. For example,
# 432 is not acceptable integer created using the digits of 1234. Also for
# 1234, you can only have integers having no more than three digits.
#
# Example 1:
# Input: $m = 1234, $n = 2
# Output: 9
#
# Possible integers created using the digits of 1234 are:
# 1, 2, 3, 4, 12, 13, 14, 23, 24, 34, 123, 124, 134 and 234.
#
# There are 9 integers divisible by 2 such as:
# 2, 4, 12, 14, 24, 34, 124, 134 and 234.
# Example 2:
# Input: $m = 768, $n = 4
# Output: 3
#
# Possible integers created using the digits of 768 are:
# 7, 6, 8, 76, 78 and 68.
#
# There are 3 integers divisible by 4 such as:
# 8, 76 and 68.

import sys

def numbers(num):
    ret = []
    mask_n = 0
    while True:
        mask = ("{:0"+str(len(str(num)))+"b}").format(mask_n)
        if len(mask) > len(str(num)):
            break

        # combine num with mask
        res = 0
        for i in range(len(str(num))):
            if mask[i] == "1":
                res = 10*res + int(str(num)[i])

        ret.append(res)
        mask_n += 1

    return ret

m = int(sys.argv[1])
n = int(sys.argv[2])
count = 0
for num in numbers(m):
    if num != 0 and num != m:
        if num % n == 0:
            count += 1
print(count)
