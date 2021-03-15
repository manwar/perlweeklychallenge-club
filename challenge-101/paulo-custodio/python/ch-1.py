#!/usr/bin/env python

# Challenge 101
#
# TASK #1 > Pack a Spiral
# Submitted by: Stuart Little
#
# You are given an array @A of items (integers say, but they can be anything).
#
# Your task is to pack that array into an MxN matrix spirally counterclockwise,
# as tightly as possible.
#
# 'Tightly' means the absolute value |M-N| of the difference has to be as small
# as possible.

import sys
import math

def spiral(numbers):

    # find max width of elements, convert to int
    def max_width(numbers):
        num_width = 1
        for i in range(0, len(numbers)):
            if len(numbers[i]) < num_width:
                num_width = len(numbers[i])
            numbers[i] = int(numbers[i])
        return num_width

    # find out m,n
    def smallest_rect(n):
        l, h = 1, n
        for i in range(1, int(math.sqrt(n)+1)):
            if ((n % i) == 0):
                l, h = i, int(n / i)
        return l, h

    # build empty rectangle
    rect = []
    def build_rect(numbers):
        m, n = smallest_rect(len(numbers))
        for r in range (0, m+1):
            rect.append(["" for c in range(0, n+1)])
        return m, n

    # build spiral rectangle
    num_width = max_width(numbers)
    m, n = build_rect(numbers)

    r, c = m, 1
    i = 0
    while (i < len(numbers)):
        # go East
        while (c <= n):
            if (rect[r][c] != ""):
                break
            rect[r][c] = ("{:"+str(num_width+1)+"d}").format(numbers[i])
            i += 1
            c += 1
        c -= 1
        r -= 1
        # go North
        while (r >= 1):
            if (rect[r][c] != ""):
                break
            rect[r][c] = ("{:"+str(num_width+1)+"d}").format(numbers[i])
            i += 1
            r -= 1
        r += 1
        c -= 1
        # go West
        while (c >= 1):
            if (rect[r][c] != ""):
                break
            rect[r][c] = ("{:"+str(num_width+1)+"d}").format(numbers[i])
            i += 1
            c -= 1
        c += 1
        r += 1
        # go South
        while (r <= m):
            if (rect[r][c] != ""):
                break
            rect[r][c] = ("{:"+str(num_width+1)+"d}").format(numbers[i])
            i += 1
            r += 1
        r -= 1
        c += 1

    for r in range (1, m+1):
        output = ""
        for c in range (1, n+1):
            output += rect[r][c]
        print(output)

# main
numbers = sys.argv[1:]
spiral(numbers)
