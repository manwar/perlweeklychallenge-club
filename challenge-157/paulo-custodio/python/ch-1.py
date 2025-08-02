#!/usr/bin/env python3

# Challenge 157
#
# TASK #1 > Pythagorean Means
# Submitted by: Mohammad S Anwar
# You are given a set of integers.
#
# Write a script to compute all three Pythagorean Means i.e Arithmetic Mean,
# Geometric Mean and Harmonic Mean of the given set of integers. Please refer
# to wikipedia page for more informations.
#
# Example 1:
# Input: @n = (1,3,5,6,9)
# Output: AM = 4.8, GM = 3.8, HM = 2.8
# CORRECTION [2022-03-21 16:35] GM = 3.9 (before)
#
# Example 2:
# Input: @n = (2,4,6,8,10)
# Output: AM = 6.0, GM = 5.2, HM = 4.4
# Example 3:
# Input: @n = (1,2,3,4,5)
# Output: AM = 3.0, GM = 2.6, HM = 2.2

import sys
import numpy as np

def am(n):
    return np.sum(n) / len(n)

def gm(n):
    base = abs(np.prod(n))
    exp = 1 / len(n)
    return base ** exp

def hm(n):
    invn = [1/x for x in n]
    return len(invn) / np.sum(invn)

def f(n):
    return f"{n:.1f}"

n = list(map(float, sys.argv[1:]))
if not n:
    raise ValueError("Usage: ch-1.py n...")
print(f"AM = {f(am(n))}, GM = {f(gm(n))}, HM = {f(hm(n))}")
